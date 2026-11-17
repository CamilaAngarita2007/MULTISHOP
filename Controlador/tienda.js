document.addEventListener("DOMContentLoaded", async () => {
    const sesion = await cargarSesion();
    const formulario = document.getElementById("formFiltros");
    let primeraVez = true;
    let irAPagina;

    async function consultar(filtros) {
        const resultado = await api(`apiCatalogo.php?accion=tienda&${filtros.includes("id=") ? filtros : "id=" + Number(parametro("id")) + "&" + filtros}`);
        if (!resultado.ok) {
            document.getElementById("contenido").innerHTML = `<div class="container py-5">${vacio("bi-shop", escaparHtml(resultado.message), "", '<a class="btn btn-ms-primary" href="categorias.html">Ver tiendas</a>')}</div>`;
            return;
        }
        const { tienda, listado } = resultado.data;
        if (primeraVez) {
            pintarTienda(tienda, sesion);
            primeraVez = false;
        }
        const filtrado = hayFiltros(formulario);
        document.getElementById("conteo").textContent = `${listado.total} ${listado.total === 1 ? "producto" : "productos"}${filtrado ? " con estos filtros" : ""}`;
        document.getElementById("productos").innerHTML = listado.productos.length
            ? `<div class="ms-grid">${listado.productos.map(p => tarjetaProducto(p, false)).join("")}</div>`
            : vacio("bi-box-seam", filtrado ? "Ningún producto cumple esos filtros" : "Esta tienda aún no tiene productos",
                filtrado ? "Prueba quitando alguno o buscando con otras palabras." : "Vuelve pronto: el vendedor está preparando su catálogo.");
        pintarPaginador(document.getElementById("paginador"), listado.pagina, listado.totalPaginas, n => irAPagina(n));
    }
    irAPagina = iniciarFiltros(formulario, consultar);
});

function pintarTienda(t, sesion) {
    document.title = `${t.Nombre_Tienda} - MULTISHOP`;
    aplicarColorTienda(t.Paleta_Colores);
    const banner = document.getElementById("bannerTienda");
    if (t.Fondo_Navbar) {
        banner.classList.remove("sin-imagen");
        banner.style.backgroundImage = urlFondo(t.Fondo_Navbar);
    }
    const icono = iconoCategoria(t.Nombre_Categoria);
    document.getElementById("decoTienda").className = `tb-deco bi ${icono}`;
    const logo = document.getElementById("logoTienda");
    logo.src = rutaImagen(t.Logo);
    logo.alt = "Logo de " + t.Nombre_Tienda;
    document.getElementById("nombreTienda").textContent = t.Nombre_Tienda;
    document.getElementById("categoriaTienda").innerHTML = `<i class="bi ${icono}"></i>${escaparHtml(t.Nombre_Categoria)}`;

    const total = Number(t.calificacion.Total);
    const meta = [total
        ? `<li>${estrellas(t.calificacion.Promedio)}<span><b>${Number(t.calificacion.Promedio).toFixed(1)}</b> (${total} ${total === 1 ? "calificación" : "calificaciones"})</span></li>`
        : `<li><i class="bi bi-star"></i><span>Sin calificaciones aún</span></li>`];
    if (t.Direccion) meta.push(`<li><i class="bi bi-geo-alt"></i><span>${escaparHtml(t.Direccion)}</span></li>`);
    if (t.Horario) meta.push(`<li><i class="bi bi-clock"></i><span>${escaparHtml(t.Horario)}</span></li>`);
    document.getElementById("metaTienda").innerHTML = meta.join("");

    const acciones = document.getElementById("accionesTienda");
    if (!sesion) {
        acciones.innerHTML = `<a href="login.html?volver=${encodeURIComponent("tienda.html?id=" + t.Id_Tienda)}" class="btn tb-btn"><i class="bi bi-box-arrow-in-right"></i>Inicia sesión para chatear</a>`;
    } else if (sesion.rol === "Cliente") {
        acciones.innerHTML = `<a href="chat.html?con=${t.Id_Usuario}" class="btn tb-btn"><i class="bi bi-chat-dots"></i>Chatear con la tienda</a>
            <button type="button" class="btn tb-btn-linea" data-bs-toggle="modal" data-bs-target="#modalCalificar"><i class="bi bi-star"></i>${t.miCalificacion ? "Editar mi calificación" : "Calificar tienda"}</button>
            <a href="pqrs.html?tienda=${t.Id_Tienda}" class="btn tb-btn-linea"><i class="bi bi-chat-square-text"></i>Enviar PQRS</a>`;
        prepararCalificacion(t);
    } else if (sesion.rol === "Admin") {
        acciones.innerHTML = `<a href="chat.html?con=${t.Id_Usuario}" class="btn tb-btn"><i class="bi bi-chat-dots"></i>Escribir al vendedor</a>`;
    }

    const info = [];
    if (t.cupon) {
        const c = t.cupon;
        const descuento = c.Tipo_Descuento === "Porcentaje" ? `${Number(c.Valor)}% de descuento` : `${pesos(c.Valor)} de descuento`;
        const detalle = "Úsalo al pagar" + (c.Compra_Minima ? " · compra mínima " + pesos(c.Compra_Minima) : "") + " · válido hasta el " + fecha(c.Fecha_Fin);
        info.push(`<aside class="tb-cupon" aria-label="Cupón de la tienda"><div class="tb-cupon-texto"><strong>${descuento} en ${escaparHtml(t.Nombre_Tienda)}</strong>
            <span>${detalle}</span></div><div class="ms-cupon-tarjeta"><span class="ms-cupon-codigo">${escaparHtml(c.Codigo)}</span></div></aside>`);
    }
    t.avisos.forEach(a => info.push(`<div class="tb-aviso"><i class="bi bi-megaphone" aria-hidden="true"></i>${a.Tipo === "Imagen"
        ? `<img src="${rutaImagen(a.Contenido)}" alt="Aviso de ${escaparHtml(t.Nombre_Tienda)}" loading="lazy">` : `<p>${escaparHtml(a.Contenido)}</p>`}</div>`));
    const contenedor = document.getElementById("infoTienda");
    contenedor.hidden = !info.length;
    contenedor.innerHTML = info.join("");
}