/* Editar tienda: datos, 1 o 2 colores de identidad (con vista previa de cómo quedará el tema), logo, fondo y métodos de pago. */
const formulario = document.getElementById("formTienda");

document.addEventListener("DOMContentLoaded", async () => {
    if (!await iniciarPanel("vendedor")) return;
    const [categorias, tienda] = await Promise.all([api("apiCuenta.php?accion=categorias"), api("apiVendedor.php?accion=tienda")]);
    if (!tienda.ok) return avisar(tienda.message, "error");
    const t = tienda.data;
    formulario.idCategoria.innerHTML = categorias.data.map(c => `<option value="${c.Id_Categoria}">${escaparHtml(c.Nombre_Categoria)}</option>`).join("");
    formulario.nombre.value = t.Nombre_Tienda;
    formulario.idCategoria.value = t.Id_Categoria;
    formulario.direccion.value = t.Direccion || "";
    formulario.horario.value = t.Horario || "";
    const [c1, c2] = String(t.Paleta_Colores || COLOR_POR_DEFECTO).split(",");
    formulario.color1.value = c1 || COLOR_POR_DEFECTO;
    formulario.color2.value = c2 || "#333333";
    formulario.usarColor2.checked = !!c2;
    t.metodos.forEach(m => { const c = formulario.querySelector(`input[name="metodos[]"][value="${m}"]`); if (c) c.checked = true; });
    document.getElementById("logoActual").src = rutaImagen(t.Logo);
    if (t.Fondo_Navbar) document.getElementById("fondoActual").src = rutaImagen(t.Fondo_Navbar);
    if (t.Imagen_QR) document.getElementById("qrActual").innerHTML = `<img class="pn-qr-prev" src="${rutaImagen(t.Imagen_QR)}" alt="QR actual">`;
    formulario.logo.addEventListener("change", () => { if (formulario.logo.files[0]) document.getElementById("logoActual").src = URL.createObjectURL(formulario.logo.files[0]); });
    formulario.fondo.addEventListener("change", () => { if (formulario.fondo.files[0]) document.getElementById("fondoActual").src = URL.createObjectURL(formulario.fondo.files[0]); });
    formulario.addEventListener("input", vistaPrevia);
    vistaPrevia();
});

// Vista previa con los mismos tonos que calcula TemaTienda: así el vendedor ve cómo quedará su barra y sus botones.
function vistaPrevia() {
    formulario.color2.disabled = !formulario.usarColor2.checked;
    document.getElementById("codigo1").textContent = formulario.color1.value.toUpperCase();
    document.getElementById("codigo2").textContent = formulario.usarColor2.checked ? formulario.color2.value.toUpperCase() : "Sin segundo color";
    const tema = temaTienda(formulario.color1.value).claro;
    document.getElementById("previewHeader").style.cssText = `background:${tema["--accent"]};color:${tema["--accent-contrast"]}`;
    document.getElementById("previewProfundo").style.cssText = `background:${tema["--accent-deep"]};color:#fff`;
    document.getElementById("previewSuave").style.cssText = `background:${tema["--accent-soft"]};color:${tema["--accent-soft-text"]}`;
    document.getElementById("grupoQr").hidden = !formulario.querySelector('input[value="QR"]').checked;
}

formulario.addEventListener("submit", async e => {
    e.preventDefault();
    const boton = formulario.querySelector("button[type=submit]");
    boton.disabled = true;
    const resultado = await api("apiVendedor.php?accion=editarTienda", new FormData(formulario));
    boton.disabled = false;
    mostrarMensaje(document.getElementById("mensajeTienda"), resultado.message, resultado.ok ? "" : "error");
    if (resultado.ok) setTimeout(() => location.reload(), 800);
});
