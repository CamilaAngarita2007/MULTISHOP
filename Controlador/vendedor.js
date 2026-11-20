/* Panel del vendedor: resumen, productos, ventas, avisos, PQRS, calificaciones y membresía.
   Cada vista llama a la función de su página según el atributo data-pagina del <body>. */

const PAGINAS_VENDEDOR = {
    resumen: cargarResumen,
    productos: cargarProductos,
    ventas: cargarVentas,
    avisos: cargarAvisos,
    pqrs: cargarPqrsVendedor,
    calificaciones: cargarCalificaciones,
    membresia: cargarMembresia
};

document.addEventListener("DOMContentLoaded", async () => {
    if (!await iniciarPanel("vendedor")) return;
    PAGINAS_VENDEDOR[document.body.dataset.pagina]?.();
});

function stat(valor, etiqueta, enlace) {
    return enlace ? `<a class="ms-card ms-stat" href="${enlace}"><span class="valor">${valor}</span><span class="etiqueta">${etiqueta}</span></a>`
        : `<div class="ms-card ms-stat"><span class="valor">${valor}</span><span class="etiqueta">${etiqueta}</span></div>`;
}

async function cargarResumen() {
    const resultado = await api("apiVendedor.php?accion=resumen");
    if (!resultado.ok) return avisar(resultado.message, "error");
    const r = resultado.data;
    document.getElementById("cabTienda").innerHTML = `<img src="${rutaImagen(r.tienda.Logo)}" alt="">
        <div><h1>${escaparHtml(r.tienda.Nombre_Tienda)}</h1><p class="text-muted mb-0">Así va tu tienda hoy.</p></div>`;
    document.getElementById("verTienda").href = `tienda.html?id=${r.tienda.Id_Tienda}`;
    document.getElementById("cifras").innerHTML = stat(r.productos, "Productos publicados", "vendedorProductos.html") +
        stat(r.ventasAbiertas, "Pedidos por atender", "vendedorVentas.html") + stat(pesos(r.ganancias), "Ventas finalizadas", "vendedorPanel.html") +
        stat(r.pqrsPendientes, "PQRS pendientes", "vendedorPqrs.html");
    const m = r.membresia;
    const vigente = m && new Date(m.Fecha_Fin_Membresia.replace(" ", "T")) > new Date();
    document.getElementById("membresia").innerHTML = m
        ? `<span>Membresía ${vigente ? "activa" : "vencida"} hasta el <b>${fecha(m.Fecha_Fin_Membresia)}</b>.</span>`
        : `<span>Aún no activas tu membresía. <a href="vendedorMembresia.html">Activa tu primer mes gratis</a>.</span>`;
    document.getElementById("membresia").className = "alert " + (vigente ? "alert-success" : "alert-warning");
}

async function cargarProductos() {
    const resultado = await api("apiVendedor.php?accion=productos");
    if (!resultado.ok) return avisar(resultado.message, "error");
    const lista = document.getElementById("listaProductos");
    lista.innerHTML = resultado.data.length ? `<div class="ms-card pn-tabla"><table class="table pn-apilable">
        <thead><tr><th>Producto</th><th class="num">Precio</th><th class="num">Stock</th><th>Estado</th><th class="num">Acciones</th></tr></thead>
        <tbody>${resultado.data.map(p => `<tr>
            <td class="principal"><div class="pn-celda-prod"><img class="pn-thumb" src="${rutaImagen(p.Imagen)}" alt=""><span>${escaparHtml(p.Nombre_Producto)}
                ${Number(p.Tiene_Variantes) ? '<span class="sec">Con tallas o colores</span>' : ""}</span></div></td>
            <td class="num" data-label="Precio">${precioHtml(p.Precio_Vigente, p.Precio, Number(p.En_Oferta) === 1)}</td>
            <td class="num" data-label="Stock">${Number(p.Stock) <= 5 ? `<span class="badge ${Number(p.Stock) === 0 ? "bg-danger" : "bg-warning"}">${p.Stock}</span>` : p.Stock}</td>
            <td data-label="Estado">${Number(p.En_Oferta) ? '<span class="badge bg-danger">En oferta</span>' : '<span class="badge bg-secondary">Normal</span>'}</td>
            <td class="sin-etiqueta"><div class="acciones">
                <a class="btn btn-sm btn-soft" href="producto.html?id=${p.Id_Producto}" aria-label="Ver ${escaparHtml(p.Nombre_Producto)}"><i class="bi bi-eye"></i></a>
                <a class="btn btn-sm btn-outline-ms" href="vendedorProducto.html?id=${p.Id_Producto}"><i class="bi bi-pencil"></i>Editar</a>
                <button class="btn btn-sm btn-outline-danger btn-icono" data-eliminar="${p.Id_Producto}" data-nombre="${escaparHtml(p.Nombre_Producto)}" aria-label="Eliminar ${escaparHtml(p.Nombre_Producto)}"><i class="bi bi-trash3"></i></button>
            </div></td></tr>`).join("")}</tbody></table></div>`
        : vacio("bi-box-seam", "Aún no has publicado productos", "Publica tu primer producto para que aparezca en tu tienda.", '<a class="btn btn-ms-primary" href="vendedorProducto.html"><i class="bi bi-plus-lg"></i>Nuevo producto</a>');
    lista.querySelectorAll("[data-eliminar]").forEach(b => b.addEventListener("click", async () => {
        if (!confirm(`¿Eliminar "${b.dataset.nombre}"? Si ya tiene pedidos, solo se ocultará del catálogo.`)) return;
        avisarResultado(await api("apiVendedor.php?accion=eliminarProducto", { idProducto: Number(b.dataset.eliminar) }));
        cargarProductos();
    }));
}