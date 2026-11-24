/* Crear o editar un producto: datos, rebaja temporal, galería (hasta 5 fotos extra) y variantes (tallas y colores). */
const formulario = document.getElementById("formProducto");
const idProducto = Number(parametro("id")) || 0;
let imagenesAEliminar = [];
let colores = [];

document.addEventListener("DOMContentLoaded", async () => {
    if (!await iniciarPanel("vendedor", "vendedorProductos.html")) return;
    formulario.rebaja.addEventListener("change", alternarSecciones);
    formulario.variantes.addEventListener("change", alternarSecciones);
    document.getElementById("agregarColor").addEventListener("click", () => { colores.push({ id: 0, nombre: "", hex: "#000000", imagen: null }); pintarColores(); });
    formulario.imagen.addEventListener("change", () => {
        if (formulario.imagen.files[0]) document.getElementById("vistaImagen").src = URL.createObjectURL(formulario.imagen.files[0]);
    });

    if (idProducto) {
        document.getElementById("tituloProducto").textContent = "Editar producto";
        const resultado = await api("apiVendedor.php?accion=producto&id=" + idProducto);
        if (!resultado.ok) { avisar(resultado.message, "error"); return; }
        const p = resultado.data;
        formulario.nombre.value = p.Nombre_Producto;
        formulario.descripcion.value = p.Descripcion || "";
        formulario.precio.value = Number(p.Precio);
        formulario.stock.value = p.Stock;
        formulario.variante.value = p.Variante || "";
        formulario.rebaja.checked = Number(p.Rebaja_Temporal) === 1;
        formulario.precioRebajado.value = p.Precio_Rebajado ? Number(p.Precio_Rebajado) : "";
        formulario.inicioRebaja.value = (p.Fecha_Inicio_Rebaja || "").slice(0, 10);
        formulario.finRebaja.value = (p.Fecha_Fin_Rebaja || "").slice(0, 10);
        formulario.variantes.checked = Number(p.Tiene_Variantes) === 1;
        formulario.tallas.value = p.Tallas_Disponibles || "";
        document.getElementById("vistaImagen").src = rutaImagen(p.Imagen);
        colores = p.colores.map(c => ({ id: c.Id_ColorProducto, nombre: c.Nombre_Color, hex: c.Color_Hex || "#000000", imagen: c.Imagen }));
        pintarImagenes(p.imagenes);
    }
    pintarColores();
    alternarSecciones();
});

function alternarSecciones() {
    document.getElementById("seccionRebaja").hidden = !formulario.rebaja.checked;
    formulario.precioRebajado.required = formulario.rebaja.checked;
    document.getElementById("seccionVariantes").hidden = !formulario.variantes.checked;
}

function pintarImagenes(imagenes) {
    const contenedor = document.getElementById("imagenesActuales");
    contenedor.innerHTML = imagenes.map(i => `<figure><img src="${rutaImagen(i.Imagen)}" alt="">
        <label class="form-check"><input type="checkbox" class="form-check-input" data-quitar-imagen="${i.Id_ProductoImagen}"><span class="form-check-label">Quitar</span></label></figure>`).join("");
    contenedor.querySelectorAll("[data-quitar-imagen]").forEach(c => c.addEventListener("change", () => {
        const id = Number(c.dataset.quitarImagen);
        imagenesAEliminar = c.checked ? [...imagenesAEliminar, id] : imagenesAEliminar.filter(x => x !== id);
    }));
}

function pintarColores() {
    const lista = document.getElementById("listaColores");
    lista.innerHTML = colores.map((c, i) => `<div class="pn-color-fila" data-fila="${i}">
        <input type="color" class="form-control form-control-color" data-campo="hex" value="${c.hex}" aria-label="Muestra del color ${i + 1}">
        <input class="form-control" data-campo="nombre" value="${escaparHtml(c.nombre)}" maxlength="50" placeholder="Nombre del color, ejemplo: Negro" aria-label="Nombre del color ${i + 1}">
        <div class="archivo">${c.imagen ? `<img src="${rutaImagen(c.imagen)}" alt="">` : ""}
            <input type="file" class="form-control form-control-sm" name="colorImagen_${i}" accept="image/*" aria-label="Foto del color ${i + 1}"></div>
        <button type="button" class="btn btn-outline-danger btn-icono btn-quitar-color" data-quitar-color="${i}" aria-label="Quitar color"><i class="bi bi-x-lg"></i></button>
    </div>`).join("") || `<p class="pn-ayuda">Sin colores. Agrega uno si el producto viene en varios colores.</p>`;
    lista.querySelectorAll("[data-campo]").forEach(campo => campo.addEventListener("input", () => {
        colores[Number(campo.closest("[data-fila]").dataset.fila)][campo.dataset.campo] = campo.value;
    }));
    lista.querySelectorAll("[data-quitar-color]").forEach(b => b.addEventListener("click", () => { colores.splice(Number(b.dataset.quitarColor), 1); pintarColores(); }));
}

formulario.addEventListener("submit", async e => {
    e.preventDefault();
    const boton = formulario.querySelector("button[type=submit]");
    const mensaje = document.getElementById("mensajeProducto");
    const datos = new FormData(formulario);
    datos.set("idProducto", idProducto);
    datos.set("rebaja", formulario.rebaja.checked ? "1" : "");
    datos.set("variantes", formulario.variantes.checked ? "1" : "");
    datos.set("colores", JSON.stringify(colores.map(c => ({ id: c.id, nombre: c.nombre, hex: c.hex }))));
    datos.set("eliminarImagenes", JSON.stringify(imagenesAEliminar));
    boton.disabled = true;
    mostrarMensaje(mensaje, "Guardando...");
    const resultado = await api("apiVendedor.php?accion=guardarProducto", datos);
    boton.disabled = false;
    mostrarMensaje(mensaje, resultado.message, resultado.ok ? "" : "error");
    if (resultado.ok) setTimeout(() => location.href = "vendedorProductos.html", 700);
});