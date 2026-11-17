document.addEventListener("DOMContentLoaded", async () => {
    await cargarSesion();
    const formulario = document.getElementById("formTiendas");
    formulario.q.value = parametro("q") || "";

    async function consultar(idCategoria) {
        const q = formulario.q.value.trim();
        const resultado = await api(`apiCatalogo.php?accion=tiendas&categoria=${idCategoria}&q=${encodeURIComponent(q)}`);
        if (!resultado.ok) return avisar(resultado.message, "error");
        const { categorias, tiendas } = resultado.data;
        formulario.dataset.categoria = idCategoria;

        document.getElementById("chipsCategorias").innerHTML = `<a class="ms-chip${!idCategoria ? " is-active" : ""}" href="categorias.html" data-categoria=""><i class="bi bi-grid"></i>Todas</a>` +
            categorias.map(c => `<a class="ms-chip${String(c.Id_Categoria) === String(idCategoria) ? " is-active" : ""}" href="categorias.html?categoria=${c.Id_Categoria}"
                data-categoria="${c.Id_Categoria}"><i class="bi ${iconoCategoria(c.Nombre_Categoria)}"></i>${escaparHtml(c.Nombre_Categoria)} (${c.Tiendas})</a>`).join("");
        document.querySelectorAll("#chipsCategorias [data-categoria]").forEach(chip => chip.addEventListener("click", e => {
            e.preventDefault();
            history.replaceState(null, "", chip.href);
            consultar(chip.dataset.categoria);
        }));

        const elegida = categorias.find(c => String(c.Id_Categoria) === String(idCategoria));
        document.getElementById("tituloTiendas").textContent = elegida ? elegida.Nombre_Categoria : "Tiendas";
        document.getElementById("conteoTiendas").textContent = `${tiendas.length} ${tiendas.length === 1 ? "tienda" : "tiendas"}${q ? ` con "${q}"` : ""}`;
        document.getElementById("listaTiendas").innerHTML = tiendas.length
            ? `<div class="ms-grid ms-grid-tiendas">${tiendas.map(tarjetaTienda).join("")}</div>`
            : vacio("bi-shop", "No encontramos tiendas", "Prueba con otra categoría o con otro nombre.");
    }

    formulario.addEventListener("submit", e => { e.preventDefault(); consultar(formulario.dataset.categoria || ""); });
    consultar(parametro("categoria") || "");
});
