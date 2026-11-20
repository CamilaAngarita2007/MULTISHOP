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

/* ---------------------------- Colores de tienda (TemaTienda.cs + ColorMath.cs) ---------------------------- */

const ColorMath = {
    hexARgb(hex) {
        const n = parseInt(hex.replace("#", ""), 16);
        return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
    },
    rgbAHex(r, g, b) {
        return "#" + [r, g, b].map(v => Math.round(Math.min(255, Math.max(0, v))).toString(16).padStart(2, "0")).join("").toUpperCase();
    },
    hexAHsl(hex) {
        const [r, g, b] = this.hexARgb(hex).map(v => v / 255);
        const max = Math.max(r, g, b), min = Math.min(r, g, b), d = max - min;
        const l = (max + min) / 2;
        let h = 0, s = 0;
        if (d > 1e-9) {
            s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
            if (max === r) h = (g - b) / d + (g < b ? 6 : 0);
            else if (max === g) h = (b - r) / d + 2;
            else h = (r - g) / d + 4;
            h *= 60;
        }
        return { h, s, l };
    },
    hslAHex(h, s, l) {
        h = ((h % 360) + 360) % 360;
        s = Math.min(1, Math.max(0, s));
        l = Math.min(1, Math.max(0, l));
        const c = (1 - Math.abs(2 * l - 1)) * s, x = c * (1 - Math.abs((h / 60) % 2 - 1)), m = l - c / 2;
        const [r, g, b] = h < 60 ? [c, x, 0] : h < 120 ? [x, c, 0] : h < 180 ? [0, c, x] : h < 240 ? [0, x, c] : h < 300 ? [x, 0, c] : [c, 0, x];
        return this.rgbAHex((r + m) * 255, (g + m) * 255, (b + m) * 255);
    },
    luminancia(hex) {
        const canal = v => { v /= 255; return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4); };
        const [r, g, b] = this.hexARgb(hex);
        return 0.2126 * canal(r) + 0.7152 * canal(g) + 0.0722 * canal(b);
    },
    contraste(a, b) {
        const la = this.luminancia(a), lb = this.luminancia(b);
        return (Math.max(la, lb) + 0.05) / (Math.min(la, lb) + 0.05);
    },
    // Ajusta la luminosidad hasta alcanzar el contraste mínimo contra el fondo (WCAG).
    conContraste(h, s, l, fondo, minimo, haciaOscuro) {
        const paso = haciaOscuro ? -0.01 : 0.01;
        let hex = this.hslAHex(h, s, l);
        for (let i = 0; i < 100 && this.contraste(hex, fondo) < minimo; i++) {
            l = Math.min(1, Math.max(0, l + paso));
            hex = this.hslAHex(h, s, l);
            if (l <= 0 || l >= 1) break;
        }
        return hex;
    }
};

const COLOR_POR_DEFECTO = "#8C5A3A";

// Del color que eligió el vendedor se derivan tonos con funciones fijas (accent, deep, soft, wash...), siempre legibles.
function temaTienda(paleta) {
    const original = String(paleta || "").split(",").map(c => c.trim()).find(c => /^#[0-9a-f]{6}$/i.test(c)) || COLOR_POR_DEFECTO;
    const c = ColorMath.hexAHsl(original);
    const sat = tope => Math.min(c.s, tope);
    const M = ColorMath;

    const accent = M.conContraste(c.h, sat(0.62), 0.32, "#FFFFFF", 6.0, true);
    const accentHsl = M.hexAHsl(accent);
    const soft = M.hslAHex(c.h, sat(0.50), 0.89);
    const claro = {
        "--accent": accent,
        "--accent-hover": M.hslAHex(accentHsl.h, accentHsl.s, Math.max(0.08, accentHsl.l - 0.06)),
        "--accent-contrast": "#FFFFFF",
        "--accent-deep": M.hslAHex(c.h, sat(0.50), 0.17),
        "--accent-soft": soft,
        "--accent-soft-text": M.conContraste(c.h, sat(0.60), 0.24, soft, 7.0, true),
        "--accent-wash": M.hslAHex(c.h, sat(0.40), 0.965),
        "--accent-vivid": M.hslAHex(c.h, Math.min(Math.max(c.s, 0.25), 0.85), Math.min(Math.max(c.l, 0.45), 0.62)),
        "--accent-link": M.conContraste(c.h, sat(0.62), 0.32, "#EEF0EA", 6.0, true)
    };
    const dSoft = M.hslAHex(c.h, sat(0.40), 0.22);
    const oscuro = {
        "--accent": M.hslAHex(c.h, sat(0.62), 0.72),
        "--accent-hover": M.hslAHex(c.h, sat(0.62), 0.79),
        "--accent-contrast": M.hslAHex(c.h, sat(0.40), 0.08),
        "--accent-deep": M.hslAHex(c.h, sat(0.38), 0.15),
        "--accent-soft": dSoft,
        "--accent-soft-text": M.conContraste(c.h, sat(0.60), 0.84, dSoft, 7.0, false),
        "--accent-wash": M.hslAHex(c.h, sat(0.30), 0.12),
        "--accent-vivid": M.hslAHex(c.h, Math.min(Math.max(c.s, 0.25), 0.80), 0.62),
        "--accent-link": M.conContraste(c.h, sat(0.62), 0.74, "#14181A", 6.0, false)
    };
    return { claro, oscuro };
}

// Variables --t-* en línea, para tarjetas que muestran el color de OTRA tienda (ComoEstiloEnLinea).
function estiloTienda(paleta) {
    const t = temaTienda(paleta);
    return Object.entries(t.claro).map(([k, v]) => `--t${k.slice(1)}:${v}`)
        .concat(Object.entries(t.oscuro).map(([k, v]) => `--t${k.slice(1)}-dark:${v}`)).join(";");
}

// La tienda manda dentro de su espacio: la barra, los botones y el pie toman su color (AplicarAlLayout).
function aplicarColorTienda(paleta) {
    const t = temaTienda(paleta);
    let estilo = document.getElementById("temaTienda");
    if (!estilo) {
        estilo = document.createElement("style");
        estilo.id = "temaTienda";
        document.head.appendChild(estilo);
    }
    const bloque = vars => Object.entries(vars).map(([k, v]) => `${k}:${v}`).join(";");
    estilo.textContent = `:root{${bloque(t.claro)}}:root[data-theme="dark"]{${bloque(t.oscuro)}}`;
    document.body.classList.add("tema-tienda");
}