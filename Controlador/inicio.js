document.addEventListener("DOMContentLoaded", async () => {
    const sesion = await cargarSesion();
    const cta = document.getElementById("seccionCta");
    if (sesion && sesion.rol !== "Cliente") cta.hidden = true;
    else if (sesion) {
        cta.querySelector("a").href = "solicitarTienda.html";
        cta.querySelector("a").textContent = "Quiero abrir mi tienda";
    }

    const resultado = await api("apiCatalogo.php?accion=inicio");
    if (!resultado.ok) return avisar(resultado.message, "error");
    const datos = resultado.data;

    document.getElementById("cifraTiendas").textContent = datos.totalTiendas;
    document.getElementById("cifraProductos").textContent = datos.totalProductos;

    if (datos.carritoEjemplo.length) {
        document.getElementById("demoCarrito").hidden = false;
        document.getElementById("carritoEjemplo").innerHTML = datos.carritoEjemplo.map(p => `
            <li>
                <img class="foto" src="${rutaImagen(p.Imagen)}" alt="" loading="lazy">
                <div>
                    <span class="tienda"><img src="${rutaImagen(p.Logo_Tienda)}" alt="">${escaparHtml(p.Nombre_Tienda)}</span>
                    <span class="nombre">${escaparHtml(p.Nombre_Producto)}</span>
                </div>
                <span class="precio">${pesos(p.Precio_Vigente)}</span>
            </li>`).join("");
        document.getElementById("enviosEjemplo").textContent = `${datos.carritoEjemplo.length} envíos, un solo pago`;
    }

    document.getElementById("chipsCategorias").innerHTML = datos.categorias.map(c => `
        <a class="ms-chip" href="categorias.html?categoria=${c.Id_Categoria}"><i class="bi ${iconoCategoria(c.Nombre_Categoria)}"></i>${escaparHtml(c.Nombre_Categoria)}</a>`).join("");

    if (datos.tiendas.length) {
        document.getElementById("seccionTiendas").hidden = false;
        document.getElementById("tiendasDestacadas").innerHTML = datos.tiendas.map(tarjetaTienda).join("");
    }
    if (datos.ofertas.length) {
        document.getElementById("seccionOfertas").hidden = false;
        document.getElementById("ofertas").innerHTML = datos.ofertas.map(p => tarjetaProducto(p)).join("");
    }
    if (datos.nuevos.length) {
        document.getElementById("seccionNuevos").hidden = false;
        document.getElementById("nuevos").innerHTML = datos.nuevos.map(p => tarjetaProducto(p)).join("");
    }

    if (datos.anuncios.length) {
        const varios = datos.anuncios.length > 1;
        document.getElementById("seccionAnuncios").hidden = false;
        document.getElementById("carruselAnuncios").innerHTML = (varios ? `<div class="carousel-indicators">${datos.anuncios.map((a, i) =>
            `<button type="button" data-bs-target="#carruselAnuncios" data-bs-slide-to="${i}" class="${i === 0 ? "active" : ""}" ${i === 0 ? 'aria-current="true"' : ""} aria-label="Anuncio ${i + 1}"></button>`).join("")}</div>` : "") +
            `<div class="carousel-inner">${datos.anuncios.map((a, i) => {
                const imagen = `<img src="${rutaImagen(a.Imagen)}" alt="${escaparHtml(a.Titulo)}" loading="lazy" decoding="async">`;
                return `<div class="carousel-item${i === 0 ? " active" : ""}">${a.Id_Tienda ? `<a href="tienda.html?id=${a.Id_Tienda}">${imagen}</a>` : imagen}</div>`;
            }).join("")}</div>` +
            (varios ? `<button class="carousel-control-prev" type="button" data-bs-target="#carruselAnuncios" data-bs-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="visually-hidden">Anterior</span></button>
                <button class="carousel-control-next" type="button" data-bs-target="#carruselAnuncios" data-bs-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="visually-hidden">Siguiente</span></button>` : "");
        bootstrap.Carousel.getOrCreateInstance(document.getElementById("carruselAnuncios"), { ride: "carousel" });
    }
});
