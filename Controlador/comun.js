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