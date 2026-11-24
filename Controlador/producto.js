let producto = null;

document.addEventListener("DOMContentLoaded", async () => {
    await cargarSesion();
    cargarProducto(Number(parametro("paginaResenas")) || 1);
});

async function cargarProducto(paginaResenas) {
    const resultado = await api(`apiCatalogo.php?accion=producto&id=${Number(parametro("id"))}&paginaResenas=${paginaResenas}`);
    if (!resultado.ok) {
        document.getElementById("contenido").innerHTML = `<div class="container py-5">${vacio("bi-box-seam", escaparHtml(resultado.message), "", '<a class="btn btn-ms-primary" href="buscar.html">Ver catálogo</a>')}</div>`;
        return;
    }
    const primeraVez = producto === null;
    producto = resultado.data;
    if (primeraVez) pintarProducto();
    pintarResenas();
}

function pintarProducto() {
    const p = producto;
    const esCliente = sesionActual?.rol === "Cliente";
    document.title = `${p.Nombre_Producto} - MULTISHOP`;
    aplicarColorTienda(p.Paleta_Colores);

    document.getElementById("migaTienda").href = `tienda.html?id=${p.Id_Tienda}`;
    document.getElementById("migaTienda").textContent = p.Nombre_Tienda;
    document.getElementById("migaProducto").textContent = p.Nombre_Producto;
    const enlaceTienda = document.getElementById("enlaceTienda");
    enlaceTienda.href = `tienda.html?id=${p.Id_Tienda}`;
    enlaceTienda.innerHTML = `<img src="${rutaImagen(p.Logo_Tienda)}" alt=""><span>${escaparHtml(p.Nombre_Tienda)}</span>`;
    document.getElementById("nombreProducto").textContent = p.Nombre_Producto;

    const total = Number(p.Total_Resenas);
    document.getElementById("valoracion").innerHTML = total
        ? `${estrellas(p.Promedio)}<a href="#resenas">${Number(p.Promedio).toFixed(1)} · ${total} ${total === 1 ? "opinión" : "opiniones"}</a>`
        : `<a href="#resenas" class="text-muted">Aún sin opiniones</a>`;

    const oferta = Number(p.En_Oferta) === 1;
    const descuento = oferta ? Math.round((1 - p.Precio_Vigente / p.Precio) * 100) : 0;
    document.getElementById("precio").innerHTML = `<span class="ms-precio-grande${oferta ? " oferta" : ""}">${pesos(p.Precio_Vigente)}</span>` +
        (oferta ? `<span class="antes"><span class="visually-hidden">Precio anterior </span>${pesos(p.Precio)}</span>${descuento > 0 ? `<span class="pd-descuento">-${descuento}%</span>` : ""}` : "");
    const nota = document.getElementById("notaOferta");
    nota.hidden = !(oferta && p.Fecha_Fin_Rebaja);
    if (oferta && p.Fecha_Fin_Rebaja) nota.textContent = "Oferta hasta el " + fecha(p.Fecha_Fin_Rebaja);
    const descripcion = document.getElementById("descripcion");
    descripcion.textContent = (p.Descripcion || "").trim() + (p.Variante ? `\nPresentación: ${p.Variante}` : "");
    descripcion.hidden = !descripcion.textContent.trim();

    const stock = Number(p.Stock);
    const lineaStock = document.getElementById("stock");
    lineaStock.className = "pd-stock " + (stock <= 0 ? "agotado" : stock <= 5 ? "poco" : "ok");
    lineaStock.innerHTML = stock <= 0 ? `<i class="bi bi-x-circle"></i>Agotado` : stock <= 5 ? `<i class="bi bi-exclamation-circle"></i>Quedan solo ${stock}` : `<i class="bi bi-check-circle"></i>Disponible (${stock} en stock)`;

    // Galería: foto principal, adicionales y la de cada color.
    const galeria = p.galeria.length ? p.galeria : [{ imagen: null, color: null }];
    const principal = document.getElementById("galeriaPrincipal");
    const mostrar = indice => {
        principal.src = rutaImagen(galeria[indice].imagen);
        principal.alt = p.Nombre_Producto + (galeria[indice].color ? " - " + galeria[indice].color : "");
        document.querySelectorAll(".pd-mini").forEach((b, i) => b.classList.toggle("activa", i === indice));
    };
    const minis = document.getElementById("galeriaMiniaturas");
    minis.hidden = galeria.length < 2;
    minis.innerHTML = galeria.map((g, i) => `<button type="button" class="pd-mini" data-indice="${i}" aria-label="Ver foto ${i + 1}"><img src="${rutaImagen(g.imagen)}" alt="" loading="lazy"></button>`).join("");
    minis.querySelectorAll(".pd-mini").forEach(b => b.addEventListener("click", () => mostrar(Number(b.dataset.indice))));
    mostrar(0);

    // Compra: solo clientes. El visitante ve "Inicia sesión para comprar"; vendedor y admin, un aviso.
    const compra = document.getElementById("zonaCompra");
    if (!sesionActual) {
        compra.innerHTML = `<a href="login.html?volver=${encodeURIComponent(location.pathname.split("/").pop() + location.search)}" class="btn btn-ms-primary btn-lg"><i class="bi bi-box-arrow-in-right"></i>Inicia sesión para comprar</a>`;
    } else if (!esCliente) {
        compra.innerHTML = `<div class="alert alert-secondary"><span>Estás viendo el producto como ${sesionActual.rol === "Vendedor" ? "vendedor" : "administrador"}; las compras son solo para clientes.</span></div>`;
    } else {
        const max = Math.max(Math.min(stock, 99), 1);
        const deshabilitado = stock <= 0 ? "disabled" : "";
        const favorito = Number(p.Es_Favorito) === 1;
        compra.innerHTML = `<form class="pd-compra" id="formAgregar">
            ${p.tallas.length ? `<fieldset class="pd-grupo"><legend class="pd-etiqueta">Talla</legend><div class="ms-opciones">${p.tallas.map(t =>
                `<label class="ms-opcion"><input type="radio" name="talla" value="${escaparHtml(t)}" required><span>${escaparHtml(t)}</span></label>`).join("")}</div></fieldset>` : ""}
            ${p.colores.length ? `<fieldset class="pd-grupo"><legend class="pd-etiqueta">Color</legend><div class="ms-opciones">${p.colores.map(c =>
                `<label class="ms-opcion"><input type="radio" name="color" value="${escaparHtml(c.Nombre_Color)}" required><span>${c.Color_Hex ? `<i class="ms-color-punto" style="background-color:${c.Color_Hex}"></i>` : ""}${escaparHtml(c.Nombre_Color)}</span></label>`).join("")}</div></fieldset>` : ""}
            <div class="pd-grupo">
                <label class="pd-etiqueta" for="inpCantidad">Cantidad</label>
                <div class="ms-qty">
                    <button type="button" data-qty="-1" aria-label="Quitar una unidad" ${deshabilitado}><i class="bi bi-dash-lg"></i></button>
                    <input type="number" name="cantidad" id="inpCantidad" value="1" min="1" max="${max}" inputmode="numeric" required ${deshabilitado}>
                    <button type="button" data-qty="1" aria-label="Agregar una unidad" ${deshabilitado}><i class="bi bi-plus-lg"></i></button>
                </div>
            </div>
            <div class="pd-fila-comprar">
                <button type="submit" class="btn btn-ms-primary btn-lg" ${deshabilitado}><i class="bi ${stock <= 0 ? "bi-slash-circle" : "bi-bag-plus"}"></i>${stock <= 0 ? "Agotado" : "Agregar al carrito"}</button>
                <button type="button" class="btn btn-outline-secondary btn-lg pd-fav${favorito ? " on" : ""}" id="botonFavorito" aria-pressed="${favorito}" aria-label="${favorito ? "Quitar de favoritos" : "Guardar en favoritos"}">
                    <i class="bi ${favorito ? "bi-heart-fill" : "bi-heart"}"></i></button>
            </div>
            <p id="mensajeAgregar" class="ms-mensaje" role="status" aria-live="polite"></p>
        </form>`;
        const formulario = document.getElementById("formAgregar");
        formulario.addEventListener("change", e => {
            if (e.target.name !== "color") return;
            const indice = galeria.findIndex(g => g.color === e.target.value);
            if (indice >= 0) mostrar(indice);
        });
        formulario.addEventListener("submit", async e => {
            e.preventDefault();
            const datos = Object.fromEntries(new FormData(formulario).entries());
            datos.idProducto = p.Id_Producto;
            const resultado = await api("apiCarrito.php?accion=agregar", datos);
            mostrarMensaje(document.getElementById("mensajeAgregar"), resultado.message, resultado.ok ? "" : "error");
            if (resultado.ok) refrescarContadores();
        });
        document.getElementById("botonFavorito").addEventListener("click", async () => {
            const r = await api("apiCliente.php?accion=alternarFavorito", { idProducto: p.Id_Producto });
            if (!r.ok) return avisarResultado(r);
            const b = document.getElementById("botonFavorito");
            b.classList.toggle("on", r.data.favorito);
            b.setAttribute("aria-pressed", r.data.favorito);
            b.setAttribute("aria-label", r.data.favorito ? "Quitar de favoritos" : "Guardar en favoritos");
            b.innerHTML = `<i class="bi ${r.data.favorito ? "bi-heart-fill" : "bi-heart"}"></i>`;
            avisar(r.message);
        });
    }
    document.getElementById("secundarios").innerHTML = (esCliente ? `<a href="chat.html?con=${p.Id_Vendedor}" class="btn btn-soft btn-sm"><i class="bi bi-chat-dots"></i>Preguntar al vendedor</a>` : "") +
        `<a href="tienda.html?id=${p.Id_Tienda}" class="btn btn-soft btn-sm"><i class="bi bi-shop"></i>Ver la tienda</a>`;

    if (p.relacionados.length) {
        document.getElementById("seccionRelacionados").hidden = false;
        document.getElementById("tituloRelacionados").textContent = "Más de " + p.Nombre_Tienda;
        document.getElementById("verTienda").href = `tienda.html?id=${p.Id_Tienda}`;
        document.getElementById("relacionados").innerHTML = p.relacionados.map(r => tarjetaProducto(r, false)).join("");
    }
}

function pintarResenas() {
    const p = producto;
    const r = p.resenas;
    const total = Number(p.Total_Resenas);
    document.getElementById("resumenResenas").innerHTML = total === 0
        ? `<p class="pd-sin-opiniones">Todavía nadie ha opinado sobre este producto.</p>`
        : `<div class="pd-promedio"><b>${Number(p.Promedio).toFixed(1)}</b><div>${estrellas(p.Promedio)}<small>${total} ${total === 1 ? "opinión" : "opiniones"}</small></div></div>
           <ul class="pd-barras" aria-label="Opiniones por número de estrellas">${[5, 4, 3, 2, 1].map(n => {
               const cantidad = r.distribucion[n - 1];
               return `<li><span>${n}<i class="bi bi-star-fill" aria-hidden="true"></i></span><progress class="pd-progreso" value="${cantidad}" max="${total}" aria-label="${n} estrellas: ${cantidad}"></progress><span>${cantidad}</span></li>`;
           }).join("")}</ul>`;

    // Formulario de reseña: solo clientes que ya recibieron el producto.
    const zona = document.getElementById("zonaResena");
    if (sesionActual?.rol !== "Cliente") zona.innerHTML = "";
    else if (!p.puedeResenar) zona.innerHTML = `<p class="text-muted"><i class="bi bi-info-circle"></i> Podrás dejar tu opinión cuando recibas este producto.</p>`;
    else {
        const mia = p.miResena;
        zona.innerHTML = `<form class="pd-form-resena" id="formResena">
            <h3>${mia ? "Tu opinión (puedes editarla)" : "Cuéntanos qué te pareció"}</h3>
            <fieldset class="pd-estrellas-input"><legend class="visually-hidden">Puntuación</legend>
                ${[5, 4, 3, 2, 1].map(n => `<input type="radio" name="puntuacion" id="estrella${n}" value="${n}" ${mia && Number(mia.Puntuacion) === n ? "checked" : ""} required>
                <label for="estrella${n}" title="${n} de 5"><i class="bi bi-star-fill"></i><span class="visually-hidden">${n} de 5</span></label>`).join("")}
            </fieldset>
            <textarea name="comentario" class="form-control" rows="3" maxlength="500" aria-label="Comentario" placeholder="Opcional: calidad, tallas, tiempo de entrega...">${escaparHtml(mia?.Comentario || "")}</textarea>
            <div class="acciones"><button type="submit" class="btn btn-ms-primary">Publicar opinión</button>
                ${mia ? `<button type="button" class="btn btn-outline-danger" id="eliminarResena">Eliminar</button>` : ""}</div>
            <p id="mensajeResena" class="ms-mensaje" role="status" aria-live="polite"></p>
        </form>`;
        const formulario = document.getElementById("formResena");
        formulario.addEventListener("submit", async e => {
            e.preventDefault();
            const datos = Object.fromEntries(new FormData(formulario).entries());
            datos.idProducto = p.Id_Producto;
            const resultado = await api("apiCliente.php?accion=guardarResena", datos);
            if (resultado.ok) { avisar(resultado.message); cargarProducto(1); }
            else mostrarMensaje(document.getElementById("mensajeResena"), resultado.message, "error");
        });
        document.getElementById("eliminarResena")?.addEventListener("click", async () => {
            if (avisarResultado(await api("apiCliente.php?accion=eliminarResena", { idProducto: p.Id_Producto }))) cargarProducto(1);
        });
    }

    document.getElementById("listaResenas").innerHTML = r.items.length ? `<ul class="pd-lista">${r.items.map(x => `
        <li class="pd-resena"><div class="pd-resena-cab"><strong>${escaparHtml(x.nombre)}</strong>${x.esMia ? '<span class="badge">Tú</span>' : ""}
            ${estrellas(x.puntuacion)}<time datetime="${String(x.fecha).slice(0, 10)}">${fecha(x.fecha)}</time></div>
            ${x.comentario ? `<p>${escaparHtml(x.comentario)}</p>` : ""}</li>`).join("")}</ul>` : "";
    pintarPaginador(document.getElementById("paginadorResenas"), r.pagina, r.totalPaginas, n => cargarProducto(n));
}
