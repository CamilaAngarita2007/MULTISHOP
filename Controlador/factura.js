document.addEventListener("DOMContentLoaded", async () => {
    if (!await protegerPagina("Cliente")) return;
    if (parametro("nuevo")) avisar("¡Pedido confirmado! Tu factura fue generada.");
    document.getElementById("imprimir").addEventListener("click", () => window.print());
    cargarFactura();
});

// Igual que _LineaTiempoEnvio.cshtml.
function lineaTiempo(t) {
    if (t.Estado === "Cancelada") return `<div class="alert alert-danger py-2 mb-3"><span>Esta tienda canceló el pedido.</span></div>`;
    const actual = t.flujo.indexOf(t.Estado_Envio);
    return `<ol class="ms-linea-tiempo mb-3" aria-label="Seguimiento del pedido">${t.flujo.map((etapa, i) => {
        const hecho = i <= actual;
        const registro = t.lineaTiempo.find(l => l.Estado === etapa);
        return `<li class="${hecho ? "hecho" : ""} ${i === actual ? "actual" : ""}"${i === actual ? ' aria-current="step"' : ""}>
            <span class="punto">${hecho ? '<i class="bi bi-check-lg"></i>' : ""}</span>
            <span class="etiqueta">${escaparHtml(etapa)}</span><span class="fecha">${registro ? fecha(registro.Fecha, true) : ""}</span></li>`;
    }).join("")}</ol>`;
}

async function cargarFactura() {
    const resultado = await api("apiCarrito.php?accion=factura&id=" + Number(parametro("id")));
    if (!resultado.ok) {
        document.getElementById("factura").innerHTML = vacio("bi-receipt", escaparHtml(resultado.message), "", '<a class="btn btn-ms-primary" href="historial.html">Mis pedidos</a>');
        return;
    }
    const f = resultado.data;
    document.title = `Pedido #${f.Id_Factura} - MULTISHOP`;
    document.getElementById("tituloFactura").textContent = `Pedido #${f.Id_Factura}`;
    document.getElementById("subtituloFactura").textContent = `${fecha(f.Fecha, true)} · ${f.Metodo_Pago}`;

    const icono = f.Tipo_Entrega === "RetiroTienda" ? "bi-shop" : f.Tipo_Entrega === "DomicilioOtro" ? "bi-gift" : "bi-house-door";
    document.getElementById("entrega").innerHTML = `<i class="bi ${icono}" aria-hidden="true"></i><div>
        <span class="rotulo">Entrega</span><p><b>${TEXTO_ENTREGA[f.Tipo_Entrega] || "—"}</b></p>
        <div class="datos">${f.Direccion_Entrega ? `<span><i class="bi bi-geo-alt"></i> ${escaparHtml(f.Direccion_Entrega)}</span>` : ""}
            ${f.Nombre_Destinatario ? `<span><i class="bi bi-person"></i> ${escaparHtml(f.Nombre_Destinatario)}</span>` : ""}
            ${f.Telefono_Contacto ? `<span><i class="bi bi-telephone"></i> ${escaparHtml(f.Telefono_Contacto)}</span>` : ""}
            <span><i class="bi bi-person-badge"></i> ${escaparHtml(f.Nombre + " " + f.Apellido)} · ${escaparHtml(f.Correo)}</span></div></div>`;

    document.getElementById("tiendasFactura").innerHTML = f.tiendas.map(t => `
        <section class="ms-grupo ms-tienda mt-4" style="${estiloTienda(t.Paleta_Colores)}" aria-label="Pedido en ${escaparHtml(t.Nombre_Tienda)}">
            <header class="ms-grupo-cab">
                <img src="${rutaImagen(t.Logo)}" alt="" width="40" height="40">
                <h2><a href="tienda.html?id=${t.Id_Tienda}">${escaparHtml(t.Nombre_Tienda)}</a></h2>
                <span class="ms-estado-venta">${insigniaEstado(t.Estado || "Pendiente")}</span>
            </header>
            <div class="ms-grupo-cuerpo">
                ${lineaTiempo(t)}
                ${t.productos.map(p => `<div class="ms-item lectura">
                    <img class="ms-item-foto${p.Imagen ? "" : " sin-foto"}" src="${rutaImagen(p.Imagen)}" alt="" loading="lazy">
                    <div class="ms-item-info"><a class="ms-item-nombre" href="producto.html?id=${p.Id_Producto}">${escaparHtml(p.Nombre_Producto)}</a>
                        <p class="ms-item-meta">${p.Cantidad} ${Number(p.Cantidad) === 1 ? "unidad" : "unidades"}${p.Talla_Seleccionada ? " · Talla " + escaparHtml(p.Talla_Seleccionada) : ""}${p.Color_Seleccionado ? " · Color " + escaparHtml(p.Color_Seleccionado) : ""}</p></div>
                    <div class="ms-item-total">${pesos(p.Subtotal)}</div></div>`).join("")}
                ${t.Comprobante_QR ? `<p class="ms-comprobante">Comprobante de pago: <a href="${rutaImagen(t.Comprobante_QR)}" target="_blank" rel="noopener">ver archivo</a></p>` : ""}
                ${t.puedeConfirmar ? `<div class="ms-confirmar no-imprimir"><p class="mb-2">${t.Estado === "Pendiente" ? "¿Ya recibiste este pedido y lo pagaste?" : "La tienda marcó tu pedido como entregado. ¿Ya lo recibiste?"}</p>
                    <button type="button" class="btn btn-ms-primary" data-confirmar="${t.Id_FacturaTienda}"><i class="bi bi-check2-circle"></i>Confirmar que lo recibí</button></div>` : ""}
                <div class="d-flex flex-wrap gap-2 mt-3 no-imprimir">
                    <a class="btn btn-soft btn-sm" href="chat.html?con=${t.Id_Vendedor}"><i class="bi bi-chat-dots"></i>Escribir a la tienda</a>
                    <a class="btn btn-soft btn-sm" href="pqrs.html?tienda=${t.Id_Tienda}"><i class="bi bi-chat-square-text"></i>Enviar PQRS</a>
                </div>
            </div>
            <div class="ms-grupo-pie">
                <span>Subtotal ${pesos(t.Subtotal)}</span>
                ${Number(t.Descuento) > 0 ? `<span class="ahorro">Cupón ${escaparHtml(t.Codigo_Cupon || "")}: -${pesos(t.Descuento)}</span>` : ""}
                <span class="total">Total ${pesos(t.Subtotal - t.Descuento)}</span>
            </div>
        </section>`).join("");

    document.getElementById("resumenFactura").innerHTML = `<h2>Resumen</h2>
        <dl>${f.tiendas.map(t => `<div><dt>${escaparHtml(t.Nombre_Tienda)}</dt><dd>${pesos(t.Subtotal - t.Descuento)}</dd></div>`).join("")}
            ${Number(f.Descuento) > 0 ? `<div class="ahorro"><dt>Ahorro con cupones</dt><dd>-${pesos(f.Descuento)}</dd></div>` : ""}</dl>
        <div class="ms-resumen-total"><span>Total</span><strong>${pesos(f.Total)}</strong></div>
        <p class="nota"><i class="bi bi-info-circle" aria-hidden="true"></i><span>Si una tienda cancela, el total solo cuenta lo que sigue vigente.</span></p>`;

    document.querySelectorAll("[data-confirmar]").forEach(b => b.addEventListener("click", async () => {
        b.disabled = true;
        avisarResultado(await api("apiCarrito.php?accion=confirmarRecepcion", { idFacturaTienda: Number(b.dataset.confirmar) }));
        cargarFactura();
    }));
}
