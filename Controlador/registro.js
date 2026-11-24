const formulario = document.getElementById("formRegistro");

document.addEventListener("DOMContentLoaded", async () => {
    if (await cargarSesion()) location.href = "Inicio.html";
});

formulario.addEventListener("submit", async function (event) {
    event.preventDefault();
    const boton = formulario.querySelector("button[type='submit']");
    const mensaje = document.getElementById("mensajeRegistro");
    // Lee los campos del formulario y los convierte en un objeto
    const datos = Object.fromEntries(new FormData(formulario).entries());
    if (datos.contrasena !== datos.confirmacion) {
        return mostrarMensaje(mensaje, "Las contraseñas no coinciden.", "error");
    }
    boton.disabled = true; // deshabilitar el botón mientras se procesa la solicitud
    mostrarMensaje(mensaje, "Creando tu cuenta...");
    const resultado = await api("apiCuenta.php?accion=registro", datos);
    boton.disabled = false;
    mostrarMensaje(mensaje, resultado.message, resultado.ok ? "" : "error");
    if (resultado.ok) {
        formulario.reset();
        setTimeout(() => location.href = "Inicio.html", 900);
    }
});
