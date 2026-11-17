<?php
header("content-type: application/json; charset=UTF-8");
require_once __DIR__ . '/../Modelo/Carrito.php';
require_once __DIR__ . '/../Modelo/Factura.php';

try {
    $accion = $_GET['accion'] ?? '';
    $usuario = requerirRol(ROL_CLIENTE);
    $carrito = new carrito($usuario['id']);
    $facturas = new factura($usuario['id']);

    switch ($accion) {
        case 'ver':
            responder(200, true, '', $carrito->ver());

        case 'agregar':
            exigirPost();
            $datos = leerDatos();
            $talla = texto($datos, 'talla', 50);
            $color = texto($datos, 'color', 50);
            $mensaje = $carrito->agregar(entero($datos, 'idProducto'), entero($datos, 'cantidad', 1), $talla === '' ? null : $talla, $color === '' ? null : $color);
            responder(200, true, $mensaje);

        case 'cantidad':
            exigirPost();
            $datos = leerDatos();
            responder(200, true, $carrito->actualizarCantidad(entero($datos, 'idDetalle'), entero($datos, 'cantidad')));

        case 'quitar':
            exigirPost();
            $datos = leerDatos();
            responder(200, true, $carrito->quitar(entero($datos, 'idDetalle')));

        case 'checkout':
            responder(200, true, '', $carrito->checkout());

        case 'aplicarCupon':
            exigirPost();
            $datos = leerDatos();
            responder(200, true, $carrito->aplicarCupon(entero($datos, 'idTienda'), texto($datos, 'codigo', 50)));

        case 'quitarCupon':
            exigirPost();
            $datos = leerDatos();
            responder(200, true, $carrito->quitarCupon(entero($datos, 'idTienda')));

        case 'confirmar':
            exigirPost();
            $idFactura = $carrito->confirmar(leerDatos(), $_FILES);
            responder(201, true, "¡Pedido confirmado! Tu factura fue generada.", ['idFactura' => $idFactura]);

        case 'historial':
            responder(200, true, '', $facturas->historial());

        case 'factura':
            responder(200, true, '', $facturas->detalle((int)($_GET['id'] ?? 0)));

        case 'confirmarRecepcion':
            exigirPost();
            $datos = leerDatos();
            $facturas->confirmarRecepcion(entero($datos, 'idFacturaTienda'));
            responder(200, true, "¡Gracias! Confirmaste la recepción de tu pedido.");

        default:
            throw new Exception("Acción no válida", 400);
    }
} catch (Throwable $e) {
    manejarError($e);
}
