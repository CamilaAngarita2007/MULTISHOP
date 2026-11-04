/* =====================================================================
   MULTISHOP - Estructura de la base de datos para MySQL 8.x (solo esquema, sin datos)
   Convertido desde el script de SQL Server (migraciones EF Core hasta ModeloF3).
   Equivalencias: IDENTITY -> AUTO_INCREMENT, nvarchar -> VARCHAR, nvarchar(max) -> LONGTEXT,
                  bit -> TINYINT(1), datetime2 -> DATETIME(6).
   ===================================================================== */
CREATE DATABASE IF NOT EXISTS `MULTISHOP` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `MULTISHOP`;

SET FOREIGN_KEY_CHECKS = 0;

/* ---------------------------- TABLAS ---------------------------- */

CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` VARCHAR(150) NOT NULL,
  `ProductVersion` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB;

CREATE TABLE `Anuncios` (
  `Id_Anuncio` INT NOT NULL AUTO_INCREMENT,
  `Imagen` VARCHAR(300) NOT NULL,
  `Titulo` VARCHAR(150) NOT NULL,
  `Id_Tienda` INT NULL,
  `Orden` INT NOT NULL,
  `Activo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Id_Anuncio`)
) ENGINE=InnoDB;

CREATE TABLE `Avisos` (
  `Id_Aviso` INT NOT NULL AUTO_INCREMENT,
  `Id_Tienda` INT NOT NULL,
  `Tipo` VARCHAR(20) NOT NULL,
  `Contenido` LONGTEXT NOT NULL,
  `Fecha_Publicacion` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Aviso`)
) ENGINE=InnoDB;

CREATE TABLE `Calificaciones` (
  `Id_Calificacion` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Tienda` INT NOT NULL,
  `Puntuacion` INT NOT NULL,
  `Comentario` VARCHAR(500) NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Calificacion`)
) ENGINE=InnoDB;

CREATE TABLE `CalificacionesProducto` (
  `Id_CalifProd` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Producto` INT NOT NULL,
  `Puntuacion` INT NOT NULL,
  `Comentario` VARCHAR(500) NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_CalifProd`)
) ENGINE=InnoDB;

CREATE TABLE `CarritosUniversales` (
  `Id_Carrito` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Estado` LONGTEXT NOT NULL,
  `Fecha_Creacion` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Carrito`)
) ENGINE=InnoDB;

CREATE TABLE `Categorias` (
  `Id_Categoria` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Categoria` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id_Categoria`)
) ENGINE=InnoDB;

CREATE TABLE `Chats` (
  `Id_Chat` INT NOT NULL AUTO_INCREMENT,
  `Id_UsuarioOrigen` INT NOT NULL,
  `Id_UsuarioDestino` INT NOT NULL,
  `Mensaje` VARCHAR(1000) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  `Estado` VARCHAR(30) NOT NULL,
  `Id_Cupon` INT NULL,
  `Leido` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id_Chat`)
) ENGINE=InnoDB;

CREATE TABLE `ColoresProducto` (
  `Id_ColorProducto` INT NOT NULL AUTO_INCREMENT,
  `Id_Producto` INT NOT NULL,
  `Nombre_Color` VARCHAR(50) NOT NULL,
  `Imagen` VARCHAR(300) NULL,
  `Color_Hex` VARCHAR(7) NULL,
  PRIMARY KEY (`Id_ColorProducto`)
) ENGINE=InnoDB;

CREATE TABLE `Cupones` (
  `Id_cupones` INT NOT NULL AUTO_INCREMENT,
  `Codigo` VARCHAR(50) NOT NULL,
  `Tipo_Descuento` VARCHAR(20) NOT NULL,
  `Valor` DECIMAL(18,2) NOT NULL,
  `Fecha_Inicio` DATETIME(6) NOT NULL,
  `Fecha_Fin` DATETIME(6) NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Compra_Minima` DECIMAL(18,2) NULL,
  `Fecha_Creacion` DATETIME(6) NOT NULL DEFAULT '1000-01-01 00:00:00',
  `Id_Tienda` INT NOT NULL DEFAULT 0,
  `Usos_Maximos` INT NULL,
  PRIMARY KEY (`Id_cupones`)
) ENGINE=InnoDB;

CREATE TABLE `CuponesUso` (
  `Id_CuponUso` INT NOT NULL AUTO_INCREMENT,
  `Id_Cupon` INT NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Id_FacturaTienda` INT NOT NULL,
  `Descuento_Aplicado` DECIMAL(18,2) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_CuponUso`)
) ENGINE=InnoDB;

CREATE TABLE `DetallesCarrito` (
  `Id_Detalle` INT NOT NULL AUTO_INCREMENT,
  `Id_Carrito` INT NOT NULL,
  `Id_Producto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Subtotal` DECIMAL(18,2) NOT NULL,
  `Color_Seleccionado` VARCHAR(50) NULL,
  `Talla_Seleccionada` VARCHAR(50) NULL,
  PRIMARY KEY (`Id_Detalle`)
) ENGINE=InnoDB;

CREATE TABLE `DispositivosConfiables` (
  `Id_Dispositivo` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `TokenHash` VARCHAR(128) NOT NULL,
  `Fecha_Creacion` DATETIME(6) NOT NULL,
  `Fecha_Expira` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Dispositivo`)
) ENGINE=InnoDB;

CREATE TABLE `Facturas` (
  `Id_Factura` INT NOT NULL AUTO_INCREMENT,
  `Id_Carrito` INT NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  `Total` DECIMAL(18,2) NOT NULL,
  `Metodo_Pago` VARCHAR(20) NOT NULL,
  `Direccion_Entrega` VARCHAR(250) NULL,
  `Nombre_Destinatario` VARCHAR(150) NULL,
  `Telefono_Contacto` VARCHAR(20) NULL,
  `Tipo_Entrega` VARCHAR(20) NOT NULL DEFAULT '',
  `Descuento` DECIMAL(18,2) NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`Id_Factura`)
) ENGINE=InnoDB;

CREATE TABLE `FacturasPorTienda` (
  `Id_FacturaTienda` INT NOT NULL AUTO_INCREMENT,
  `Id_FacturaUniversal` INT NOT NULL,
  `Id_Tienda` INT NOT NULL,
  `Subtotal` DECIMAL(18,2) NOT NULL,
  `Metodo_Pago` VARCHAR(20) NOT NULL,
  `Comprobante_QR` VARCHAR(300) NULL,
  `Descuento` DECIMAL(18,2) NOT NULL DEFAULT 0.0,
  `Id_Cupon` INT NULL,
  PRIMARY KEY (`Id_FacturaTienda`)
) ENGINE=InnoDB;

CREATE TABLE `Favoritos` (
  `Id_Favorito` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Producto` INT NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Favorito`)
) ENGINE=InnoDB;

CREATE TABLE `HistorialEstadosEnvio` (
  `Id_CambioEnvio` INT NOT NULL AUTO_INCREMENT,
  `Id_Venta` INT NOT NULL,
  `Estado` VARCHAR(30) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_CambioEnvio`)
) ENGINE=InnoDB;

CREATE TABLE `HistorialVentas` (
  `Id_Venta` INT NOT NULL AUTO_INCREMENT,
  `Id_Tienda` INT NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  `Total` DECIMAL(18,2) NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Id_FacturaTienda` INT NULL,
  `Estado_Envio` VARCHAR(30) NOT NULL DEFAULT 'Recibido',
  `Fecha_Estado_Envio` DATETIME(6) NULL,
  PRIMARY KEY (`Id_Venta`)
) ENGINE=InnoDB;

CREATE TABLE `LogsAdmin` (
  `Id_Log` INT NOT NULL AUTO_INCREMENT,
  `Id_admin` INT NOT NULL,
  `Accion` VARCHAR(200) NOT NULL,
  `Entidad_Afectada` VARCHAR(200) NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_Log`)
) ENGINE=InnoDB;

CREATE TABLE `MembresiasVendedor` (
  `Id_Membresia` INT NOT NULL AUTO_INCREMENT,
  `Id_Tienda` INT NOT NULL,
  `Fecha_Inicio_Membresia` DATETIME(6) NOT NULL,
  `Fecha_Fin_Membresia` DATETIME(6) NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Valor_Pagado` DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (`Id_Membresia`)
) ENGINE=InnoDB;

CREATE TABLE `Mensajes` (
  `Id_Mensaje` INT NOT NULL AUTO_INCREMENT,
  `Id_UsuarioOrigen` INT NOT NULL,
  `Id_UsuarioDestino` INT NOT NULL,
  `Canal` VARCHAR(20) NOT NULL,
  `Contenido` VARCHAR(1000) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  `Estado_Entrega` VARCHAR(20) NOT NULL,
  `Leido` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Id_Mensaje`)
) ENGINE=InnoDB;

CREATE TABLE `PeticionesCreacionTienda` (
  `Id_Peticion` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Nombre_Tienda_Solicitada` VARCHAR(150) NOT NULL,
  `Id_Categoria` INT NOT NULL,
  `DocumentosAdjuntos` LONGTEXT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  `Rol_Asignado` VARCHAR(20) NULL,
  PRIMARY KEY (`Id_Peticion`)
) ENGINE=InnoDB;

CREATE TABLE `Pqrs` (
  `Id_PQRS` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Tienda` INT NULL,
  `Tipo` VARCHAR(20) NOT NULL,
  `Descripcion` VARCHAR(1000) NOT NULL,
  `Respuesta` VARCHAR(1000) NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Fecha` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id_PQRS`)
) ENGINE=InnoDB;

CREATE TABLE `ProductoImagenes` (
  `Id_ProductoImagen` INT NOT NULL AUTO_INCREMENT,
  `Id_Producto` INT NOT NULL,
  `Imagen` VARCHAR(300) NOT NULL,
  `Orden` INT NOT NULL,
  PRIMARY KEY (`Id_ProductoImagen`)
) ENGINE=InnoDB;

CREATE TABLE `Productos` (
  `Id_Producto` INT NOT NULL AUTO_INCREMENT,
  `Id_Tienda` INT NOT NULL,
  `Nombre_Producto` VARCHAR(150) NOT NULL,
  `Descripcion` VARCHAR(1000) NULL,
  `Precio` DECIMAL(18,2) NOT NULL,
  `Stock` INT NOT NULL,
  `Imagen` VARCHAR(300) NULL,
  `Rebaja_Temporal` TINYINT(1) NOT NULL,
  `Fecha_Inicio_Rebaja` DATETIME(6) NULL,
  `Fecha_Fin_Rebaja` DATETIME(6) NULL,
  `Variante` VARCHAR(100) NULL,
  `Precio_Rebajado` DECIMAL(18,2) NULL,
  `Tallas_Disponibles` VARCHAR(300) NULL,
  `Tiene_Variantes` TINYINT(1) NOT NULL DEFAULT 0,
  `Activo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id_Producto`)
) ENGINE=InnoDB;

CREATE TABLE `Tiendas` (
  `Id_Tienda` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Nombre_Tienda` VARCHAR(150) NOT NULL,
  `Id_Categoria` INT NOT NULL,
  `Logo` VARCHAR(300) NULL,
  `Paleta_Colores` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(250) NULL,
  `Horario` VARCHAR(150) NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Documentos_Adjuntos` LONGTEXT NULL,
  `Metodos_Pago_Habilitados` LONGTEXT NULL,
  `Imagen_QR` VARCHAR(300) NULL,
  `Fondo_Navbar` VARCHAR(300) NULL,
  PRIMARY KEY (`Id_Tienda`)
) ENGINE=InnoDB;

CREATE TABLE `TokensRecuperacion` (
  `Id_Token` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `TokenHash` VARCHAR(64) NOT NULL,
  `Fecha_Creacion` DATETIME(6) NOT NULL,
  `Fecha_Expira` DATETIME(6) NOT NULL,
  `Usado` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Id_Token`)
) ENGINE=InnoDB;

CREATE TABLE `Usuarios` (
  `Id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Correo` VARCHAR(150) NOT NULL,
  `Telefono` VARCHAR(20) NULL,
  `Direccion_Envio` VARCHAR(250) NULL,
  `Contraseña` LONGTEXT NOT NULL,
  `Rol` VARCHAR(20) NOT NULL,
  `Estado_Cuenta` VARCHAR(20) NOT NULL,
  `Fecha_Registro` DATETIME(6) NOT NULL,
  `Foto_Perfil` VARCHAR(300) NULL,
  `Tipo_Login` VARCHAR(20) NOT NULL,
  `Codigo_Verificacion` VARCHAR(10) NULL,
  `Codigo_Expira` DATETIME(6) NULL,
  `Ultimo_Login` DATETIME(6) NULL,
  `Contador_Infracciones` INT NOT NULL DEFAULT 0,
  `Fecha_Bloqueo_Fin` DATETIME(6) NULL,
  `Motivo_Bloqueo` VARCHAR(500) NULL,
  `Correo_Verificado` TINYINT(1) NOT NULL DEFAULT 1,
  `Intentos_Codigo` INT NOT NULL DEFAULT 0,
  `Login_Bloqueado_Hasta` DATETIME(6) NULL,
  `Login_Fallidos` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Usuario`)
) ENGINE=InnoDB;

/* ---------------------------- INDICES ---------------------------- */

CREATE INDEX `IX_Anuncios_Activo_Orden` ON `Anuncios` (`Activo`, `Orden`);
CREATE INDEX `IX_Anuncios_Id_Tienda` ON `Anuncios` (`Id_Tienda`);
CREATE INDEX `IX_Avisos_Id_Tienda` ON `Avisos` (`Id_Tienda`);
CREATE INDEX `IX_Calificaciones_Id_Tienda` ON `Calificaciones` (`Id_Tienda`);
CREATE INDEX `IX_Calificaciones_Id_Usuario` ON `Calificaciones` (`Id_Usuario`);
CREATE INDEX `IX_CalificacionesProducto_Id_Producto` ON `CalificacionesProducto` (`Id_Producto`);
CREATE UNIQUE INDEX `IX_CalificacionesProducto_Id_Usuario_Id_Producto` ON `CalificacionesProducto` (`Id_Usuario`, `Id_Producto`);
CREATE INDEX `IX_CarritosUniversales_Id_Usuario` ON `CarritosUniversales` (`Id_Usuario`);
CREATE INDEX `IX_Chats_Id_Cupon` ON `Chats` (`Id_Cupon`);
CREATE INDEX `IX_Chats_Id_UsuarioDestino_Leido` ON `Chats` (`Id_UsuarioDestino`, `Leido`);
CREATE INDEX `IX_Chats_Id_UsuarioOrigen_Id_UsuarioDestino_Fecha` ON `Chats` (`Id_UsuarioOrigen`, `Id_UsuarioDestino`, `Fecha`);
CREATE INDEX `IX_ColoresProducto_Id_Producto` ON `ColoresProducto` (`Id_Producto`);
CREATE UNIQUE INDEX `IX_Cupones_Id_Tienda_Codigo` ON `Cupones` (`Id_Tienda`, `Codigo`);
CREATE UNIQUE INDEX `IX_CuponesUso_Id_Cupon_Id_Usuario` ON `CuponesUso` (`Id_Cupon`, `Id_Usuario`);
CREATE INDEX `IX_CuponesUso_Id_FacturaTienda` ON `CuponesUso` (`Id_FacturaTienda`);
CREATE INDEX `IX_CuponesUso_Id_Usuario` ON `CuponesUso` (`Id_Usuario`);
CREATE INDEX `IX_DetallesCarrito_Id_Carrito` ON `DetallesCarrito` (`Id_Carrito`);
CREATE INDEX `IX_DetallesCarrito_Id_Producto` ON `DetallesCarrito` (`Id_Producto`);
CREATE INDEX `IX_DispositivosConfiables_Id_Usuario` ON `DispositivosConfiables` (`Id_Usuario`);
CREATE INDEX `IX_Facturas_Id_Carrito` ON `Facturas` (`Id_Carrito`);
CREATE INDEX `IX_Facturas_Id_Usuario` ON `Facturas` (`Id_Usuario`);
CREATE INDEX `IX_FacturasPorTienda_Id_Cupon` ON `FacturasPorTienda` (`Id_Cupon`);
CREATE INDEX `IX_FacturasPorTienda_Id_FacturaUniversal` ON `FacturasPorTienda` (`Id_FacturaUniversal`);
CREATE INDEX `IX_FacturasPorTienda_Id_Tienda` ON `FacturasPorTienda` (`Id_Tienda`);
CREATE INDEX `IX_Favoritos_Id_Producto` ON `Favoritos` (`Id_Producto`);
CREATE UNIQUE INDEX `IX_Favoritos_Id_Usuario_Id_Producto` ON `Favoritos` (`Id_Usuario`, `Id_Producto`);
CREATE INDEX `IX_HistorialEstadosEnvio_Id_Venta_Fecha` ON `HistorialEstadosEnvio` (`Id_Venta`, `Fecha`);
CREATE INDEX `IX_HistorialVentas_Id_FacturaTienda` ON `HistorialVentas` (`Id_FacturaTienda`);
CREATE INDEX `IX_HistorialVentas_Id_Tienda_Fecha` ON `HistorialVentas` (`Id_Tienda`, `Fecha`);
CREATE INDEX `IX_HistorialVentas_Id_Usuario` ON `HistorialVentas` (`Id_Usuario`);
CREATE INDEX `IX_LogsAdmin_Id_admin` ON `LogsAdmin` (`Id_admin`);
CREATE INDEX `IX_MembresiasVendedor_Id_Tienda` ON `MembresiasVendedor` (`Id_Tienda`);
CREATE INDEX `IX_Mensajes_Id_UsuarioDestino_Leido` ON `Mensajes` (`Id_UsuarioDestino`, `Leido`);
CREATE INDEX `IX_Mensajes_Id_UsuarioOrigen` ON `Mensajes` (`Id_UsuarioOrigen`);
CREATE INDEX `IX_PeticionesCreacionTienda_Id_Categoria` ON `PeticionesCreacionTienda` (`Id_Categoria`);
CREATE INDEX `IX_PeticionesCreacionTienda_Id_Usuario` ON `PeticionesCreacionTienda` (`Id_Usuario`);
CREATE INDEX `IX_Pqrs_Id_Tienda_Estado` ON `Pqrs` (`Id_Tienda`, `Estado`);
CREATE INDEX `IX_Pqrs_Id_Usuario` ON `Pqrs` (`Id_Usuario`);
CREATE INDEX `IX_ProductoImagenes_Id_Producto` ON `ProductoImagenes` (`Id_Producto`);
CREATE INDEX `IX_Productos_Id_Tienda_Activo` ON `Productos` (`Id_Tienda`, `Activo`);
CREATE INDEX `IX_Tiendas_Id_Categoria_Estado` ON `Tiendas` (`Id_Categoria`, `Estado`);
CREATE INDEX `IX_Tiendas_Id_Usuario` ON `Tiendas` (`Id_Usuario`);
CREATE INDEX `IX_TokensRecuperacion_Id_Usuario` ON `TokensRecuperacion` (`Id_Usuario`);
CREATE UNIQUE INDEX `IX_TokensRecuperacion_TokenHash` ON `TokensRecuperacion` (`TokenHash`);
CREATE UNIQUE INDEX `IX_Usuarios_Correo` ON `Usuarios` (`Correo`);

/* ------------------------ CLAVES FORANEAS ------------------------ */
/* Sin ON DELETE indicado = NO ACTION (en MySQL equivale a RESTRICT). */

ALTER TABLE `Anuncios` ADD CONSTRAINT `FK_Anuncios_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`) ON DELETE SET NULL;
ALTER TABLE `Avisos` ADD CONSTRAINT `FK_Avisos_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`) ON DELETE CASCADE;
ALTER TABLE `Calificaciones` ADD CONSTRAINT `FK_Calificaciones_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`);
ALTER TABLE `Calificaciones` ADD CONSTRAINT `FK_Calificaciones_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `CalificacionesProducto` ADD CONSTRAINT `FK_CalificacionesProducto_Productos_Id_Producto` FOREIGN KEY (`Id_Producto`) REFERENCES `Productos` (`Id_Producto`) ON DELETE CASCADE;
ALTER TABLE `CalificacionesProducto` ADD CONSTRAINT `FK_CalificacionesProducto_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `CarritosUniversales` ADD CONSTRAINT `FK_CarritosUniversales_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `Chats` ADD CONSTRAINT `FK_Chats_Cupones_Id_Cupon` FOREIGN KEY (`Id_Cupon`) REFERENCES `Cupones` (`Id_cupones`) ON DELETE SET NULL;
ALTER TABLE `Chats` ADD CONSTRAINT `FK_Chats_Usuarios_Id_UsuarioDestino` FOREIGN KEY (`Id_UsuarioDestino`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `Chats` ADD CONSTRAINT `FK_Chats_Usuarios_Id_UsuarioOrigen` FOREIGN KEY (`Id_UsuarioOrigen`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `ColoresProducto` ADD CONSTRAINT `FK_ColoresProducto_Productos_Id_Producto` FOREIGN KEY (`Id_Producto`) REFERENCES `Productos` (`Id_Producto`) ON DELETE CASCADE;
ALTER TABLE `Cupones` ADD CONSTRAINT `FK_Cupones_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`);
ALTER TABLE `CuponesUso` ADD CONSTRAINT `FK_CuponesUso_Cupones_Id_Cupon` FOREIGN KEY (`Id_Cupon`) REFERENCES `Cupones` (`Id_cupones`) ON DELETE CASCADE;
ALTER TABLE `CuponesUso` ADD CONSTRAINT `FK_CuponesUso_FacturasPorTienda_Id_FacturaTienda` FOREIGN KEY (`Id_FacturaTienda`) REFERENCES `FacturasPorTienda` (`Id_FacturaTienda`);
ALTER TABLE `CuponesUso` ADD CONSTRAINT `FK_CuponesUso_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `DetallesCarrito` ADD CONSTRAINT `FK_DetallesCarrito_CarritosUniversales_Id_Carrito` FOREIGN KEY (`Id_Carrito`) REFERENCES `CarritosUniversales` (`Id_Carrito`) ON DELETE CASCADE;
ALTER TABLE `DetallesCarrito` ADD CONSTRAINT `FK_DetallesCarrito_Productos_Id_Producto` FOREIGN KEY (`Id_Producto`) REFERENCES `Productos` (`Id_Producto`);
ALTER TABLE `DispositivosConfiables` ADD CONSTRAINT `FK_DispositivosConfiables_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`) ON DELETE CASCADE;
ALTER TABLE `Facturas` ADD CONSTRAINT `FK_Facturas_CarritosUniversales_Id_Carrito` FOREIGN KEY (`Id_Carrito`) REFERENCES `CarritosUniversales` (`Id_Carrito`);
ALTER TABLE `Facturas` ADD CONSTRAINT `FK_Facturas_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `FacturasPorTienda` ADD CONSTRAINT `FK_FacturasPorTienda_Cupones_Id_Cupon` FOREIGN KEY (`Id_Cupon`) REFERENCES `Cupones` (`Id_cupones`);
ALTER TABLE `FacturasPorTienda` ADD CONSTRAINT `FK_FacturasPorTienda_Facturas_Id_FacturaUniversal` FOREIGN KEY (`Id_FacturaUniversal`) REFERENCES `Facturas` (`Id_Factura`) ON DELETE CASCADE;
ALTER TABLE `FacturasPorTienda` ADD CONSTRAINT `FK_FacturasPorTienda_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`);
ALTER TABLE `Favoritos` ADD CONSTRAINT `FK_Favoritos_Productos_Id_Producto` FOREIGN KEY (`Id_Producto`) REFERENCES `Productos` (`Id_Producto`) ON DELETE CASCADE;
ALTER TABLE `Favoritos` ADD CONSTRAINT `FK_Favoritos_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `HistorialEstadosEnvio` ADD CONSTRAINT `FK_HistorialEstadosEnvio_HistorialVentas_Id_Venta` FOREIGN KEY (`Id_Venta`) REFERENCES `HistorialVentas` (`Id_Venta`) ON DELETE CASCADE;
ALTER TABLE `HistorialVentas` ADD CONSTRAINT `FK_HistorialVentas_FacturasPorTienda_Id_FacturaTienda` FOREIGN KEY (`Id_FacturaTienda`) REFERENCES `FacturasPorTienda` (`Id_FacturaTienda`);
ALTER TABLE `HistorialVentas` ADD CONSTRAINT `FK_HistorialVentas_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`);
ALTER TABLE `HistorialVentas` ADD CONSTRAINT `FK_HistorialVentas_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `LogsAdmin` ADD CONSTRAINT `FK_LogsAdmin_Usuarios_Id_admin` FOREIGN KEY (`Id_admin`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `MembresiasVendedor` ADD CONSTRAINT `FK_MembresiasVendedor_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`) ON DELETE CASCADE;
ALTER TABLE `Mensajes` ADD CONSTRAINT `FK_Mensajes_Usuarios_Id_UsuarioDestino` FOREIGN KEY (`Id_UsuarioDestino`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `Mensajes` ADD CONSTRAINT `FK_Mensajes_Usuarios_Id_UsuarioOrigen` FOREIGN KEY (`Id_UsuarioOrigen`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `PeticionesCreacionTienda` ADD CONSTRAINT `FK_PeticionesCreacionTienda_Categorias_Id_Categoria` FOREIGN KEY (`Id_Categoria`) REFERENCES `Categorias` (`Id_Categoria`);
ALTER TABLE `PeticionesCreacionTienda` ADD CONSTRAINT `FK_PeticionesCreacionTienda_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `Pqrs` ADD CONSTRAINT `FK_Pqrs_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`);
ALTER TABLE `Pqrs` ADD CONSTRAINT `FK_Pqrs_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `ProductoImagenes` ADD CONSTRAINT `FK_ProductoImagenes_Productos_Id_Producto` FOREIGN KEY (`Id_Producto`) REFERENCES `Productos` (`Id_Producto`) ON DELETE CASCADE;
ALTER TABLE `Productos` ADD CONSTRAINT `FK_Productos_Tiendas_Id_Tienda` FOREIGN KEY (`Id_Tienda`) REFERENCES `Tiendas` (`Id_Tienda`) ON DELETE CASCADE;
ALTER TABLE `Tiendas` ADD CONSTRAINT `FK_Tiendas_Categorias_Id_Categoria` FOREIGN KEY (`Id_Categoria`) REFERENCES `Categorias` (`Id_Categoria`);
ALTER TABLE `Tiendas` ADD CONSTRAINT `FK_Tiendas_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`);
ALTER TABLE `TokensRecuperacion` ADD CONSTRAINT `FK_TokensRecuperacion_Usuarios_Id_Usuario` FOREIGN KEY (`Id_Usuario`) REFERENCES `Usuarios` (`Id_Usuario`) ON DELETE CASCADE;

SET FOREIGN_KEY_CHECKS = 1;
