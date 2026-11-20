const formulario = document.getElementById("formCupon");
let clientes = [];

document.addEventListener("DOMContentLoaded", async () => {
    if (!await iniciarPanel("vendedor")) return;
    formulario.inicio.value = new Date().toISOString().slice(0, 10);
    formulario.fin.value = new Date(Date.now() + 30 * 86400000).toISOString().slice(0, 10);
    formulario.tipo.addEventListener("change", () => {
        document.getElementById("unidadValor").textContent = formulario.tipo.value === "Porcentaje" ? "%" : "$";
        formulario.valor.max = formulario.tipo.value === "Porcentaje" ? 100 : "";
    });
    cargarCupones();
});

async function cargarCupones() {
    const resultado = await api("apiVendedor.php?accion=cupones");
    if (!resultado.ok) return avisar(resultado.message, "error");
    clientes = resultado.data.clientes;
    const lista = document.getElementById("listaCupones");
    const opciones = clientes.map(c => `<option value="${c.Id_Usuario}">${escaparHtml(c.Nombre + " " + c.Apellido)}</option>`).join("");
    lista.innerHTML = resultado.data.cupones.length ? `<div class="ms-card pn-tabla"><table class="table pn-apilable">
        <thead><tr><th>Código</th><th>Descuento</th><th>Vigencia</th><th class="num">Usos</th><th>Estado</th><th class="num">Acciones</th></tr></thead>
        <tbody>${resultado.data.cupones.map(c => `<tr>
            <td class="principal"><span class="ms-cupon-codigo">${escaparHtml(c.Codigo)}</span></td>
            <td data-label="Descuento">${escaparHtml(c.Descripcion)}${c.Compra_Minima ? `<span class="sec">Compra mínima ${pesos(c.Compra_Minima)}</span>` : ""}</td>
            <td data-label="Vigencia">${fecha(c.Fecha_Inicio)} – ${fecha(c.Fecha_Fin)}</td>
            <td class="num" data-label="Usos">${c.Usos}${c.Usos_Maximos ? " / " + c.Usos_Maximos : ""}</td>
            <td data-label="Estado">${insigniaEstado(c.EstadoVisible)}</td>
            <td class="sin-etiqueta"><div class="acciones">
                ${["Vigente", "Programado"].includes(c.EstadoVisible) && clientes.length ? `<form class="pn-seguimiento" data-enviar="${c.Id_cupones}">
                    <label class="visually-hidden" for="cliente${c.Id_cupones}">Enviar ${escaparHtml(c.Codigo)} a</label>
                    <select class="form-select form-select-sm" id="cliente${c.Id_cupones}" name="cliente" required><option value="">Enviar a...</option>${opciones}</select>
                    <button class="btn btn-sm btn-soft btn-icono" type="submit" aria-label="Enviar por chat"><i class="bi bi-send"></i></button></form>` : ""}
                <button class="btn btn-sm btn-outline-secondary" data-alternar="${c.Id_cupones}">${c.Estado === "Activo" ? "Desactivar" : "Activar"}</button>
                <button class="btn btn-sm btn-outline-danger btn-icono" data-eliminar="${c.Id_cupones}" aria-label="Eliminar ${escaparHtml(c.Codigo)}"><i class="bi bi-trash3"></i></button>
            </div></td></tr>`).join("")}</tbody></table></div>`
        : vacio("bi-ticket-perforated", "Aún no has creado cupones", "Crea un cupón y mándaselo a tus clientes por el chat.");

    lista.querySelectorAll("[data-enviar]").forEach(f => f.addEventListener("submit", async e => {
        e.preventDefault();
        avisarResultado(await api("apiVendedor.php?accion=enviarCupon", { idCliente: Number(f.cliente.value), idCupon: Number(f.dataset.enviar) }));
        f.reset();
    }));
    lista.querySelectorAll("[data-alternar]").forEach(b => b.addEventListener("click", async () => {
        avisarResultado(await api("apiVendedor.php?accion=alternarCupon", { idCupon: Number(b.dataset.alternar) }));
        cargarCupones();
    }));
    lista.querySelectorAll("[data-eliminar]").forEach(b => b.addEventListener("click", async () => {
        if (!confirm("¿Eliminar este cupón?")) return;
        avisarResultado(await api("apiVendedor.php?accion=eliminarCupon", { idCupon: Number(b.dataset.eliminar) }));
        cargarCupones();
    }));
}

formulario.addEventListener("submit", async e => {
    e.preventDefault();
    const resultado = await api("apiVendedor.php?accion=crearCupon", Object.fromEntries(new FormData(formulario).entries()));
    mostrarMensaje(document.getElementById("mensajeCupon"), resultado.message, resultado.ok ? "" : "error");
    if (resultado.ok) {
        formulario.codigo.value = "";
        formulario.valor.value = "";
        cargarCupones();
    }
});
