<?php
require_once __DIR__ . '/utilidades.php';
require_once __DIR__ . '/Cupon.php';

/* Carrito universal del cliente: productos de varias tiendas que se pagan juntos en una sola factura. */
class carrito
{
    const MAX_CANTIDAD = 99;

    private $conexion;
    private $idUsuario;

    public function __construct($idUsuario)
    {
        $this->conexion = conexionBD();
        $this->idUsuario = (int)$idUsuario;
    }

    private function idCarritoPendiente()
    {
        $consulta = $this->conexion->prepare("SELECT Id_Carrito FROM CarritosUniversales WHERE Id_Usuario = ? AND Estado = 'Pendiente' ORDER BY Id_Carrito DESC LIMIT 1");
        $consulta->execute([$this->idUsuario]);
        $id = $consulta->fetchColumn();
        if (!$id) {
            $this->conexion->prepare("INSERT INTO CarritosUniversales (Id_Usuario, Estado, Fecha_Creacion) VALUES (?, 'Pendiente', ?)")
                ->execute([$this->idUsuario, ahora()]);
            $id = $this->conexion->lastInsertId();
        }
        return (int)$id;
    }

    private function detalles($idCarrito)
    {
        $consulta = $this->conexion->prepare("SELECT d.Id_Detalle, d.Id_Producto, d.Cantidad, d.Subtotal, d.Talla_Seleccionada, d.Color_Seleccionado,
                p.Nombre_Producto, p.Imagen, p.Precio, p.Stock, p.Activo, p.Rebaja_Temporal, p.Precio_Rebajado, p.Fecha_Inicio_Rebaja, p.Fecha_Fin_Rebaja,
                t.Id_Tienda, t.Id_Usuario AS Id_Vendedor, t.Nombre_Tienda, t.Logo, t.Estado AS Estado_Tienda, t.Direccion,
                t.Metodos_Pago_Habilitados, t.Imagen_QR, t.Paleta_Colores
            FROM DetallesCarrito d JOIN Productos p ON p.Id_Producto = d.Id_Producto JOIN Tiendas t ON t.Id_Tienda = p.Id_Tienda
            WHERE d.Id_Carrito = ? ORDER BY t.Nombre_Tienda, d.Id_Detalle");
        $consulta->execute([$idCarrito]);
        return $consulta->fetchAll();
    }

    /* Recalcula cada subtotal con el precio vigente hoy (una rebaja pudo empezar o vencer). Devuelve true si algo cambió. */
    private function actualizarSubtotales(&$detalles)
    {
        $cambio = false;
        foreach ($detalles as &$d) {
            $d['Precio_Unitario'] = precioEfectivo($d);
            $subtotal = $d['Precio_Unitario'] * (int)$d['Cantidad'];
            if (abs($subtotal - (float)$d['Subtotal']) > 0.001) {
                $this->conexion->prepare("UPDATE DetallesCarrito SET Subtotal = ? WHERE Id_Detalle = ?")->execute([$subtotal, $d['Id_Detalle']]);
                $d['Subtotal'] = $subtotal;
                $cambio = true;
            }
            $d['Subtotal'] = (float)$d['Subtotal'];
        }
        return $cambio;
    }

    private function validarDisponibilidad($detalles)
    {
        $porProducto = [];
        foreach ($detalles as $d) {
            if (!$d['Activo'] || $d['Estado_Tienda'] !== 'Activa') {
                return "{$d['Nombre_Producto']} ya no está disponible. Quítalo del carrito para continuar.";
            }
            $porProducto[$d['Id_Producto']] = ($porProducto[$d['Id_Producto']] ?? 0) + (int)$d['Cantidad'];
        }
        foreach ($detalles as $d) {
            if ($d['Stock'] < $porProducto[$d['Id_Producto']]) {
                return "No hay stock suficiente de {$d['Nombre_Producto']} (quedan {$d['Stock']}).";
            }
        }
        return null;
    }

    private function agruparPorTienda($detalles)
    {
        $tiendas = [];
        foreach ($detalles as $d) {
            $id = $d['Id_Tienda'];
            if (!isset($tiendas[$id])) {
                $tiendas[$id] = ['Id_Tienda' => (int)$id, 'Id_Vendedor' => (int)$d['Id_Vendedor'], 'Nombre_Tienda' => $d['Nombre_Tienda'],
                    'Logo' => $d['Logo'], 'Direccion' => $d['Direccion'], 'Paleta_Colores' => $d['Paleta_Colores'], 'Imagen_QR' => $d['Imagen_QR'],
                    'Metodos' => array_values(array_filter(array_map('trim', explode(',', $d['Metodos_Pago_Habilitados'] ?: 'Contraentrega')))),
                    'Subtotal' => 0, 'Unidades' => 0, 'items' => []];
            }
            $tiendas[$id]['Subtotal'] += $d['Subtotal'];
            $tiendas[$id]['Unidades'] += (int)$d['Cantidad'];
            $tiendas[$id]['items'][] = $d;
        }
        return $tiendas;
    }

    /* Métodos de pago que aceptan todas las tiendas del carrito a la vez. */
    private function metodosEnComun($tiendas)
    {
        $comunes = null;
        foreach ($tiendas as $t) {
            $comunes = $comunes === null ? $t['Metodos'] : array_values(array_intersect($comunes, $t['Metodos']));
        }
        return $comunes ?? [];
    }

    public function ver()
    {
        $detalles = $this->detalles($this->idCarritoPendiente());
        $this->actualizarSubtotales($detalles);
        $tiendas = array_values($this->agruparPorTienda($detalles));
        return ['tiendas' => $tiendas, 'total' => array_sum(array_column($tiendas, 'Subtotal')), 'unidades' => array_sum(array_column($tiendas, 'Unidades')),
            'problema' => $detalles ? $this->validarDisponibilidad($detalles) : null];
    }

    public function agregar($idProducto, $cantidad, $talla, $color)
    {
        $consulta = $this->conexion->prepare("SELECT p.*, t.Estado AS Estado_Tienda FROM Productos p JOIN Tiendas t ON t.Id_Tienda = p.Id_Tienda WHERE p.Id_Producto = ?");
        $consulta->execute([$idProducto]);
        $producto = $consulta->fetch();
        if (!$producto || !$producto['Activo'] || $producto['Estado_Tienda'] !== 'Activa') {
            throw new Exception("El producto no existe o ya no está disponible.", 404);
        }
        if ($cantidad < 1 || $cantidad > self::MAX_CANTIDAD) {
            throw new Exception("La cantidad debe estar entre 1 y " . self::MAX_CANTIDAD . ".", 400);
        }

        if ($producto['Tiene_Variantes']) {
            $tallas = array_values(array_filter(array_map('trim', explode(',', (string)$producto['Tallas_Disponibles']))));
            if ($tallas && !in_array($talla, $tallas, true)) {
                throw new Exception("Debes elegir una talla antes de agregar este producto.", 400);
            }
            $consulta = $this->conexion->prepare("SELECT Nombre_Color FROM ColoresProducto WHERE Id_Producto = ?");
            $consulta->execute([$idProducto]);
            $colores = $consulta->fetchAll(PDO::FETCH_COLUMN);
            if ($colores && !in_array($color, $colores, true)) {
                throw new Exception("Debes elegir un color antes de agregar este producto.", 400);
            }
            $talla = $tallas ? $talla : null;
            $color = $colores ? $color : null;
        } else {
            $talla = null;
            $color = null;
        }

        $idCarrito = $this->idCarritoPendiente();
        // El tope de stock cuenta todas las variantes del mismo producto que ya estén en el carrito.
        $consulta = $this->conexion->prepare("SELECT COALESCE(SUM(Cantidad), 0) FROM DetallesCarrito WHERE Id_Carrito = ? AND Id_Producto = ?");
        $consulta->execute([$idCarrito, $idProducto]);
        $yaEnCarrito = (int)$consulta->fetchColumn();
        if ($yaEnCarrito + $cantidad > $producto['Stock']) {
            throw new Exception($producto['Stock'] <= 0
                ? "{$producto['Nombre_Producto']} está agotado."
                : "Solo quedan {$producto['Stock']} unidades de {$producto['Nombre_Producto']} y ya tienes $yaEnCarrito en tu carrito.", 409);
        }

        $precio = precioEfectivo($producto);
        $consulta = $this->conexion->prepare("SELECT Id_Detalle, Cantidad FROM DetallesCarrito WHERE Id_Carrito = ? AND Id_Producto = ?
            AND Talla_Seleccionada <=> ? AND Color_Seleccionado <=> ?");
        $consulta->execute([$idCarrito, $idProducto, $talla, $color]);
        $detalle = $consulta->fetch();
        if ($detalle) {
            $nueva = (int)$detalle['Cantidad'] + $cantidad;
            $this->conexion->prepare("UPDATE DetallesCarrito SET Cantidad = ?, Subtotal = ? WHERE Id_Detalle = ?")
                ->execute([$nueva, $precio * $nueva, $detalle['Id_Detalle']]);
        } else {
            $this->conexion->prepare("INSERT INTO DetallesCarrito (Id_Carrito, Id_Producto, Cantidad, Subtotal, Talla_Seleccionada, Color_Seleccionado) VALUES (?, ?, ?, ?, ?, ?)")
                ->execute([$idCarrito, $idProducto, $cantidad, $precio * $cantidad, $talla, $color]);
        }
        return "{$producto['Nombre_Producto']} agregado al carrito.";
    }

    public function actualizarCantidad($idDetalle, $cantidad)
    {
        $detalles = $this->detalles($this->idCarritoPendiente());
        $detalle = null;
        $otrasVariantes = 0;
        foreach ($detalles as $d) {
            if ((int)$d['Id_Detalle'] === $idDetalle) $detalle = $d;
        }
        if (!$detalle) throw new Exception("Ese producto no está en tu carrito.", 404);
        if ($cantidad <= 0) {
            $this->conexion->prepare("DELETE FROM DetallesCarrito WHERE Id_Detalle = ?")->execute([$idDetalle]);
            return "Producto quitado del carrito.";
        }
        foreach ($detalles as $d) {
            if ($d['Id_Producto'] === $detalle['Id_Producto'] && (int)$d['Id_Detalle'] !== $idDetalle) $otrasVariantes += (int)$d['Cantidad'];
        }
        $maximo = min(self::MAX_CANTIDAD, max((int)$detalle['Stock'] - $otrasVariantes, 1));
        $mensaje = "Cantidad actualizada.";
        if ($cantidad > $maximo) {
            $cantidad = $maximo;
            $mensaje = "Solo hay $maximo unidad(es) disponibles de {$detalle['Nombre_Producto']}.";
        }
        $this->conexion->prepare("UPDATE DetallesCarrito SET Cantidad = ?, Subtotal = ? WHERE Id_Detalle = ?")
            ->execute([$cantidad, precioEfectivo($detalle) * $cantidad, $idDetalle]);
        return $mensaje;
    }

    public function quitar($idDetalle)
    {
        $this->conexion->prepare("DELETE d FROM DetallesCarrito d JOIN CarritosUniversales c ON c.Id_Carrito = d.Id_Carrito
            WHERE d.Id_Detalle = ? AND c.Id_Usuario = ? AND c.Estado = 'Pendiente'")->execute([$idDetalle, $this->idUsuario]);
        return "Producto quitado del carrito.";
    }

    /* ---------- Pago ---------- */

    /* El cupón elegido para cada tienda se guarda en la sesión del cliente (no en el formulario): así no se puede manipular. */
    private function cuponSesion($idTienda)
    {
        return $_SESSION['cupones'][$idTienda] ?? null;
    }

    public function checkout()
    {
        $detalles = $this->detalles($this->idCarritoPendiente());
        if (!$detalles) throw new Exception("Tu carrito está vacío.", 400);
        $this->actualizarSubtotales($detalles);
        $problema = $this->validarDisponibilidad($detalles);
        if ($problema) throw new Exception($problema, 409);

        $tiendas = $this->agruparPorTienda($detalles);
        $validador = new cupon();
        foreach ($tiendas as $id => &$t) {
            $t['Descuento'] = 0;
            $t['Cupon'] = null;
            $t['ErrorCupon'] = null;
            $codigo = $this->cuponSesion($id);
            if ($codigo) {
                try {
                    [$c, $descuento] = $validador->validar($codigo, $id, $this->idUsuario, $t['Subtotal']);
                    $t['Cupon'] = $c['Codigo'];
                    $t['Descuento'] = $descuento;
                } catch (Exception $e) {
                    unset($_SESSION['cupones'][$id]);
                    $t['ErrorCupon'] = "Quitamos el cupón $codigo: " . $e->getMessage();
                }
            }
        }
        unset($t);

        $metodos = $this->metodosEnComun($tiendas);
        if (!$metodos) {
            throw new Exception("Las tiendas de tu carrito no comparten ningún método de pago en común. Separa la compra por tienda.", 409);
        }

        $consulta = $this->conexion->prepare("SELECT Nombre, Apellido, Telefono, Direccion_Envio FROM Usuarios WHERE Id_Usuario = ?");
        $consulta->execute([$this->idUsuario]);
        $usuario = $consulta->fetch();

        $subtotal = array_sum(array_column($tiendas, 'Subtotal'));
        $descuento = array_sum(array_column($tiendas, 'Descuento'));
        return ['tiendas' => array_values($tiendas), 'metodos' => $metodos, 'subtotal' => $subtotal, 'descuento' => $descuento,
            'total' => $subtotal - $descuento, 'usuario' => $usuario];
    }

    public function aplicarCupon($idTienda, $codigo)
    {
        $detalles = $this->detalles($this->idCarritoPendiente());
        $this->actualizarSubtotales($detalles);
        $subtotal = 0;
        foreach ($detalles as $d) {
            if ((int)$d['Id_Tienda'] === $idTienda) $subtotal += $d['Subtotal'];
        }
        if ($subtotal <= 0) throw new Exception("No tienes productos de esa tienda en el carrito.", 404);
        [$c, $descuento] = (new cupon())->validar($codigo, $idTienda, $this->idUsuario, $subtotal);
        $_SESSION['cupones'][$idTienda] = $c['Codigo'];
        return "Cupón {$c['Codigo']} aplicado: ahorras " . pesos($descuento) . ".";
    }

    public function quitarCupon($idTienda)
    {
        unset($_SESSION['cupones'][$idTienda]);
        return "Cupón quitado.";
    }

    /* Confirma el pedido completo en una sola transacción: o queda todo (factura, facturas por tienda, ventas,
       stock y cupones) o no queda nada. */
    public function confirmar($datos, $archivos)
    {
        $idCarrito = $this->idCarritoPendiente();
        $detalles = $this->detalles($idCarrito);
        if (!$detalles) throw new Exception("Tu carrito está vacío.", 400);

        // Lo que se cobra es el precio de hoy: si cambió algo desde que se vio el total, se avisa antes de confirmar.
        if ($this->actualizarSubtotales($detalles)) {
            throw new Exception("Los precios de tu carrito cambiaron. Revisa el nuevo total antes de confirmar.", 409);
        }
        $problema = $this->validarDisponibilidad($detalles);
        if ($problema) throw new Exception($problema, 409);

        $tiendas = $this->agruparPorTienda($detalles);
        $metodo = $datos['metodoPago'] ?? '';
        if (!in_array($metodo, $this->metodosEnComun($tiendas), true)) {
            throw new Exception("El método de pago elegido no está disponible para todas las tiendas de tu carrito.", 400);
        }
        $tipoEntrega = $datos['tipoEntrega'] ?? '';
        if (!in_array($tipoEntrega, [ENTREGA_RETIRO, ENTREGA_DOMICILIO_PROPIO, ENTREGA_DOMICILIO_OTRO], true)) {
            throw new Exception("Elige un tipo de entrega válido.", 400);
        }
        $direccion = texto($datos, 'direccion', 250);
        $destinatario = texto($datos, 'destinatario', 150);
        $telefono = texto($datos, 'telefono', 20);
        if ($tipoEntrega !== ENTREGA_RETIRO && $direccion === '') throw new Exception("Debes indicar una dirección de entrega.", 400);
        if ($tipoEntrega === ENTREGA_DOMICILIO_OTRO && ($destinatario === '' || $telefono === '')) {
            throw new Exception("Debes indicar el nombre y el teléfono de quien recibe el pedido.", 400);
        }

        $consulta = $this->conexion->prepare("SELECT Nombre, Apellido, Telefono FROM Usuarios WHERE Id_Usuario = ?");
        $consulta->execute([$this->idUsuario]);
        $cliente = $consulta->fetch();
        if ($tipoEntrega === ENTREGA_RETIRO) {
            $direccion = null; $destinatario = null; $telefono = null;
        } elseif ($tipoEntrega === ENTREGA_DOMICILIO_PROPIO) {
            $destinatario = "{$cliente['Nombre']} {$cliente['Apellido']}";
            $telefono = $cliente['Telefono'];
        }

        // Comprobantes QR: se validan y guardan antes de tocar la base; si algo falla se borran.
        $comprobantes = [];
        if ($metodo === 'QR') {
            foreach ($tiendas as $id => $t) {
                $archivo = $archivos["comprobante_$id"] ?? null;
                if (!$archivo || $archivo['error'] === UPLOAD_ERR_NO_FILE) {
                    foreach ($comprobantes as $r) eliminarArchivo($r);
                    throw new Exception("Debes subir el comprobante QR de cada tienda para continuar.", 400);
                }
                $comprobantes[$id] = guardarArchivo($archivo, 'comprobantes-qr', true, true);
            }
        }

        $pdo = $this->conexion;
        $ahora = ahora();
        try {
            $pdo->beginTransaction();

            // 1. Reclamar el carrito: si llegan dos envíos a la vez (doble clic), solo uno lo consigue.
            $reclamo = $pdo->prepare("UPDATE CarritosUniversales SET Estado = 'Pagado' WHERE Id_Carrito = ? AND Estado = 'Pendiente'");
            $reclamo->execute([$idCarrito]);
            if ($reclamo->rowCount() === 0) throw new Exception("Este pedido ya fue procesado.", 409);

            // 2. Descontar stock de forma atómica: la condición va dentro del UPDATE.
            $porProducto = [];
            foreach ($detalles as $d) {
                $porProducto[$d['Id_Producto']] = ['cantidad' => ($porProducto[$d['Id_Producto']]['cantidad'] ?? 0) + (int)$d['Cantidad'], 'nombre' => $d['Nombre_Producto']];
            }
            $stock = $pdo->prepare("UPDATE Productos SET Stock = Stock - ? WHERE Id_Producto = ? AND Stock >= ?");
            foreach ($porProducto as $idProducto => $p) {
                $stock->execute([$p['cantidad'], $idProducto, $p['cantidad']]);
                if ($stock->rowCount() === 0) throw new Exception("No hay stock suficiente de {$p['nombre']}.", 409);
            }

            // 3. Cupones: se bloquea la fila de cada cupón y se valida de nuevo con el carrito definitivo.
            $validador = new cupon();
            $cupones = [];
            foreach ($tiendas as $id => $t) {
                $codigo = $this->cuponSesion($id);
                if (!$codigo) continue;
                $pdo->prepare("SELECT Id_cupones FROM Cupones WHERE Id_Tienda = ? AND Codigo = ? FOR UPDATE")->execute([$id, cupon::normalizar($codigo)]);
                try {
                    $cupones[$id] = $validador->validar($codigo, $id, $this->idUsuario, $t['Subtotal']);
                } catch (Exception $e) {
                    unset($_SESSION['cupones'][$id]);
                    throw new Exception("No se pudo usar el cupón $codigo: " . $e->getMessage(), 409);
                }
            }
            $descuentoTotal = 0;
            foreach ($cupones as $c) $descuentoTotal += $c[1];
            $subtotalTotal = array_sum(array_column($tiendas, 'Subtotal'));

            // 4. Factura universal, factura por tienda, venta por tienda y primera etapa del seguimiento.
            $pdo->prepare("INSERT INTO Facturas (Id_Carrito, Id_Usuario, Fecha, Total, Descuento, Metodo_Pago, Tipo_Entrega, Direccion_Entrega, Nombre_Destinatario, Telefono_Contacto)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
                ->execute([$idCarrito, $this->idUsuario, $ahora, $subtotalTotal - $descuentoTotal, $descuentoTotal, $metodo, $tipoEntrega, $direccion, $destinatario, $telefono]);
            $idFactura = (int)$pdo->lastInsertId();

            foreach ($tiendas as $id => $t) {
                [$cuponTienda, $descuentoTienda] = $cupones[$id] ?? [null, 0];
                $pdo->prepare("INSERT INTO FacturasPorTienda (Id_FacturaUniversal, Id_Tienda, Subtotal, Descuento, Id_Cupon, Metodo_Pago, Comprobante_QR) VALUES (?, ?, ?, ?, ?, ?, ?)")
                    ->execute([$idFactura, $id, $t['Subtotal'], $descuentoTienda, $cuponTienda['Id_cupones'] ?? null, $metodo, $comprobantes[$id] ?? null]);
                $idFacturaTienda = (int)$pdo->lastInsertId();

                if ($cuponTienda) {
                    $pdo->prepare("INSERT INTO CuponesUso (Id_Cupon, Id_Usuario, Id_FacturaTienda, Descuento_Aplicado, Fecha) VALUES (?, ?, ?, ?, ?)")
                        ->execute([$cuponTienda['Id_cupones'], $this->idUsuario, $idFacturaTienda, $descuentoTienda, $ahora]);
                }

                // El contraentrega queda Pendiente hasta que el propio cliente confirme que recibió y pagó el pedido.
                $pdo->prepare("INSERT INTO HistorialVentas (Id_Tienda, Id_Usuario, Fecha, Total, Estado, Id_FacturaTienda, Estado_Envio, Fecha_Estado_Envio) VALUES (?, ?, ?, ?, ?, ?, 'Recibido', ?)")
                    ->execute([$id, $this->idUsuario, $ahora, $t['Subtotal'] - $descuentoTienda, $metodo === 'Contraentrega' ? VENTA_PENDIENTE : VENTA_EN_PROCESO, $idFacturaTienda, $ahora]);
                $pdo->prepare("INSERT INTO HistorialEstadosEnvio (Id_Venta, Estado, Fecha) VALUES (?, 'Recibido', ?)")->execute([$pdo->lastInsertId(), $ahora]);
            }
            $pdo->commit();
        } catch (Throwable $e) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            foreach ($comprobantes as $r) eliminarArchivo($r);
            if ($e instanceof PDOException && $e->getCode() == 23000) {
                throw new Exception("No se pudo aplicar uno de los cupones (ya fue usado). Revisa tu pedido e inténtalo de nuevo.", 409);
            }
            throw $e;
        }

        unset($_SESSION['cupones']);
        $this->avisarCompra($idFactura, $tiendas, $cupones, $cliente, $metodo, $tipoEntrega, $direccion, $subtotalTotal - $descuentoTotal, $descuentoTotal);
        return $idFactura;
    }

    /* Aviso en la bandeja: al cliente con el resumen de su compra y a cada vendedor con su nueva venta. */
    private function avisarCompra($idFactura, $tiendas, $cupones, $cliente, $metodo, $tipoEntrega, $direccion, $total, $descuento)
    {
        try {
            $entrega = $tipoEntrega === ENTREGA_RETIRO ? "Retiro en tienda" : "Domicilio a $direccion";
            $lista = [];
            foreach ($tiendas as $id => $t) {
                $lista[] = $t['Nombre_Tienda'] . " (" . pesos($t['Subtotal'] - ($cupones[$id][1] ?? 0)) . ")";
            }
            $ahorro = $descuento > 0 ? " Ahorraste " . pesos($descuento) . " con cupones." : "";
            $origen = idAdministrador() ?? reset($tiendas)['Id_Vendedor'];
            notificar($origen, $this->idUsuario, "Pedido #$idFactura confirmado",
                "Tu compra por " . pesos($total) . " fue confirmada. Tiendas: " . implode('; ', $lista) . ". Entrega: $entrega. Método de pago: $metodo.$ahorro");
            foreach ($tiendas as $id => $t) {
                notificar($this->idUsuario, $t['Id_Vendedor'], "Nueva venta en {$t['Nombre_Tienda']}",
                    "{$cliente['Nombre']} {$cliente['Apellido']} compró {$t['Unidades']} unidad(es) por " . pesos($t['Subtotal'] - ($cupones[$id][1] ?? 0)) .
                    " ($metodo). Entrega: $entrega. Revisa el pedido en Ventas y ve actualizando su seguimiento.");
            }
        } catch (Throwable $e) {
            // Si el aviso falla, el pedido ya quedó confirmado: no se afecta.
        }
    }
}
