document.addEventListener("DOMContentLoaded", async () => {
    if (!await protegerPagina("Cliente")) return;
    const resultado = await api("apiCarrito.php?accion=historial");
    if (!resultado.ok) return avisar(resultado.message, "error");
    document.getElementById("listaPedidos").innerHTML = resultado.data.length ? `<ul class="ms-pedidos">${resultado.data.map(f => {
        const estado = f.EstadoGeneral;
        const logos = (f.Logos || "").split("|").filter(Boolean).slice(0, 4);
        return `<li class="ms-pedido">
            <div><h2>Pedido #${f.Id_Factura}</h2><span class="fecha">${fecha(f.Fecha, true)}</span></div>
            <div class="ms-pedido-tiendas"><span class="ms-logos" aria-hidden="true">${logos.map(l => `<img src="${rutaImagen(l)}" alt="" loading="lazy">`).join("")}</span>
                <span>${escaparHtml(f.Tiendas)}</span></div>
            <div class="ms-pedido-monto"><strong>${pesos(f.Total)}</strong><small>${escaparHtml(f.Metodo_Pago)}</small></div>
            <div class="ms-pedido-estado">${insigniaEstado(estado)}
                <a href="factura.html?id=${f.Id_Factura}" class="btn btn-sm btn-outline-ms" aria-label="Ver el pedido #${f.Id_Factura}">Ver detalle</a></div>
        </li>`;
    }).join("")}</ul>` : vacio("bi-receipt", "Aún no tienes compras", "Cuando confirmes un pedido, aquí verás su factura y el seguimiento de cada tienda.",
        '<a class="btn btn-ms-primary" href="categorias.html">Explorar tiendas</a>');
});
