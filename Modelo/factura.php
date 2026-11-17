<?php
require_once __DIR__ . '/utilidades.php';

/* Pedidos del cliente: historial, detalle con la línea de tiempo de cada tienda y confirmación de recepción. */
class factura
{
    private $conexion;
    private $idUsuario;

    public function __construct($idUsuario)
    {
        $this->conexion = conexionBD();
        $this->idUsuario = (int)$idUsuario;
    }

    public function historial()
    {
        $consulta = $this->conexion->prepare("SELECT f.Id_Factura, f.Fecha, f.Total, f.Descuento, f.Metodo_Pago, f.Tipo_Entrega,
                GROUP_CONCAT(t.Nombre_Tienda ORDER BY t.Nombre_Tienda SEPARATOR ', ') AS Tiendas,
                GROUP_CONCAT(COALESCE(t.Logo, '') ORDER BY t.Nombre_Tienda SEPARATOR '|') AS Logos,
                SUM(v.Estado = 'Finalizado') AS Finalizadas, SUM(v.Estado = 'Cancelada') AS Canceladas, COUNT(v.Id_Venta) AS Ventas
            FROM Facturas f
            JOIN FacturasPorTienda ft ON ft.Id_FacturaUniversal = f.Id_Factura
            JOIN Tiendas t ON t.Id_Tienda = ft.Id_Tienda
            LEFT JOIN HistorialVentas v ON v.Id_FacturaTienda = ft.Id_FacturaTienda
            WHERE f.Id_Usuario = ? GROUP BY f.Id_Factura ORDER BY f.Fecha DESC");
        $consulta->execute([$this->idUsuario]);
        $facturas = $consulta->fetchAll();
        foreach ($facturas as &$f) {
            $ventas = (int)$f['Ventas'];
            $f['EstadoGeneral'] = $ventas === 0 ? "Por confirmar"
                : ((int)$f['Finalizadas'] === $ventas ? "Finalizado" : ((int)$f['Canceladas'] === $ventas ? "Cancelada" : "Por confirmar"));
        }
        return $facturas;
    }

    public function detalle($idFactura)
    {
        $consulta = $this->conexion->prepare("SELECT f.*, u.Nombre, u.Apellido, u.Correo FROM Facturas f JOIN Usuarios u ON u.Id_Usuario = f.Id_Usuario
            WHERE f.Id_Factura = ? AND f.Id_Usuario = ?");
        $consulta->execute([$idFactura, $this->idUsuario]);
        $factura = $consulta->fetch();
        if (!$factura) throw new Exception("La factura no existe.", 404);

        $consulta = $this->conexion->prepare("SELECT ft.Id_FacturaTienda, ft.Id_Tienda, ft.Subtotal, ft.Descuento, ft.Metodo_Pago, ft.Comprobante_QR,
                t.Nombre_Tienda, t.Logo, t.Direccion, t.Paleta_Colores, t.Id_Usuario AS Id_Vendedor, c.Codigo AS Codigo_Cupon,
                v.Id_Venta, v.Estado, v.Estado_Envio, v.Total AS Total_Venta
            FROM FacturasPorTienda ft JOIN Tiendas t ON t.Id_Tienda = ft.Id_Tienda
            LEFT JOIN Cupones c ON c.Id_cupones = ft.Id_Cupon
            LEFT JOIN HistorialVentas v ON v.Id_FacturaTienda = ft.Id_FacturaTienda
            WHERE ft.Id_FacturaUniversal = ? ORDER BY t.Nombre_Tienda");
        $consulta->execute([$idFactura]);
        $tiendas = $consulta->fetchAll();

        $productos = $this->conexion->prepare("SELECT d.Cantidad, d.Subtotal, d.Talla_Seleccionada, d.Color_Seleccionado, p.Id_Producto, p.Nombre_Producto, p.Imagen
            FROM DetallesCarrito d JOIN Productos p ON p.Id_Producto = d.Id_Producto WHERE d.Id_Carrito = ? AND p.Id_Tienda = ?");
        $linea = $this->conexion->prepare("SELECT Estado, Fecha FROM HistorialEstadosEnvio WHERE Id_Venta = ? ORDER BY Fecha, Id_CambioEnvio");
        foreach ($tiendas as &$t) {
            $productos->execute([$factura['Id_Carrito'], $t['Id_Tienda']]);
            $t['productos'] = $productos->fetchAll();
            $t['lineaTiempo'] = [];
            if ($t['Id_Venta']) {
                $linea->execute([$t['Id_Venta']]);
                $t['lineaTiempo'] = $linea->fetchAll();
            }
            $t['flujo'] = flujoEnvio($factura['Tipo_Entrega']);
            // Contraentrega: confirma cuando recibió y pagó. QR (ya pagado): cuando la tienda lo marcó como entregado.
            $t['puedeConfirmar'] = $t['Estado'] === VENTA_PENDIENTE || ($t['Estado'] === VENTA_EN_PROCESO && $t['Estado_Envio'] === 'Entregado');
        }
        $factura['tiendas'] = $tiendas;
        return $factura;
    }

    public function confirmarRecepcion($idFacturaTienda)
    {
        $consulta = $this->conexion->prepare("SELECT v.*, f.Id_Factura FROM HistorialVentas v
            JOIN FacturasPorTienda ft ON ft.Id_FacturaTienda = v.Id_FacturaTienda JOIN Facturas f ON f.Id_Factura = ft.Id_FacturaUniversal
            WHERE v.Id_FacturaTienda = ? AND f.Id_Usuario = ?");
        $consulta->execute([$idFacturaTienda, $this->idUsuario]);
        $venta = $consulta->fetch();
        if (!$venta) throw new Exception("El pedido no existe.", 404);
        $puede = $venta['Estado'] === VENTA_PENDIENTE || ($venta['Estado'] === VENTA_EN_PROCESO && $venta['Estado_Envio'] === 'Entregado');
        if (!$puede) throw new Exception("Este pedido no se puede confirmar todavía.", 409);

        $ahora = ahora();
        $this->conexion->prepare("UPDATE HistorialVentas SET Estado = 'Finalizado', Estado_Envio = 'Entregado', Fecha_Estado_Envio = ? WHERE Id_Venta = ?")
            ->execute([$ahora, $venta['Id_Venta']]);
        if ($venta['Estado_Envio'] !== 'Entregado') {
            $this->conexion->prepare("INSERT INTO HistorialEstadosEnvio (Id_Venta, Estado, Fecha) VALUES (?, 'Entregado', ?)")->execute([$venta['Id_Venta'], $ahora]);
        }
        return (int)$venta['Id_Factura'];
    }
}
