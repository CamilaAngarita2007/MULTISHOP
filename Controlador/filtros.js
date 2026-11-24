/* Filtros del catálogo (búsqueda global y página de tienda): leen y escriben la dirección para que se puedan compartir. */

function leerFiltrosDeUrl(formulario) {
    const params = new URLSearchParams(location.search);
    for (const campo of formulario.elements) {
        if (!campo.name || !params.has(campo.name)) continue;
        if (campo.type === "checkbox") campo.checked = params.get(campo.name) === "1";
        else campo.value = params.get(campo.name);
    }
}

function filtrosComoTexto(formulario, pagina = 1) {
    const params = new URLSearchParams();
    const id = parametro("id");
    if (id) params.set("id", id);
    for (const campo of formulario.elements) {
        if (!campo.name) continue;
        if (campo.type === "checkbox") { if (campo.checked) params.set(campo.name, "1"); }
        else if (campo.value !== "" && !(campo.name === "orden" && campo.value === "novedad")) params.set(campo.name, campo.value.trim());
    }
    if (pagina > 1) params.set("pagina", pagina);
    return params.toString();
}

function hayFiltros(formulario) {
    return [...formulario.elements].some(c => c.name && c.name !== "orden" && (c.type === "checkbox" ? c.checked : c.value !== ""));
}

// Igual que _Paginador.cshtml.
function pintarPaginador(contenedor, pagina, totalPaginas, alCambiar) {
    if (totalPaginas <= 1) { contenedor.innerHTML = ""; return; }
    const boton = (n, texto, deshabilitado, activo, etiqueta = "") => `<li class="page-item${deshabilitado ? " disabled" : ""}${activo ? " active" : ""}">
        <button class="page-link" type="button" data-pagina="${n}" ${activo ? 'aria-current="page"' : ""} ${etiqueta ? `aria-label="${etiqueta}"` : ""}>${texto}</button></li>`;
    let html = `<nav aria-label="Páginas" class="mt-4 d-flex justify-content-center"><ul class="pagination">`;
    html += boton(pagina - 1, '<i class="bi bi-chevron-left"></i>', pagina === 1, false, "Página anterior");
    for (let n = 1; n <= totalPaginas; n++) {
        if (n === 1 || n === totalPaginas || Math.abs(n - pagina) <= 2) html += boton(n, n, false, n === pagina);
        else if (Math.abs(n - pagina) === 3) html += `<li class="page-item disabled"><span class="page-link">…</span></li>`;
    }
    html += boton(pagina + 1, '<i class="bi bi-chevron-right"></i>', pagina === totalPaginas, false, "Página siguiente") + `</ul></nav>`;
    contenedor.innerHTML = html;
    contenedor.querySelectorAll("[data-pagina]").forEach(b => b.addEventListener("click", () => alCambiar(Number(b.dataset.pagina))));
}

// Conecta el formulario de filtros con la función que consulta y pinta los productos.
function iniciarFiltros(formulario, consultar) {
    leerFiltrosDeUrl(formulario);
    const quitar = formulario.querySelector(".fp-quitar");
    const ir = pagina => {
        const texto = filtrosComoTexto(formulario, pagina);
        history.replaceState(null, "", location.pathname + (texto ? "?" + texto : ""));
        if (quitar) quitar.hidden = !hayFiltros(formulario);
        consultar(texto);
    };
    formulario.addEventListener("submit", e => { e.preventDefault(); ir(1); });
    formulario.querySelectorAll("select, input[type=checkbox]").forEach(c => c.addEventListener("change", () => ir(1)));
    quitar?.addEventListener("click", () => { formulario.reset(); ir(1); });
    if (quitar) quitar.hidden = !hayFiltros(formulario);
    consultar(filtrosComoTexto(formulario, Number(parametro("pagina")) || 1));
    return ir;
}
