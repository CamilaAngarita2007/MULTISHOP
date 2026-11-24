<?php
require_once __DIR__ . '/utilidades.php';

/* Reglas de los cupones de tienda: el vendedor los crea, cada cliente los usa una vez y solo descuentan
   los productos de esa tienda. La validación vive aquí para que el carrito y el pago apliquen lo mismo. */
class cupon
{
    private $conexion;

    public function __construct()
    {
        $this->conexion = conexionBD();
    }

    public static function normalizar($codigo)
    {
        return mb_strtoupper(trim((string) $codigo));
    }

    public static function calcularDescuento($cupon, $subtotal)
    {
        $descuento = $cupon['Tipo_Descuento'] === 'Porcentaje'
            ? round($subtotal * (float) $cupon['Valor'] / 100, 0)
            : (float) $cupon['Valor'];
        return max(0, min($descuento, $subtotal));
    }

    public static function describir($cupon)
    {
        return $cupon['Tipo_Descuento'] === 'Porcentaje'
            ? rtrim(rtrim(number_format((float) $cupon['Valor'], 2, ',', ''), '0'), ',') . "% de descuento"
            : pesos($cupon['Valor']) . " de descuento";
    }

    /* "Vigente", "Programado", "Vencido", "Agotado" o "Inactivo": cómo se ve el cupón hoy. */
    public static function estadoVisible($cupon, $usos)
    {
        $hoy = date('Y-m-d');
        if ($cupon['Estado'] !== 'Activo')
            return "Inactivo";
        if (substr($cupon['Fecha_Fin'], 0, 10) < $hoy)
            return "Vencido";
        if (substr($cupon['Fecha_Inicio'], 0, 10) > $hoy)
            return "Programado";
        if ($cupon['Usos_Maximos'] !== null && $usos >= (int) $cupon['Usos_Maximos'])
            return "Agotado";
        return "Vigente";
    }

    /* Comprueba si el cliente puede usar ese código en esa tienda con ese subtotal. Devuelve [cupon, descuento] o lanza el motivo. */
    public function validar($codigo, $idTienda, $idUsuario, $subtotalTienda)
    {
        $codigo = self::normalizar($codigo);
        if ($codigo === '') {
            throw new Exception("Escribe el código del cupón.", 400);
        }
        $consulta = $this->conexion->prepare("SELECT * FROM Cupones WHERE Id_Tienda = ? AND Codigo = ?");
        $consulta->execute([$idTienda, $codigo]);
        $cupon = $consulta->fetch();
        $hoy = date('Y-m-d');
        if (!$cupon)
            throw new Exception("Ese cupón no existe en esta tienda.", 400);
        if ($cupon['Estado'] !== 'Activo')
            throw new Exception("Este cupón ya no está disponible.", 400);
        if (substr($cupon['Fecha_Inicio'], 0, 10) > $hoy)
            throw new Exception("Este cupón empieza el " . date('d/m/Y', strtotime($cupon['Fecha_Inicio'])) . ".", 400);
        if (substr($cupon['Fecha_Fin'], 0, 10) < $hoy)
            throw new Exception("Este cupón ya venció.", 400);

        $consulta = $this->conexion->prepare("SELECT COUNT(*) FROM CuponesUso WHERE Id_Cupon = ? AND Id_Usuario = ?");
        $consulta->execute([$cupon['Id_cupones'], $idUsuario]);
        if ($consulta->fetchColumn() > 0)
            throw new Exception("Ya usaste este cupón.", 400);

        if ($cupon['Usos_Maximos'] !== null) {
            $consulta = $this->conexion->prepare("SELECT COUNT(*) FROM CuponesUso WHERE Id_Cupon = ?");
            $consulta->execute([$cupon['Id_cupones']]);
            if ($consulta->fetchColumn() >= (int) $cupon['Usos_Maximos'])
                throw new Exception("Este cupón alcanzó su límite de usos.", 400);
        }
        if ($cupon['Compra_Minima'] !== null && $subtotalTienda < (float) $cupon['Compra_Minima']) {
            throw new Exception("Este cupón requiere una compra mínima de " . pesos($cupon['Compra_Minima']) . " en esta tienda.", 400);
        }
        return [$cupon, self::calcularDescuento($cupon, $subtotalTienda)];
    }

    /* ---------- Administración de cupones del vendedor ---------- */

    public function listarDeTienda($idTienda)
    {
        $consulta = $this->conexion->prepare("SELECT c.*, (SELECT COUNT(*) FROM CuponesUso u WHERE u.Id_Cupon = c.Id_cupones) AS Usos
            FROM Cupones c WHERE c.Id_Tienda = ? ORDER BY c.Fecha_Creacion DESC");
        $consulta->execute([$idTienda]);
        $cupones = $consulta->fetchAll();
        foreach ($cupones as &$c) {
            $c['EstadoVisible'] = self::estadoVisible($c, (int) $c['Usos']);
            $c['Descripcion'] = self::describir($c);
        }
        return $cupones;
    }

    /* A quién se le puede mandar un cupón: clientes que ya le compraron a la tienda o que le escribieron por chat. */
    public function clientesDeTienda($idTienda, $idVendedor)
    {
        $consulta = $this->conexion->prepare("SELECT u.Id_Usuario, u.Nombre, u.Apellido, u.Correo FROM Usuarios u
            WHERE u.Rol = 'Cliente' AND (u.Id_Usuario IN (SELECT v.Id_Usuario FROM HistorialVentas v WHERE v.Id_Tienda = ?)
                OR u.Id_Usuario IN (SELECT ch.Id_UsuarioOrigen FROM Chats ch WHERE ch.Id_UsuarioDestino = ?))
            ORDER BY u.Nombre, u.Apellido");
        $consulta->execute([$idTienda, $idVendedor]);
        return $consulta->fetchAll();
    }

    public function crear($idTienda, $datos)
    {
        $codigo = self::normalizar($datos['codigo'] ?? '');
        if (!preg_match('/^[A-Z0-9_-]{3,50}$/u', $codigo)) {
            throw new Exception("El código debe tener de 3 a 50 letras, números, guiones o guion bajo (sin espacios).", 400);
        }
        $tipo = $datos['tipo'] ?? '';
        if (!in_array($tipo, ['Porcentaje', 'Monto'], true)) {
            throw new Exception("Elige un tipo de descuento válido.", 400);
        }
        $valor = decimalONulo($datos, 'valor');
        if ($valor === null || $valor <= 0)
            throw new Exception("El valor del descuento debe ser mayor que cero.", 400);
        if ($tipo === 'Porcentaje' && $valor > 100)
            throw new Exception("Un porcentaje no puede pasar de 100.", 400);
        $inicio = fechaONula($datos, 'inicio');
        $fin = fechaONula($datos, 'fin');
        if (!$inicio || !$fin)
            throw new Exception("Indica las fechas de inicio y fin.", 400);
        if ($fin < $inicio)
            throw new Exception("La fecha final no puede ser anterior a la inicial.", 400);
        $minima = decimalONulo($datos, 'compraMinima');
        $usos = isset($datos['usosMaximos']) && $datos['usosMaximos'] !== '' ? max(1, (int) $datos['usosMaximos']) : null;

        $sql = "INSERT INTO Cupones (Id_Tienda, Codigo, Tipo_Descuento, Valor, Compra_Minima, Usos_Maximos, Fecha_Inicio, Fecha_Fin, Estado, Fecha_Creacion)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Activo', ?)";
        try {
            $this->conexion->prepare($sql)->execute([$idTienda, $codigo, $tipo, $valor, $minima > 0 ? $minima : null, $usos, $inicio, $fin, ahora()]);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000)
                throw new Exception("Ya tienes un cupón con ese código.", 409);
            throw $e;
        }
        return $codigo;
    }

    public function buscarDeTienda($idCupon, $idTienda)
    {
        $consulta = $this->conexion->prepare("SELECT * FROM Cupones WHERE Id_cupones = ? AND Id_Tienda = ?");
        $consulta->execute([$idCupon, $idTienda]);
        $cupon = $consulta->fetch();
        if (!$cupon)
            throw new Exception("El cupón no existe.", 404);
        return $cupon;
    }

    public function alternar($idCupon, $idTienda)
    {
        $cupon = $this->buscarDeTienda($idCupon, $idTienda);
        $nuevo = $cupon['Estado'] === 'Activo' ? 'Inactivo' : 'Activo';
        $this->conexion->prepare("UPDATE Cupones SET Estado = ? WHERE Id_cupones = ?")->execute([$nuevo, $idCupon]);
        return $nuevo === 'Activo' ? "Cupón {$cupon['Codigo']} activado." : "Cupón {$cupon['Codigo']} desactivado.";
    }

    /* Un cupón ya usado queda como registro de las facturas: se desactiva en vez de borrarse. */
    public function eliminar($idCupon, $idTienda)
    {
        $cupon = $this->buscarDeTienda($idCupon, $idTienda);
        $consulta = $this->conexion->prepare("SELECT (SELECT COUNT(*) FROM CuponesUso WHERE Id_Cupon = ?) + (SELECT COUNT(*) FROM FacturasPorTienda WHERE Id_Cupon = ?)");
        $consulta->execute([$idCupon, $idCupon]);
        if ($consulta->fetchColumn() > 0) {
            throw new Exception("Este cupón ya fue usado en compras: no se puede borrar, pero puedes desactivarlo.", 409);
        }
        $this->conexion->prepare("DELETE FROM Cupones WHERE Id_cupones = ?")->execute([$idCupon]);
        return "Cupón {$cupon['Codigo']} eliminado.";
    }
}
