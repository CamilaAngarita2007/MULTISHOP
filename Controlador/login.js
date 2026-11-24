<!DOCTYPE html>
<html lang="es" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="color-scheme" content="light dark">
    <title>Iniciar sesión - MULTISHOP</title>
    <link rel="icon" type="image/png" href="../Assets/img/LOGO.png">
    <link rel="preload" href="../Assets/fonts/bricolage-grotesque-latin-wght-normal.woff2" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="../Assets/fonts/figtree-latin-wght-normal.woff2" as="font" type="font/woff2" crossorigin>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../Assets/css/tokens.css">
    <link rel="stylesheet" href="../Assets/css/base.css">
    <link rel="stylesheet" href="../Assets/css/components.css">
    <link rel="stylesheet" href="../Assets/css/layout.css">
    <link rel="stylesheet" href="../Assets/css/pages.css">
    <link rel="stylesheet" href="../Assets/css/pages-catalogo.css">
    <link rel="stylesheet" href="../Assets/css/pages-cuenta.css">
    <link rel="stylesheet" href="../Assets/css/pages-paneles.css">
    <link rel="stylesheet" href="../Assets/css/multishop.css">
    <script>
        // Tema guardado antes de dibujar (sin parpadeo).
        try { var t = localStorage.getItem('ms-tema'); if (t === 'dark') { document.documentElement.setAttribute('data-theme', 'dark'); document.documentElement.setAttribute('data-bs-theme', 'dark'); } } catch (e) { }
    </script>
</head>
<body>
<a href="#contenido" class="ms-saltar">Saltar al contenido</a>
<div class="ms-auth">
    <aside class="ms-auth-marca">
        <a class="ms-brand" href="Inicio.html" aria-label="MultiShop, inicio"><img src="../Assets/img/LOGO.png" alt="" width="44" height="44"><span>MultiShop</span></a>
        <div class="texto">
            <h2>Todas tus tiendas favoritas, en un solo lugar.</h2>
            <p>Compra en varias tiendas y paga una sola vez. Cada tienda conserva su identidad.</p>
        </div>
        <div class="texto pie">Hecho en Duitama, Boyacá. Proyecto académico ADSO.</div>
    </aside>
    <main id="contenido" class="ms-auth-form" tabindex="-1">
        <div class="ms-auth-arriba">
            <a class="ms-auth-inicio" href="Inicio.html" aria-label="Volver al inicio"><i class="bi bi-arrow-left"></i><span>Volver al inicio</span></a>
            <button id="btnModoOscuro" type="button" class="ms-icon-btn" title="Cambiar entre modo claro y oscuro" aria-label="Cambiar entre modo claro y oscuro"><i class="bi bi-moon-stars"></i></button>
        </div>
        <div class="ms-auth-caja">
            <h1>Iniciar sesión</h1>
            <p class="sub">Entra para comprar, seguir tus pedidos y hablar con las tiendas.</p>
            <form id="formLogin" method="post">
                <div class="campo">
                    <label for="correo" class="form-label">Correo electrónico</label>
                    <input type="email" id="correo" name="correo" class="form-control" autocomplete="email" required autofocus>
                </div>
                <div class="campo">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <div class="ms-clave"><input type="password" id="contrasena" name="contrasena" class="form-control" autocomplete="current-password" required >
                <button type="button" data-ver-clave aria-label="Mostrar contraseña" aria-pressed="false"><i class="bi bi-eye"></i></button></div>
                </div>
                <button type="submit" class="btn btn-ms-primary btn-lg btn-block">Entrar</button>
                <p id="mensajeLogin" class="ms-mensaje" role="status" aria-live="polite"></p>
            </form>
            <p class="ms-auth-pie ms-auth-ayuda">¿No tienes cuenta? <a href="registro.html">Regístrate</a></p>
        </div>
    </main>
</div>
<script>
    // Mostrar u ocultar la contraseña
    document.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ver-clave]');
        if (!b) return;
        var campo = b.parentElement.querySelector('input');
        var visible = campo.type === 'text';
        campo.type = visible ? 'password' : 'text';
        b.setAttribute('aria-pressed', visible ? 'false' : 'true');
        b.setAttribute('aria-label', visible ? 'Mostrar contraseña' : 'Ocultar contraseña');
        b.firstElementChild.className = visible ? 'bi bi-eye' : 'bi bi-eye-slash';
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../Controlador/comun.js"></script>
<script src="../Controlador/login.js"></script>
</body>
</html>
