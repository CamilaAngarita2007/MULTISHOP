const METODOS = {
    Contraentrega: ["bi-cash-coin", "Pagas cuando recibes tu pedido."],
    QR: ["bi-qr-code", "Pagas con el código QR de cada tienda y subes el comprobante."],
    PSE: ["bi-bank", "Pago en línea simulado: en este proyecto no se cobra."],
    Tarjeta: ["bi-credit-card", "Pago simulado: en este proyecto no se cobra."]
};
const formulario = document.getElementById("formPago");

document.addEventListener("DOMContentLoaded", async () => {
    if (!await protegerPagina("Cliente")) return;
    formulario.addEventListener("change", actualizarFormulario);
    formulario.addEventListener("submit", confirmarPedido);
    cargarCheckout(true);
});

async function cargarCheckout(primeraVez) {
    const resultado = await api("apiCarrito.php?accion=checkout");
    if (!resultado.ok) {
        avisar(resultado.message, "error");
        setTimeout(() => location.href = "carrito.html", 1800);
        return;
    }
    const d = resultado.data;
    document.getElementById("subtituloPago").textContent = `Revisa la entrega y el pago. Una sola factura reúne las ${d.tiendas.length} ${d.tiendas.length === 1 ? "tienda" : "tiendas"} de tu carrito.`;

    if (primeraVez) {
        const u = d.usuario;
        document.getElementById("direccionPropia").innerHTML = u.Direccion_Envio
            ? `<div class="ms-direccion"><i class="bi bi-geo-alt" aria-hidden="true"></i><p><span class="rotulo">Se enviará a</span><b>${escaparHtml(u.Direccion_Envio)}</b></p></div>`
            : `<div class="alert alert-warning mb-0"><span>No tienes una dirección registrada. <a href="perfil.html">Agrégala en tu cuenta</a> o elige "otra dirección".</span></div>`;
        document.getElementById("direccionPropia").dataset.direccion = u.Direccion_Envio || "";
        document.getElementById("metodosPago").innerHTML = d.metodos.map((m, i) => {
            const [icono, texto] = METODOS[m] || ["bi-wallet2", ""];
            return `<label class="ms-eleccion"><input type="radio" name="metodoPago" value="${m}" ${i === 0 ? "checked" : ""}>
                <span class="cuerpo"><span class="icono"><i class="bi ${icono}"></i></span><span class="texto"><b>${m}</b><small>${texto}</small></span><span class="marca"></span></span></label>`;
        }).join("");
    }

    document.getElementById("tiendasPago").innerHTML = d.tiendas.map(t => `
        <section class="ms-grupo ms-tienda mt-4" style="${estiloTienda(t.Paleta_Colores)}" aria-label="Detalle de ${escaparHtml(t.Nombre_Tienda)}">
            <header class="ms-grupo-cab">
                <img src="${rutaImagen(t.Logo)}" alt="" width="40" height="40">
                <h2>${escaparHtml(t.Nombre_Tienda)}</h2>
                <span class="ms-grupo-monto">${t.Descuento > 0 ? `<s>${pesos(t.Subtotal)}</s>` : ""}${pesos(t.Subtotal - t.Descuento)}</span>
            </header>
            <div class="ms-grupo-cuerpo">
                <div class="ms-cupon-linea">
                    ${t.ErrorCupon ? `<div class="alert alert-warning"><span>${escaparHtml(t.ErrorCupon)}</span></div>` : ""}
                    ${t.Cupon ? `<div class="ms-cupon-aplicado"><span><i class="bi bi-ticket-perforated"></i> Cupón <b>${escaparHtml(t.Cupon)}</b>: ahorras ${pesos(t.Descuento)}</span>
                        <button type="button" class="btn btn-link btn-sm" data-quitar-cupon="${t.Id_Tienda}">Quitar</button></div>`
                    : `<div class="input-group"><label class="visually-hidden" for="cupon${t.Id_Tienda}">Cupón para ${escaparHtml(t.Nombre_Tienda)}</label>
                        <input type="text" class="form-control" id="cupon${t.Id_Tienda}" placeholder="¿Tienes un cupón de esta tienda?" maxlength="50">
                        <button class="btn btn-outline-ms" type="button" data-aplicar-cupon="${t.Id_Tienda}">Aplicar</button></div>`}
                </div>
                <div class="ms-qr" data-qr="${t.Id_Tienda}" hidden>
                    ${t.Imagen_QR ? `<p class="mb-2">Escanea el QR de ${escaparHtml(t.Nombre_Tienda)} y paga <strong>${pesos(t.Subtotal - t.Descuento)}</strong>.</p>
                        <img src="${rutaImagen(t.Imagen_QR)}" alt="Código QR de pago de ${escaparHtml(t.Nombre_Tienda)}">` : ""}
                    <label class="form-label" for="comprobante_${t.Id_Tienda}">Comprobante de pago (imagen o PDF)</label>
                    <input type="file" class="form-control" id="comprobante_${t.Id_Tienda}" name="comprobante_${t.Id_Tienda}" accept="image/*,application/pdf">
                </div>
            </div>
        </section>`).join("");

    document.getElementById("resumenPago").innerHTML = `<h2>Resumen</h2>
        <dl>${d.tiendas.map(t => `<div><dt>${escaparHtml(t.Nombre_Tienda)}</dt><dd>${pesos(t.Subtotal)}</dd></div>`).join("")}
            ${d.descuento > 0 ? `<div class="ahorro"><dt>Cupones</dt><dd>-${pesos(d.descuento)}</dd></div>` : ""}</dl>
        <div class="ms-resumen-total"><span>Total</span><strong>${pesos(d.total)}</strong></div>
        <button type="submit" class="btn btn-ms-primary btn-lg btn-block">Confirmar pedido</button>
        <p id="mensajePago" class="ms-mensaje" role="status" aria-live="polite"></p>
        <p class="nota"><i class="bi bi-shield-check" aria-hidden="true"></i><span>Un solo pago unificado. Cada tienda recibe su orden al instante.</span></p>`;
    actualizarFormulario();

    document.querySelectorAll("[data-aplicar-cupon]").forEach(b => b.addEventListener("click", async () => {
        const id = Number(b.dataset.aplicarCupon);
        const r = await api("apiCarrito.php?accion=aplicarCupon", { idTienda: id, codigo: document.getElementById("cupon" + id).value });
        avisarResultado(r);
        if (r.ok) cargarCheckout(false);
    }));
    document.querySelectorAll("[data-quitar-cupon]").forEach(b => b.addEventListener("click", async () => {
        await api("apiCarrito.php?accion=quitarCupon", { idTienda: Number(b.dataset.quitarCupon) });
        cargarCheckout(false);
    }));
}

function actualizarFormulario() {
    const entrega = formulario.tipoEntrega.value;
    document.getElementById("bloqueRetiro").hidden = entrega !== "RetiroTienda";
    document.getElementById("direccionPropia").hidden = entrega !== "DomicilioPropio";
    document.getElementById("bloqueOtro").hidden = entrega !== "DomicilioOtro";
    ["destinatario", "telefono", "direccionOtra"].forEach(c => formulario[c].required = entrega === "DomicilioOtro");
    const metodo = formulario.metodoPago?.value;
    document.getElementById("avisoContraentrega").hidden = metodo !== "Contraentrega";
    document.querySelectorAll("[data-qr]").forEach(c => {
        c.hidden = metodo !== "QR";
        c.querySelector("input[type=file]").required = metodo === "QR";
    });
}

async function confirmarPedido(evento) {
    evento.preventDefault();
    const boton = formulario.querySelector("button[type=submit]");
    const mensaje = document.getElementById("mensajePago");
    const datos = new FormData(formulario);
    const entrega = formulario.tipoEntrega.value;
    datos.set("direccion", entrega === "DomicilioOtro" ? formulario.direccionOtra.value : document.getElementById("direccionPropia").dataset.direccion);
    datos.delete("direccionOtra");
    boton.disabled = true;
    mostrarMensaje(mensaje, "Confirmando tu pedido...");
    const resultado = await api("apiCarrito.php?accion=confirmar", datos);
    if (resultado.ok) {
        location.href = `factura.html?id=${resultado.data.idFactura}&nuevo=1`;
        return;
    }
    boton.disabled = false;
    mostrarMensaje(mensaje, resultado.message, "error");
    if (resultado.status === 409) cargarCheckout(false);
}
