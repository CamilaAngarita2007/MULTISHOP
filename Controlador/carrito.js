document.addEventListener("DOMContentLoaded", async () => {
    if (!await protegerPagina("Cliente")) return;
    cargarCarrito();
});

async function cargarCarrito() {
    const resultado = await api("apiCarrito.php?accion=ver");
    if (!resultado.ok) return avisar(resultado.message, "error");
    const { tiendas, total, unidades, problema } = resultado.data;
    document.getElementById("subtituloCarrito").textContent = tiendas.length
        ? `${unidades} ${unidades === 1 ? "producto" : "productos"} de ${tiendas.length} ${tiendas.length === 1 ? "tienda" : "tiendas"}. Pagas todo junto, en una sola factura.` : "";
    const contenedor = document.getElementById("carrito");

    if (!tiendas.length) {
        contenedor.innerHTML = vacio("bi-bag", "Tu carrito está vacío", "Cuando agregues productos de cualquier tienda, los verás aquí agrupados por tienda.",
            '<a class="btn btn-ms-primary" href="categorias.html">Explorar tiendas</a>');
        refrescarContadores();
        return;
    }

    contenedor.innerHTML = `<div class="ms-pagina">
        <div class="ms-pagina-principal">${tiendas.map(t => `
            <section class="ms-grupo ms-tienda" style="${estiloTienda(t.Paleta_Colores)}" aria-label="Productos de ${escaparHtml(t.Nombre_Tienda)}">
                <header class="ms-grupo-cab">
                    <img src="${rutaImagen(t.Logo)}" alt="" width="40" height="40">
                    <h2><a href="tienda.html?id=${t.Id_Tienda}">${escaparHtml(t.Nombre_Tienda)}</a></h2>
                    <span class="ms-grupo-monto">${pesos(t.Subtotal)}</span>
                </header>
                ${t.items.map(d => {
                    const max = Math.max(1, Math.min(99, Number(d.Stock)));
                    const variante = [d.Talla_Seleccionada ? "Talla " + escaparHtml(d.Talla_Seleccionada) : "", d.Color_Seleccionado ? "Color " + escaparHtml(d.Color_Seleccionado) : ""].filter(Boolean).join(" · ");
                    const aviso = !d.Activo || d.Estado_Tienda !== "Activa" ? "Ya no está disponible. Quítalo para continuar."
                        : Number(d.Stock) < Number(d.Cantidad) ? `Solo quedan ${d.Stock} disponibles. Ajusta la cantidad.` : "";
                    return `<div class="ms-item">
                        <img class="ms-item-foto${d.Imagen ? "" : " sin-foto"}" src="${rutaImagen(d.Imagen)}" alt="" loading="lazy">
                        <div class="ms-item-info">
                            <a class="ms-item-nombre" href="producto.html?id=${d.Id_Producto}">${escaparHtml(d.Nombre_Producto)}</a>
                            ${variante ? `<p class="ms-item-meta">${variante}</p>` : ""}
                            <p class="ms-item-meta">${pesos(d.Precio_Unitario)} c/u</p>
                            ${aviso ? `<p class="ms-item-aviso">${aviso}</p>` : ""}
                        </div>
                        <div class="ms-item-qty"><div class="ms-qty">
                            <button type="button" data-qty="-1" aria-label="Quitar una unidad de ${escaparHtml(d.Nombre_Producto)}"><i class="bi bi-dash-lg"></i></button>
                            <input type="number" value="${d.Cantidad}" min="1" max="${max}" inputmode="numeric" data-detalle="${d.Id_Detalle}" aria-label="Cantidad de ${escaparHtml(d.Nombre_Producto)}">
                            <button type="button" data-qty="1" aria-label="Agregar una unidad de ${escaparHtml(d.Nombre_Producto)}"><i class="bi bi-plus-lg"></i></button>
                        </div></div>
                        <div class="ms-item-total">${pesos(d.Subtotal)}</div>
                        <div class="ms-item-quitar"><button type="button" data-quitar="${d.Id_Detalle}" aria-label="Quitar ${escaparHtml(d.Nombre_Producto)} del carrito" title="Quitar"><i class="bi bi-trash3"></i></button></div>
                    </div>`;
                }).join("")}
            </section>`).join("")}
        </div>
        <aside class="ms-pagina-lado" aria-label="Resumen del carrito">
            <div class="ms-card ms-resumen">
                <h2>Resumen</h2>
                <dl>${tiendas.map(t => `<div><dt>${escaparHtml(t.Nombre_Tienda)}</dt><dd>${pesos(t.Subtotal)}</dd></div>`).join("")}</dl>
                <div class="ms-resumen-total"><span>Total</span><strong>${pesos(total)}</strong></div>
                ${problema ? `<div class="alert alert-warning"><span>${escaparHtml(problema)}</span></div>` : ""}
                <a href="checkout.html" class="btn btn-ms-primary btn-lg btn-block${problema ? " disabled" : ""}">Ir a pagar <i class="bi bi-arrow-right"></i></a>
                <p class="nota"><i class="bi bi-ticket-perforated" aria-hidden="true"></i><span>Si tienes un cupón de alguna tienda, lo aplicas en el siguiente paso.</span></p>
            </div>
        </aside>
    </div>`;

    // La cantidad se guarda sola poco después de cambiarla (los botones + y − disparan "change").
    contenedor.querySelectorAll("[data-detalle]").forEach(campo => {
        let espera;
        campo.addEventListener("change", () => {
            clearTimeout(espera);
            espera = setTimeout(async () => {
                const resultado = await api("apiCarrito.php?accion=cantidad", { idDetalle: Number(campo.dataset.detalle), cantidad: Number(campo.value) });
                if (!resultado.ok || resultado.message.startsWith("Solo")) avisarResultado(resultado);
                cargarCarrito();
                refrescarContadores();
            }, 550);
        });
    });
    contenedor.querySelectorAll("[data-quitar]").forEach(boton => boton.addEventListener("click", async () => {
        avisarResultado(await api("apiCarrito.php?accion=quitar", { idDetalle: Number(boton.dataset.quitar) }));
        cargarCarrito();
        refrescarContadores();
    }));
}
