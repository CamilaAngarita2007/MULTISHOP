<?php
/* Funciones compartidas por todos los modelos: sesión, respuestas JSON, precios, archivos,
   notificaciones y moderación. Equivalen a los Services del proyecto en C#. */
require_once __DIR__ . '/../Config/conexion.php';

date_default_timezone_set('America/Bogota');

if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax']);
    session_start();
}

const ROL_CLIENTE = 'Cliente';
const ROL_VENDEDOR = 'Vendedor';
const ROL_ADMIN = 'Admin';

const VENTA_PENDIENTE = 'Pendiente';
const VENTA_EN_PROCESO = 'En proceso';
const VENTA_FINALIZADO = 'Finalizado';
const VENTA_CANCELADA = 'Cancelada';

const ENTREGA_RETIRO = 'RetiroTienda';
const ENTREGA_DOMICILIO_PROPIO = 'DomicilioPropio';
const ENTREGA_DOMICILIO_OTRO = 'DomicilioOtro';

const METODOS_PAGO = ['Contraentrega', 'PSE', 'Tarjeta', 'QR'];

/* Condición SQL de "rebaja vigente" y precio que se cobra hoy, para un producto con alias p.
   La rebaja rige desde el inicio del día de inicio hasta el final del día de fin (ambos inclusive). */
const SQL_REBAJA_VIGENTE = "(p.Rebaja_Temporal = 1 AND p.Precio_Rebajado IS NOT NULL
    AND (p.Fecha_Inicio_Rebaja IS NULL OR DATE(p.Fecha_Inicio_Rebaja) <= NOW())
    AND (p.Fecha_Fin_Rebaja IS NULL OR DATE(p.Fecha_Fin_Rebaja) + INTERVAL 1 DAY > NOW()))";
const SQL_PRECIO_VIGENTE = "(CASE WHEN " . SQL_REBAJA_VIGENTE . " THEN p.Precio_Rebajado ELSE p.Precio END)";

const PALABRAS_PROHIBIDAS = [
    "idiota", "estupido", "estúpido", "maldito", "imbecil", "imbécil",
    "perra", "perro", "puta", "puto", "hijueputa", "hijoeputa", "hp",
    "gonorrea", "malparido", "malparida", "marica", "maricon", "maricón",
    "mierda", "pendejo", "pendeja", "cabron", "cabrón", "zorra",
    "verga", "gilipollas", "culicagado", "guevon", "güevón", "gueva",
    "coño", "chimba", "carechimba", "hijodeputa", "sapa", "sapo"
];

function conexionBD()
{
    static $pdo = null;
    if ($pdo === null) {
        $conexionDB = new conexion();
        $pdo = $conexionDB->conectar();
        $pdo->exec("SET time_zone = '-05:00'");
    }
    return $pdo;
}

function ahora()
{
    return date('Y-m-d H:i:s');
}

/* ---------------------------- Respuestas JSON ---------------------------- */

function responder($codigo, $exito, $mensaje = '', $datos = null)
{
    http_response_code($codigo);
    $respuesta = ["success" => $exito, "message" => $mensaje];
    if ($datos !== null) {
        $respuesta["data"] = $datos;
    }
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);
    exit;
}

/* Errores comunes de todos los endpoints: misma forma que guardarPerfil.php de Club Acerias. */
function manejarError($e)
{
    if ($e instanceof PDOException) {
        if ($e->getCode() == 23000) {
            responder(409, false, "Error: el registro ya existe o está en uso.");
        }
        responder(500, false, "Error de base de datos: " . $e->getMessage());
    }
    if ($e instanceof Error) {
        responder(500, false, "Error interno: " . $e->getMessage());
    }
    $codigo = (int)$e->getCode();
    responder($codigo >= 400 && $codigo < 600 ? $codigo : 400, false, $e->getMessage());
}

/* Lee el cuerpo de la petición: JSON (fetch con JSON.stringify) o formulario multipart (FormData con archivos). */
function leerDatos()
{
    $tipo = $_SERVER['CONTENT_TYPE'] ?? '';
    if (stripos($tipo, 'application/json') !== false) {
        $datos = json_decode(file_get_contents('php://input'), true);
        if (!is_array($datos) || json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Datos inválidos", 400);
        }
        return $datos;
    }
    return $_POST;
}

function exigirPost()
{
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception("Metodo HTTP no permitido", 405);
    }
}

function texto($datos, $campo, $largoMaximo = 1000)
{
    $valor = trim((string)($datos[$campo] ?? ''));
    return mb_substr($valor, 0, $largoMaximo);
}

function entero($datos, $campo, $defecto = 0)
{
    return isset($datos[$campo]) && is_numeric($datos[$campo]) ? (int)$datos[$campo] : $defecto;
}

function decimalONulo($datos, $campo)
{
    return isset($datos[$campo]) && $datos[$campo] !== '' && is_numeric($datos[$campo]) ? round((float)$datos[$campo], 2) : null;
}

function fechaONula($datos, $campo)
{
    $valor = trim((string)($datos[$campo] ?? ''));
    return preg_match('/^\d{4}-\d{2}-\d{2}$/', $valor) ? $valor : null;
}

/* ---------------------------- Sesión ---------------------------- */
