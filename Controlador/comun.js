/* Funciones compartidas por todas las vistas: peticiones al Modelo, sesión, barra de navegación, pie,
   botones flotantes, tarjetas de producto y de tienda, colores de cada tienda (TemaTienda) y modo oscuro.
   El HTML que se genera aquí es el mismo de las vistas Razor del proyecto en C# (_Layout, _TarjetaProducto,
   _TarjetaTienda, _Estrellas), para que el diseño sea idéntico. */

const API = "../Modelo/";
let sesionActual = null;

/* ---------------------------- Tema claro / oscuro ---------------------------- */

// Se aplica antes de dibujar (sin parpadeo). data-theme lo usa el CSS de MultiShop; data-bs-theme, Bootstrap.
function aplicarTema(tema) {
    document.documentElement.setAttribute("data-theme", tema);
    document.documentElement.setAttribute("data-bs-theme", tema);
}
document.documentElement.classList.add("js");
try {
    const temaGuardado = localStorage.getItem("ms-tema");
    aplicarTema(temaGuardado === "dark" ? "dark" : "light");
} catch (e) { aplicarTema("light"); }

function alternarTema() {
    const nuevo = document.documentElement.getAttribute("data-theme") === "dark" ? "light" : "dark";
    aplicarTema(nuevo);
    try { localStorage.setItem("ms-tema", nuevo); } catch (e) { }
    document.querySelectorAll("#btnModoOscuro i").forEach(i => i.className = "bi " + (nuevo === "dark" ? "bi-sun" : "bi-moon-stars"));
}

/* ---------------------------- Peticiones ---------------------------- */

// datos: objeto (se envía como JSON) o FormData (con archivos). Devuelve siempre { ok, status, success, message, data }.
async function api(ruta, datos) {
    const opciones = { credentials: "same-origin" };
    if (datos instanceof FormData) {
        opciones.method = "POST";
        opciones.body = datos;
    } else if (datos !== undefined) {
        opciones.method = "POST";
        opciones.headers = { "Content-Type": "application/json" };
        opciones.body = JSON.stringify(datos);
    }
    try {
        const respuesta = await fetch(API + ruta, opciones);
        const resultado = await respuesta.json();
        if (respuesta.status === 401 && !ruta.startsWith("apiCuenta.php?accion=sesion")) irALogin();
        return { ok: respuesta.ok && resultado.success, status: respuesta.status, ...resultado };
    } catch (error) {
        console.error("Error en la petición:", error);
        return { ok: false, success: false, message: "No se pudo conectar con el servidor. Inténtalo de nuevo." };
    }
}

function irALogin() {
    const volver = encodeURIComponent(location.pathname.split("/").pop() + location.search);
    location.href = "login.html?volver=" + volver;
}

/* ---------------------------- Formato ---------------------------- */

const formatoPesos = new Intl.NumberFormat("es-CO", { style: "currency", currency: "COP", maximumFractionDigits: 0 });
function pesos(valor) {
    return formatoPesos.format(Number(valor) || 0);
}

function escaparHtml(texto) {
    return String(texto ?? "").replace(/[&<>"']/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]);
}

// Las rutas guardadas en la base son relativas a la raíz del proyecto (Assets/img/..., Assets/uploads/...).
function rutaImagen(ruta, respaldo = "Assets/img/LOGO.png") {
    const valor = ruta || respaldo;
    if (/^https?:\/\//.test(valor)) return valor;
    if (valor.startsWith("privado/")) return API + "archivoPrivado.php?ruta=" + encodeURIComponent(valor);
    return "../" + valor.replace(/^\/+/, "");
}

// Para usar dentro de url(...) en un estilo: absoluta, porque una ruta relativa se resolvería contra el CSS.
function urlFondo(ruta) {
    return `url('${new URL(rutaImagen(ruta), location.href).href}')`;
}

function fecha(valor, conHora = false) {
    if (!valor) return "";
    // Una fecha sin hora ("2026-11-09") se toma como hora local, no UTC (si no, en Colombia mostraría el día anterior).
    const texto = String(valor).replace(" ", "T");
    const f = new Date(/^\d{4}-\d{2}-\d{2}$/.test(texto) ? texto + "T00:00" : texto);
    const dia = f.toLocaleDateString("es-CO", { day: "2-digit", month: "2-digit", year: "numeric" });
    return conHora ? dia + " " + f.toLocaleTimeString("es-CO", { hour: "2-digit", minute: "2-digit", hour12: false }) : dia;
}

// Igual que _Estrellas.cshtml: redondeo a medias estrellas.
function estrellas(promedio) {
    const r = Math.round(Number(promedio) * 2) / 2;
    let html = "";
    for (let i = 1; i <= 5; i++) html += `<i class="bi ${r >= i ? "bi-star-fill" : r >= i - 0.5 ? "bi-star-half" : "bi-star"}"></i>`;
    return `<span class="ms-estrellas" role="img" aria-label="${Number(promedio).toFixed(1)} de 5 estrellas">${html}</span>`;
}

function parametro(nombre) {
    return new URLSearchParams(location.search).get(nombre);
}

const ICONOS_CATEGORIA = {
    "Supermercados": "bi-basket", "Moda y calzado": "bi-bag", "Deportes y aire libre": "bi-trophy",
    "Electrónica y tecnología": "bi-laptop", "Hogar y decoración": "bi-lamp", "Farmacias": "bi-capsule",
    "Belleza": "bi-gem", "Restaurantes y gastronomía": "bi-cup-hot"
};
const iconoCategoria = nombre => ICONOS_CATEGORIA[nombre] || "bi-shop";

/* ---------------------------- Mensajes ---------------------------- */

function avisar(texto, tipo = "exito") {
    let contenedor = document.querySelector(".ms-toasts");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.className = "ms-toasts";
        contenedor.setAttribute("aria-live", "polite");
        document.body.appendChild(contenedor);
    }
    const alerta = document.createElement("div");
    alerta.className = `alert alert-${tipo === "error" ? "danger" : "success"}`;
    alerta.setAttribute("role", tipo === "error" ? "alert" : "status");
    alerta.innerHTML = `<span>${escaparHtml(texto)}</span>`;
    contenedor.appendChild(alerta);
    setTimeout(() => alerta.remove(), tipo === "error" ? 7000 : 4000);
}

// Igual que en Club Acerias: un <p id="mensaje..."> con role="status" bajo el formulario.
function mostrarMensaje(elemento, texto, tipo = "") {
    if (!elemento) return;
    elemento.textContent = texto;
    elemento.dataset.tipo = tipo;
}

function avisarResultado(resultado) {
    if (resultado.message) avisar(resultado.message, resultado.ok ? "exito" : "error");
    return resultado.ok;
}
