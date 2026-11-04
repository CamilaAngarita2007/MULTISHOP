/* MULTISHOP - Datos para MySQL (generado desde SQL Server). Ejecutar DESPUES de Base de datos MySQL.sql */
USE `MULTISHOP`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = CONCAT(@@SQL_MODE, ',NO_AUTO_VALUE_ON_ZERO');

/* Categorias : 8 filas */
INSERT INTO `Categorias` (`Id_Categoria`, `Nombre_Categoria`) VALUES
(1, 'Supermercados'),
(2, 'Moda y calzado'),
(3, 'Deportes y aire libre'),
(4, 'Electrónica y tecnología'),
(5, 'Hogar y decoración'),
(6, 'Farmacias'),
(7, 'Belleza'),
(8, 'Restaurantes y gastronomía');

/* Usuarios : 28 filas */
INSERT INTO `Usuarios` (`Id_Usuario`, `Nombre`, `Apellido`, `Correo`, `Telefono`, `Direccion_Envio`, `Contraseña`, `Rol`, `Estado_Cuenta`, `Fecha_Registro`, `Foto_Perfil`, `Tipo_Login`, `Codigo_Verificacion`, `Codigo_Expira`, `Ultimo_Login`, `Contador_Infracciones`, `Fecha_Bloqueo_Fin`, `Motivo_Bloqueo`, `Correo_Verificado`, `Intentos_Codigo`, `Login_Bloqueado_Hasta`, `Login_Fallidos`) VALUES
(2, 'Camila', 'Angarita', 'camilayricardo2014@gmail.com', '3112607209', 'Calle 13 #3-21, Duitama', 'AQAAAAIAAYagAAAAEBWcjTd3AGo/WU1Xb1s8wrZWErCNPCUWZTLxNLgaRVp6MHv9CObGjnxfZFWrcNrRpQ==', 'Admin', 'Activo', '2026-01-01 00:00:00.000000', '/uploads/perfiles/f9309f76-db48-480f-9661-5fbda7342213.jpg', 'Tradicional', NULL, NULL, '2026-10-16 07:25:49.897237', 6, NULL, NULL, 1, 0, NULL, 0),
(6, 'Magdy', 'Chisino', 'camilo.lara.chi@gmail.com', '3227122063', 'cra 11 #9-92', 'AQAAAAIAAYagAAAAEBM5qJF/2x7fxJplNHsYbk8tV3HIC1J6e6AgnchXr/cSLa2sWwUegqcDUx3kkbjZDQ==', 'Vendedor', 'Activo', '2026-09-11 12:12:07.483873', NULL, 'Tradicional', NULL, NULL, '2026-10-16 07:30:40.632934', 0, NULL, NULL, 1, 0, NULL, 0),
(7, 'Brayan', 'Lara', 'brayancamilo7233@gmail.com', '3227122063', 'cra 11 #9-92', 'AQAAAAIAAYagAAAAENMcYYApByxOW/+3a5d4Ux0LLuf7ASEbeeEHLYTHUIvu+RMcRZ15/Xrgtv1g21giRA==', 'Cliente', 'Activo', '2026-09-11 12:23:09.036662', '/uploads/perfiles/6b45ccf6-bf77-4251-a3fa-9164a24198c8.jpeg', 'Tradicional', NULL, NULL, '2026-10-16 07:31:21.124961', 4, NULL, NULL, 1, 0, NULL, 0),
(9, 'Miguel', 'Acero', 'juanm.acero2020@gmail.com', '3132545472', 'Carrera 13 #3-21', 'AQAAAAIAAYagAAAAELFC9hu7pEaU1W3bti2+u4g8U82W0LreXQI9Z4+/2toPqxKegfYhnfxELQrSE+YVUA==', 'Vendedor', 'Activo', '2026-09-14 09:51:57.799566', NULL, 'Tradicional', NULL, NULL, '2026-09-16 12:32:56.888635', 0, NULL, NULL, 1, 0, NULL, 0),
(10, 'Alejandro', 'Torres', 'alejo.oliveros80@gmail.com', '3123053081', 'dg 9 #12-36', 'AQAAAAIAAYagAAAAEIow0YZn26OE04l6xffun6QHoj8z87mho6WoVdYVBgrn7gUOX7iWFrcqKptx/eFhmQ==', 'Vendedor', 'Activo', '2026-09-14 09:55:23.248869', '/uploads/perfiles/04ad73cf-f1c8-4298-87e9-bcaaa3b9b51c.jpeg', 'Tradicional', '948091', '2026-09-16 07:19:10.603296', '2026-09-16 06:39:32.604130', 0, NULL, NULL, 1, 0, NULL, 0),
(11, 'Laura', 'Yanquen', 'laurayanquen19@gmail.com', '3122116080', 'calle 8va #11b-20', 'AQAAAAIAAYagAAAAEHhEv8e7CPnU9F0xeB2cAPNmaYhSj5/K12VerlkvAkOKgsQWOLet0wPPoLwyXVHZ7w==', 'Vendedor', 'Activo', '2026-09-15 10:20:49.175364', '/uploads/perfiles/2e21d0b2-a5b1-4bd9-8460-0955066bb54f.jpeg', 'Tradicional', NULL, NULL, '2026-09-15 10:23:48.227034', 0, NULL, NULL, 1, 0, NULL, 0),
(12, 'Rosa', 'Martínez', 'rosa.martinez@demo.multishop.local', '3011234501', 'Calle 45 #12-30, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.090000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(13, 'Jorge', 'Ramírez', 'jorge.ramirez@demo.multishop.local', '3011234502', 'Carrera 8 #20-15, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.093333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(14, 'Diana', 'Cárdenas', 'diana.cardenas@demo.multishop.local', '3011234503', 'Calle 10 #5-22, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.093333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(15, 'Camilo', 'Rojas', 'camilo.rojas@demo.multishop.local', '3011234504', 'Carrera 15 #30-10, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.096666', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(16, 'Lorena', 'Suárez', 'lorena.suarez@demo.multishop.local', '3011234505', 'Calle 22 #9-40, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.096666', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(17, 'Paula', 'Gómez', 'paula.gomez@demo.multishop.local', '3011234506', 'Carrera 19 #14-05, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.100000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(18, 'Andrés', 'Pineda', 'andres.pineda@demo.multishop.local', '3011234507', 'Calle 30 #18-12, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.100000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(19, 'Mauricio', 'Bernal', 'mauricio.bernal@demo.multishop.local', '3011234508', 'Carrera 22 #35-08, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.100000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(20, 'Felipe', 'Castañeda', 'felipe.castaneda@demo.multishop.local', '3011234509', 'Calle 18 #11-45, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.103333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(21, 'Sebastián', 'Molano', 'sebastian.molano@demo.multishop.local', '3011234510', 'Carrera 12 #25-60, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.103333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(22, 'Marcela', 'Torres', 'marcela.torres@demo.multishop.local', '3011234511', 'Calle 25 #16-33, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.103333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(23, 'Patricia', 'Vargas', 'patricia.vargas@demo.multishop.local', '3011234512', 'Carrera 9 #28-17, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.106666', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(24, 'Alejandra', 'Moreno', 'alejandra.moreno@demo.multishop.local', '3011234513', 'Calle 33 #7-19, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.110000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(25, 'Hernán', 'Peña', 'hernan.pena@demo.multishop.local', '3011234514', 'Carrera 14 #22-08, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.110000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(26, 'Sandra', 'Ibáñez', 'sandra.ibanez@demo.multishop.local', '3011234515', 'Calle 40 #10-27, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.110000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(27, 'Valentina', 'Rincón', 'valentina.rincon@demo.multishop.local', '3011234516', 'Carrera 17 #19-44, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.113333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(28, 'Natalia', 'Cuervo', 'natalia.cuervo@demo.multishop.local', '3011234517', 'Calle 12 #24-51, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.116666', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(29, 'Ricardo', 'Salamanca', 'ricardo.salamanca@demo.multishop.local', '3011234518', 'Carrera 20 #13-27, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.120000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(30, 'Gloria', 'Higuera', 'gloria.higuera@demo.multishop.local', '3011234519', 'Calle 27 #8-16, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.120000', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(31, 'Esteban', 'Duarte', 'esteban.duarte@demo.multishop.local', '3011234520', 'Carrera 6 #16-38, Duitama', 'AQAAAAIAAYagAAAAEK4A4yhLKSCFFJmRuDiVHMbzh4hf9fPCzi9GXFegi9iooEvxI7PoSNP9kIjM8BNpwQ==', 'Vendedor', 'Activo', '2026-09-16 06:06:11.123333', NULL, 'Tradicional', NULL, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0),
(32, 'Jose', 'Cipagauta', 'jose.cipagauta22@gmail.com', '3173045710', '123', 'AQAAAAIAAYagAAAAEItnhTdR5wySN9HDr2/ob3xnuRWWVdVudSdIlsabHn6tsJngKmrHK42l8wSyyqQARA==', 'Cliente', 'Activo', '2026-10-05 08:35:25.457144', NULL, 'Tradicional', NULL, NULL, '2026-10-05 08:44:15.527605', 1, NULL, NULL, 1, 0, NULL, 0),
(33, 'Camila Alejandra', 'Angarita Soto', 'darklink31413@gmail.com', '3112607209', 'Carrera 13 #3-21', 'AQAAAAIAAYagAAAAEBesRne6KoDHSSPKBktmsZIv0kz+lR9reZd3NLessel2mWphKybNhwg0LPrAiCMkYA==', 'Cliente', 'Activo', '2026-10-16 07:36:00.864578', NULL, 'Tradicional', NULL, NULL, '2026-10-16 07:36:21.468678', 0, NULL, NULL, 1, 0, NULL, 0);

/* Tiendas : 24 filas */
INSERT INTO `Tiendas` (`Id_Tienda`, `Id_Usuario`, `Nombre_Tienda`, `Id_Categoria`, `Logo`, `Paleta_Colores`, `Direccion`, `Horario`, `Estado`, `Documentos_Adjuntos`, `Metodos_Pago_Habilitados`, `Imagen_QR`, `Fondo_Navbar`) VALUES
(2, 6, 'Alimajo', 5, '/uploads/logos-tienda/f9dce4c1-f30b-4b6a-8f11-d38a8f548a5d.png', '#EA86EA', NULL, NULL, 'Activa', '{}', 'Contraentrega', NULL, '/img/fondos/tiendas/alimajo.jpg'),
(3, 11, 'Bella Luna', 7, '/uploads/logos-tienda/b1af6e83-74db-4dd5-935e-744a867edaa4.jpeg', '#6600CC', NULL, NULL, 'Activa', '{}', 'Contraentrega', NULL, '/img/fondos/tiendas/bella-luna.jpg'),
(4, 10, 'Datol Sport', 3, '/uploads/logos-tienda/9b6f6af5-4aaf-4bd8-8b53-4e413c254c2a.jpeg', '#CC0000', NULL, NULL, 'Activa', '{}', 'Contraentrega', NULL, '/img/fondos/tiendas/datol-sport.jpg'),
(5, 9, 'Full Tecnology', 4, '/uploads/logos-tienda/bea08a1e-5c53-4174-9f7b-9d09b4c6d699.jpeg', '#2FEEEE', NULL, NULL, 'Activa', '{}', 'Contraentrega', NULL, '/img/fondos/tiendas/full-tecnology.jpg'),
(6, 12, 'La Canasta Familiar', 1, '/img/generados/logos/tienda-6.svg', '#2E7D32', 'Calle 45 #12-30, Duitama', 'Lun-Dom 7:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(7, 13, 'Mercax Express', 1, '/img/generados/logos/tienda-7.svg', '#1565C0', 'Carrera 8 #20-15, Duitama', 'Lun-Sáb 7:00am - 8:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(8, 14, 'Frescompras', 1, '/img/generados/logos/tienda-8.svg', '#EF6C00', 'Calle 10 #5-22, Duitama', 'Lun-Dom 6:30am - 8:30pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(9, 15, 'Urban Style Ropa', 2, '/img/generados/logos/tienda-9.svg', '#212121', 'Carrera 15 #30-10, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(10, 16, 'Pasos & Estilo Calzado', 2, '/img/generados/logos/tienda-10.svg', '#AD1457', 'Calle 22 #9-40, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(11, 17, 'Moda Bonita', 2, '/img/generados/logos/tienda-11.svg', '#C2185B', 'Carrera 19 #14-05, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(12, 18, 'Aventura Outdoor', 3, '/img/generados/logos/tienda-12.svg', '#33691E', 'Calle 30 #18-12, Duitama', 'Lun-Sáb 8:00am - 6:30pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(13, 19, 'ProFit Deportes', 3, '/img/generados/logos/tienda-13.svg', '#0277BD', 'Carrera 22 #35-08, Duitama', 'Lun-Sáb 8:00am - 6:30pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(14, 20, 'TecnoExpress', 4, '/img/generados/logos/tienda-14.svg', '#37474F', 'Calle 18 #11-45, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(15, 21, 'GadgetZone', 4, '/img/generados/logos/tienda-15.svg', '#4527A0', 'Carrera 12 #25-60, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(16, 22, 'Casa Bonita Decoración', 5, '/img/generados/logos/tienda-16.svg', '#6D4C41', 'Calle 25 #16-33, Duitama', 'Lun-Sáb 9:00am - 6:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(17, 23, 'Rincón Hogareño', 5, '/img/generados/logos/tienda-17.svg', '#8D6E63', 'Carrera 9 #28-17, Duitama', 'Lun-Sáb 9:00am - 6:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(18, 24, 'Farmavida', 6, '/img/generados/logos/tienda-18.svg', '#00838F', 'Calle 33 #7-19, Duitama', 'Lun-Dom 7:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(19, 25, 'Droguería San Rafael', 6, '/img/generados/logos/tienda-19.svg', '#2E7D32', 'Carrera 14 #22-08, Duitama', 'Lun-Dom 7:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(20, 26, 'MediExpress', 6, '/img/generados/logos/tienda-20.svg', '#1565C0', 'Calle 40 #10-27, Duitama', 'Lun-Dom 7:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(21, 27, 'Glow Beauty', 7, '/img/generados/logos/tienda-21.svg', '#AD1457', 'Carrera 17 #19-44, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(22, 28, 'Encanto Cosméticos', 7, '/img/generados/logos/tienda-22.svg', '#6A1B9A', 'Calle 12 #24-51, Duitama', 'Lun-Sáb 9:00am - 7:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(23, 29, 'Sabores de la Casa', 8, '/img/generados/logos/tienda-23.svg', '#BF360C', 'Carrera 20 #13-27, Duitama', 'Lun-Dom 11:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(24, 30, 'El Fogón Criollo', 8, '/img/generados/logos/tienda-24.svg', '#D84315', 'Calle 27 #8-16, Duitama', 'Lun-Dom 11:00am - 9:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL),
(25, 31, 'Pizza Nostra', 8, '/img/generados/logos/tienda-25.svg', '#C62828', 'Carrera 6 #16-38, Duitama', 'Lun-Dom 12:00pm - 10:00pm', 'Activa', NULL, 'Contraentrega', NULL, NULL);

/* Productos : 116 filas */
INSERT INTO `Productos` (`Id_Producto`, `Id_Tienda`, `Nombre_Producto`, `Descripcion`, `Precio`, `Stock`, `Imagen`, `Rebaja_Temporal`, `Fecha_Inicio_Rebaja`, `Fecha_Fin_Rebaja`, `Variante`, `Precio_Rebajado`, `Tallas_Disponibles`, `Tiene_Variantes`, `Activo`) VALUES
(2, 2, 'Amigurumi Bodoque', 'bodoque de 20cm', 60000.00, 46, '/uploads/productos/6ee488fe-0ae2-4ad2-b9ae-56abeedf027f.jpg', 1, '2026-10-05 00:00:00.000000', '2026-10-15 00:00:00.000000', NULL, 40000.00, NULL, 0, 1),
(3, 3, 'kit de maquillaje trendy', ' hermoso kit de maquillaje super completo de la marca trendy', 180000.00, 20, '/uploads/productos/65b1140c-f71b-44e4-8eaa-d71bfdc0ff00.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(4, 3, 'Parches para acne', 'bonitos parches en forma de estrella para eliminar esos granitos incomods mientras sales a hacer cualquier rutina sin dejar marcha y demas', 10000.00, 39, '/uploads/productos/b5faebae-9ef7-4181-9f2a-70694a557f02.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(5, 3, 'kit skin care', 'suave y humectante skincare de rosas perfecto pars tener hermosa tu piel libre de granitos y manchas', 100000.00, 0, '/uploads/productos/7c02ee30-8eae-4932-a3cf-1ffccef56ce3.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(6, 2, 'Ramo amigurumi', 'Un ramo con dos flores y un lindo pollito', 90000.00, 15, '/uploads/productos/61640edc-2d0a-448d-9110-742536926f78.jpeg', 0, NULL, NULL, 'mediano', NULL, NULL, 0, 1),
(7, 2, 'Amigurumi Pato Lucas', 'Un amigurumi del pato lucas con los pantalones de tienda', 45000.00, 11, '/uploads/productos/fe07b4fd-6fe0-457a-9e76-49cfcffcbe29.jpg', 0, NULL, NULL, 'mediano', NULL, NULL, 0, 1),
(8, 2, 'Amigurumi Pesebre', 'Un pesebre con: la virgen, un burrito, los tres reyes magos, el bebé jesus dentro de la cuna, jose', 450000.00, 6, '/uploads/productos/eeb99c94-60c1-4e10-a0ae-32745cd3392a.jpeg', 0, NULL, NULL, 'pequeña', NULL, NULL, 0, 1),
(9, 4, 'Camiseta Henley ', 'Camiseta henley manga larga para hombre de color blanco o negro', 120000.00, 15, '/uploads/productos/30865990-ba7a-4da5-af39-1287d94edf58.jpeg', 0, NULL, NULL, 'blanco/negro', NULL, 'L,M', 1, 1),
(10, 4, 'Chaqueta deportiva ', 'Chaqueta deportiva del real Madrid color blanco, unisex', 150000.00, 19, '/uploads/productos/92c73584-87ce-4119-a71d-1c17de6e50cb.jpeg', 0, NULL, NULL, 'unisex', NULL, NULL, 0, 1),
(11, 4, 'Camiseta de compresión ', 'Camiseta de compresión para hacer deporte de color negro con patrón morado, manga corta, para hombre.', 135000.00, 39, '/uploads/productos/442dfab0-3b88-46bd-832c-678bf3622a8e.jpeg', 0, NULL, NULL, 'unica', NULL, NULL, 0, 1),
(12, 4, 'Camiseta de compresión ', 'Camiseta de compresión color negro con detalles rojos y logo de Batman, para hombre', 145000.00, 26, '/uploads/productos/04a225a0-dd6c-4938-9ed7-9840a5eb21c4.jpeg', 0, NULL, NULL, 'unica', NULL, NULL, 0, 1),
(13, 5, '2 Pantallas Para Portátil', '2 Pantallas Para Portátil Con Doble Monitor 1080p ', 500000.00, 42, '/uploads/productos/b2b7dac7-28ad-4ab0-a343-385642da8e67.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(14, 5, 'Oukitel G7 Android', 'Oukitel G7 Android 16.0 16gb+128gb Batería 10600mah Cámara 64mp+8mp Dual Sim Nfc Otg Gps Fm Rugerizado Teléfono Robusto Resistente', 600000.00, 36, '/uploads/productos/9f656087-5ef2-458c-8708-b398b90ab5d0.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(15, 5, 'CELULAR TECNO POVA ', 'CELULAR TECNO POVA CURVE 2 5G LK7 16GB RAM 256GB ROM 50MP', 1000000.00, 46, '/uploads/productos/c5f3cb6e-f4fa-445c-ac1b-1867ae675ec4.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(16, 5, 'Tablet Xiaomi', 'Tablet Xiaomi Redmi Pad 2 128gb 4gb RAM Pantalla 11" pulgadas, FHD+, 90 Hz', 600000.00, 15, '/uploads/productos/8ddd1487-7065-4032-ac18-af9db2ceefc7.jpeg', 0, NULL, NULL, 'gris', NULL, NULL, 0, 1),
(17, 3, 'Delineador líquido', 'Delineador de larga duración, punta fina, resistente al agua.', 24000.00, 35, '/img/productos/producto-17.jpeg', 0, NULL, NULL, 'Negro', NULL, NULL, 0, 1),
(18, 6, 'Arroz Diana x 500g', 'Arroz blanco de grano largo.', 3200.00, 120, '/img/productos/producto-18.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(19, 6, 'Aceite Girasol x 1L', 'Aceite vegetal comestible.', 12500.00, 60, '/img/productos/producto-19.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(20, 6, 'Leche entera x 1L', 'Leche líquida entera pasteurizada.', 4500.00, 90, '/img/generados/productos/producto-20.svg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(21, 6, 'Panela x 1kg', 'Panela redonda tradicional.', 5200.00, 75, '/img/productos/producto-21.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(22, 7, 'Huevos AA x 30', 'Huevos rojos AA en bandeja.', 15800.00, 40, '/img/productos/producto-22.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(23, 7, 'Papel higiénico x 12', 'Papel higiénico doble hoja.', 21000.00, 55, '/img/productos/producto-23.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(24, 7, 'Detergente en polvo x 3kg', 'Detergente para ropa.', 24500.00, 30, '/img/productos/producto-24.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(25, 7, 'Café molido x 500g', 'Café tostado y molido tradicional.', 13200.00, 65, '/img/productos/producto-25.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(26, 8, 'Banano x kg', 'Banano fresco seleccionado.', 2500.00, 100, '/img/generados/productos/producto-26.svg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(27, 8, 'Tomate chonto x kg', 'Tomate fresco de mesa.', 3800.00, 80, '/img/productos/producto-27.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(28, 8, 'Pechuga de pollo x kg', 'Pechuga de pollo fresca sin hueso.', 14500.00, 45, '/img/productos/producto-28.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(29, 8, 'Queso campesino x 500g', 'Queso fresco campesino.', 11000.00, 38, '/img/productos/producto-29.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(30, 9, 'Camiseta oversize', 'Camiseta 100% algodón, corte oversize.', 45000.00, 50, '/img/productos/producto-30.jpeg', 0, NULL, NULL, 'M', NULL, NULL, 0, 1),
(31, 9, 'Jean recto unisex', 'Jean de mezclilla corte recto.', 89000.00, 35, '/img/productos/producto-31.jpeg', 0, NULL, NULL, '32', NULL, NULL, 0, 1),
(32, 9, 'Chaqueta bomber', 'Chaqueta bomber liviana.', 120000.00, 20, '/img/productos/producto-32.jpeg', 0, NULL, NULL, 'L', NULL, NULL, 0, 1),
(33, 9, 'Gorra trucker', 'Gorra ajustable estilo trucker.', 32000.00, 60, '/img/productos/producto-33.jpeg', 0, NULL, NULL, 'Única', NULL, NULL, 0, 1),
(34, 10, 'Tenis deportivos urbanos', 'Tenis livianos para uso diario.', 135000.00, 40, '/img/productos/producto-34.jpeg', 0, NULL, NULL, '40', NULL, NULL, 0, 1),
(35, 10, 'Botas casuales', 'Botas de cuero sintético.', 149000.00, 25, '/img/productos/producto-35.jpeg', 0, NULL, NULL, '38', NULL, NULL, 0, 1),
(36, 10, 'Sandalias de verano', 'Sandalias cómodas para calor.', 58000.00, 45, '/img/productos/producto-36.jpeg', 0, NULL, NULL, '37', NULL, NULL, 0, 1),
(37, 10, 'Zapatos formales', 'Zapatos de cuero para oficina.', 165000.00, 22, '/img/productos/producto-37.jpeg', 0, NULL, NULL, '41', NULL, NULL, 0, 1),
(38, 11, 'Vestido casual', 'Vestido corto de tela fresca.', 78000.00, 30, '/img/productos/producto-38.jpeg', 0, NULL, NULL, 'S', NULL, NULL, 0, 1),
(39, 11, 'Blusa estampada', 'Blusa manga corta con estampado floral.', 52000.00, 40, '/img/productos/producto-39.jpeg', 0, NULL, NULL, 'M', NULL, NULL, 0, 1),
(40, 11, 'Falda plisada', 'Falda midi plisada.', 65000.00, 28, '/img/productos/producto-40.jpeg', 0, NULL, NULL, 'M', NULL, NULL, 0, 1),
(41, 11, 'Chaqueta de jean', 'Chaqueta de jean clásica.', 98000.00, 24, '/img/productos/producto-41.jpeg', 0, NULL, NULL, 'L', NULL, NULL, 0, 1),
(42, 12, 'Carpa camping 4 personas', 'Carpa impermeable para 4 personas.', 320000.00, 12, '/img/productos/producto-42.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(43, 12, 'Sleeping bag térmico', 'Bolsa de dormir resistente al frío.', 145000.00, 20, '/img/productos/producto-43.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(44, 12, 'Linterna recargable LED', 'Linterna de alta potencia recargable.', 48000.00, 35, '/img/productos/producto-44.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(45, 12, 'Morral 40L trekking', 'Morral resistente para senderismo.', 175000.00, 18, '/img/productos/producto-45.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(46, 13, 'Balón de fútbol', 'Balón profesional talla 5.', 68000.00, 30, '/img/productos/producto-46.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(47, 13, 'Guantes de gimnasio', 'Guantes acolchados para pesas.', 35000.00, 40, '/img/productos/producto-47.jpeg', 0, NULL, NULL, 'M', NULL, NULL, 0, 1),
(48, 13, 'Bicicleta todo terreno', 'Bicicleta rin 29 para montaña.', 890000.00, 8, '/img/productos/producto-48.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(49, 13, 'Botella deportiva 1L', 'Botella térmica para hidratación.', 28000.00, 55, '/img/productos/producto-49.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(50, 14, 'Audífonos inalámbricos', 'Audífonos bluetooth con estuche de carga.', 89000.00, 40, '/img/productos/producto-50.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(51, 14, 'Cargador rápido USB-C', 'Cargador de pared 25W.', 42000.00, 60, '/img/productos/producto-51.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(52, 14, 'Mouse inalámbrico', 'Mouse óptico inalámbrico.', 38000.00, 50, '/img/productos/producto-52.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(53, 14, 'Power bank 10000mAh', 'Batería portátil de carga rápida.', 65000.00, 35, '/img/productos/producto-53.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(54, 15, 'Smartwatch deportivo', 'Reloj inteligente con monitor de ritmo cardíaco.', 175000.00, 22, '/img/productos/producto-54.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(55, 15, 'Teclado mecánico', 'Teclado mecánico retroiluminado.', 145000.00, 18, '/img/productos/producto-55.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(56, 15, 'Cámara web HD', 'Cámara web 1080p con micrófono.', 68000.00, 30, '/img/productos/producto-56.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(57, 15, 'Parlante bluetooth portátil', 'Parlante resistente al agua.', 95000.00, 28, '/img/productos/producto-57.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(58, 16, 'Juego de sábanas doble', 'Sábanas suaves 100% algodón.', 85000.00, 25, '/img/productos/producto-58.jpeg', 0, NULL, NULL, 'Doble', NULL, NULL, 0, 1),
(59, 16, 'Set de velas aromáticas', 'Set de 3 velas aromáticas.', 42000.00, 40, '/img/productos/producto-59.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(60, 16, 'Cojín decorativo', 'Cojín para sala con funda desmontable.', 32000.00, 50, '/img/productos/producto-60.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(61, 16, 'Espejo decorativo redondo', 'Espejo de pared con marco dorado.', 110000.00, 15, '/img/productos/producto-61.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(62, 17, 'Set de ollas antiadherentes', 'Juego de 5 ollas antiadherentes.', 195000.00, 14, '/img/productos/producto-62.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(63, 17, 'Organizador de closet', 'Organizador plegable de tela.', 45000.00, 30, '/img/productos/producto-63.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(64, 17, 'Lámpara de mesa LED', 'Lámpara de escritorio regulable.', 58000.00, 22, '/img/productos/producto-64.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(65, 17, 'Tapete para sala', 'Tapete decorativo 120x180cm.', 89000.00, 18, '/img/productos/producto-65.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(66, 18, 'Acetaminofén 500mg x 20', 'Analgésico y antipirético.', 6500.00, 100, '/img/productos/producto-66.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(67, 18, 'Alcohol antiséptico 350ml', 'Alcohol para desinfección.', 7200.00, 80, '/img/productos/producto-67.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(68, 18, 'Vitamina C efervescente x 10', 'Suplemento de vitamina C.', 15800.00, 60, '/img/productos/producto-68.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(69, 18, 'Gel antibacterial 500ml', 'Gel antibacterial para manos.', 12000.00, 70, '/img/productos/producto-69.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(70, 19, 'Ibuprofeno 400mg x 10', 'Antiinflamatorio de uso general.', 5800.00, 90, '/img/productos/producto-70.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(71, 19, 'Suero oral x 1 sobre', 'Sales de hidratación oral.', 2500.00, 120, '/img/productos/producto-71.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(72, 19, 'Curitas surtidas x 40', 'Curitas adhesivas de varios tamaños.', 8900.00, 55, '/img/productos/producto-72.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(73, 19, 'Termómetro digital', 'Termómetro digital de uso clínico.', 22000.00, 30, '/img/productos/producto-73.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(74, 20, 'Multivitamínico x 30', 'Complemento vitamínico diario.', 32000.00, 45, '/img/productos/producto-74.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(75, 20, 'Tapabocas quirúrgico x 50', 'Caja de tapabocas desechables.', 18000.00, 60, '/img/productos/producto-75.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(76, 20, 'Crema hidratante corporal', 'Crema para piel seca 400ml.', 24500.00, 38, '/img/productos/producto-76.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(77, 20, 'Guantes de nitrilo x 100', 'Guantes desechables sin polvo.', 27000.00, 25, '/img/productos/producto-77.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(78, 21, 'Base líquida cobertura total', 'Base de maquillaje larga duración.', 48000.00, 35, '/img/productos/producto-78.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(79, 21, 'Paleta de sombras 12 tonos', 'Paleta de sombras mate y brillantes.', 62000.00, 28, '/img/productos/producto-79.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(80, 21, 'Rubor en polvo', 'Rubor de larga duración.', 29000.00, 40, '/img/productos/producto-80.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(81, 21, 'Set de brochas x 8', 'Set de brochas profesionales para maquillaje.', 55000.00, 22, '/img/productos/producto-81.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(82, 22, 'Perfume floral 100ml', 'Fragancia femenina de larga duración.', 95000.00, 20, '/img/productos/producto-82.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(83, 22, 'Crema facial antiedad', 'Crema hidratante con ácido hialurónico.', 68000.00, 25, '/img/productos/producto-83.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(84, 22, 'Esmalte de uñas set x 6', 'Set de esmaltes en tonos pastel.', 38000.00, 32, '/img/productos/producto-84.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(85, 22, 'Mascarilla facial de arcilla', 'Mascarilla purificante 150ml.', 26000.00, 30, '/img/productos/producto-85.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(86, 23, 'Bandeja paisa', 'Plato típico con carne, chicharrón, frijoles y más.', 28000.00, 30, '/img/productos/producto-86.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(87, 23, 'Ajiaco santafereño', 'Sopa tradicional con pollo, papas y mazorca.', 22000.00, 25, '/img/productos/producto-87.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(88, 23, 'Sancocho de gallina', 'Sancocho tradicional con gallina criolla.', 24000.00, 20, '/img/productos/producto-88.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(89, 23, 'Jugo natural en agua', 'Jugo de fruta natural al gusto.', 6500.00, 50, '/img/productos/producto-89.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(90, 24, 'Arepa con queso', 'Arepa asada rellena de queso.', 6000.00, 60, '/img/productos/producto-90.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(91, 24, 'Empanadas x 3', 'Empanadas de carne fritas.', 8500.00, 55, '/img/productos/producto-91.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(92, 24, 'Chicharrón con arepa', 'Chicharrón crocante con arepa.', 15000.00, 35, '/img/productos/producto-92.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(93, 24, 'Chocolate santafereño', 'Bebida caliente de chocolate con queso.', 7500.00, 40, '/img/productos/producto-93.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(94, 25, 'Pizza familiar hawaiana', 'Pizza grande de piña y jamón.', 45000.00, 20, '/img/productos/producto-94.jpeg', 0, NULL, NULL, 'Grande', NULL, NULL, 0, 1),
(95, 25, 'Pizza personal pepperoni', 'Pizza individual de pepperoni.', 18000.00, 35, '/img/productos/producto-95.jpeg', 0, NULL, NULL, 'Personal', NULL, NULL, 0, 1),
(96, 25, 'Pan de ajo x 6', 'Pan de ajo horneado con queso.', 12000.00, 40, '/img/productos/producto-96.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(97, 25, 'Gaseosa 1.5L', 'Bebida gaseosa sabor variado.', 7000.00, 60, '/img/productos/producto-97.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(98, 14, 'Celular gama media 128GB', 'Smartphone Android con cámara dual y batería de larga duración.', 650000.00, 15, '/img/productos/producto-98.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(99, 15, 'Celular económico 64GB', 'Smartphone básico ideal para uso diario.', 480000.00, 18, '/img/productos/producto-99.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(100, 7, 'Arroz Roa x 1kg', 'Arroz blanco premium de grano largo.', 4800.00, 90, '/img/productos/producto-100.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(101, 8, 'Arroz integral x 1kg', 'Arroz integral rico en fibra.', 5600.00, 60, '/img/productos/producto-101.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1);
INSERT INTO `Productos` (`Id_Producto`, `Id_Tienda`, `Nombre_Producto`, `Descripcion`, `Precio`, `Stock`, `Imagen`, `Rebaja_Temporal`, `Fecha_Inicio_Rebaja`, `Fecha_Fin_Rebaja`, `Variante`, `Precio_Rebajado`, `Tallas_Disponibles`, `Tiene_Variantes`, `Activo`) VALUES
(102, 7, 'Leche deslactosada x 1L', 'Leche líquida deslactosada.', 5200.00, 70, '/img/productos/producto-102.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(103, 8, 'Leche en polvo x 400g', 'Leche en polvo entera instantánea.', 18500.00, 40, '/img/productos/producto-103.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(104, 21, 'Crema hidratante facial', 'Crema facial para todo tipo de piel.', 42000.00, 30, '/img/productos/producto-104.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(105, 19, 'Crema para quemaduras leves', 'Crema calmante para quemaduras menores.', 15800.00, 25, '/img/productos/producto-105.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(106, 9, 'Zapatos tenis urbanos', 'Zapatos casuales estilo urbano.', 128000.00, 30, '/img/generados/productos/producto-106.svg', 0, NULL, NULL, '42', NULL, NULL, 0, 1),
(107, 11, 'Zapatos tacón mujer', 'Zapatos de tacón para ocasiones especiales.', 115000.00, 20, '/img/productos/producto-107.jpeg', 0, NULL, NULL, '37', NULL, NULL, 0, 1),
(108, 19, 'Vitamina D3 x 30 cápsulas', 'Suplemento de vitamina D3.', 28000.00, 35, '/img/productos/producto-108.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(109, 15, 'Audífonos con micrófono', 'Audífonos con cable y micrófono integrado.', 25000.00, 45, '/img/productos/producto-109.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(110, 5, 'Audífonos deportivos bluetooth', 'Audífonos resistentes al sudor para hacer ejercicio.', 78000.00, 22, '/img/generados/productos/producto-110.svg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(111, 3, 'Shampoo hidratante 400ml', 'Shampoo para cabello seco y dañado.', 32000.00, 40, '/img/productos/producto-111.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(112, 21, 'Shampoo anticaspa 400ml', 'Shampoo anticaspa de uso diario.', 29000.00, 35, '/img/productos/producto-112.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(113, 22, 'Shampoo y acondicionador dúo', 'Set de shampoo y acondicionador nutritivo.', 45000.00, 28, '/img/productos/producto-113.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(114, 11, 'Jean skinny mujer', 'Jean ajustado tiro alto.', 92000.00, 26, '/img/generados/productos/producto-114.svg', 0, NULL, NULL, '8', NULL, NULL, 0, 1),
(115, 4, 'Jean jogger deportivo', 'Jogger tipo jean, cómodo y resistente.', 105000.00, 20, '/img/generados/productos/producto-115.svg', 0, NULL, NULL, 'M', NULL, NULL, 0, 1),
(116, 20, 'Vitamina E cápsulas x 30', 'Suplemento antioxidante de vitamina E.', 26000.00, 30, '/img/productos/producto-116.jpeg', 0, NULL, NULL, NULL, NULL, NULL, 0, 1),
(117, 25, 'Pizza margarita personal', 'Pizza individual de tomate y queso mozzarella.', 17000.00, 30, '/img/productos/producto-117.jpeg', 0, NULL, NULL, 'Personal', NULL, NULL, 0, 1);

/* ProductoImagenes : 0 filas */

/* ColoresProducto : 2 filas */
INSERT INTO `ColoresProducto` (`Id_ColorProducto`, `Id_Producto`, `Nombre_Color`, `Imagen`, `Color_Hex`) VALUES
(1, 9, 'Blanco', '/uploads/productos-color/1134af02-5436-4233-9308-8ba73b17dbfd.jpeg', NULL),
(2, 9, 'Negro', '/uploads/productos-color/4132e5b6-4bd4-4a2a-8586-b1fb93bc73a8.jpeg', NULL);

/* Cupones : 1 filas */
INSERT INTO `Cupones` (`Id_cupones`, `Codigo`, `Tipo_Descuento`, `Valor`, `Fecha_Inicio`, `Fecha_Fin`, `Estado`, `Compra_Minima`, `Fecha_Creacion`, `Id_Tienda`, `Usos_Maximos`) VALUES
(2, 'USUARIO', 'Porcentaje', 10.00, '2026-10-16 00:00:00.000000', '2026-10-23 00:00:00.000000', 'Activo', 10000.00, '2026-10-16 07:28:16.274790', 2, 1);

/* CarritosUniversales : 11 filas */
INSERT INTO `CarritosUniversales` (`Id_Carrito`, `Id_Usuario`, `Estado`, `Fecha_Creacion`) VALUES
(2, 7, 'Pagado', '2026-09-11 12:28:38.178512'),
(4, 7, 'Pagado', '2026-09-14 06:17:19.386882'),
(5, 7, 'Pagado', '2026-09-14 08:26:15.387658'),
(6, 9, 'Pendiente', '2026-09-14 09:52:52.510781'),
(7, 7, 'Pagado', '2026-09-14 11:19:20.797018'),
(8, 7, 'Pagado', '2026-09-15 07:31:30.930223'),
(9, 7, 'Pagado', '2026-09-15 07:56:25.981693'),
(10, 7, 'Pagado', '2026-09-15 09:51:38.053425'),
(11, 7, 'Pendiente', '2026-09-24 10:00:41.197741'),
(12, 32, 'Pendiente', '2026-10-05 08:36:15.750026'),
(13, 33, 'Pendiente', '2026-10-16 07:36:34.543931');

/* DetallesCarrito : 12 filas */
INSERT INTO `DetallesCarrito` (`Id_Detalle`, `Id_Carrito`, `Id_Producto`, `Cantidad`, `Subtotal`, `Color_Seleccionado`, `Talla_Seleccionada`) VALUES
(2, 2, 2, 1, 60000.00, NULL, NULL),
(4, 4, 2, 1, 60000.00, NULL, NULL),
(5, 5, 2, 1, 60000.00, NULL, NULL),
(7, 7, 2, 1, 60000.00, NULL, NULL),
(8, 8, 2, 1, 60000.00, NULL, NULL),
(9, 9, 2, 1, 60000.00, NULL, NULL),
(10, 10, 7, 1, 45000.00, NULL, NULL),
(11, 10, 11, 1, 135000.00, NULL, NULL),
(12, 10, 4, 1, 10000.00, NULL, NULL),
(13, 11, 2, 1, 60000.00, NULL, NULL),
(14, 11, 3, 1, 180000.00, NULL, NULL),
(15, 13, 8, 1, 450000.00, NULL, NULL);

/* Facturas : 7 filas */
INSERT INTO `Facturas` (`Id_Factura`, `Id_Carrito`, `Id_Usuario`, `Fecha`, `Total`, `Metodo_Pago`, `Direccion_Entrega`, `Nombre_Destinatario`, `Telefono_Contacto`, `Tipo_Entrega`, `Descuento`) VALUES
(2, 2, 7, '2026-09-11 12:29:19.440775', 60000.00, 'Contraentrega', NULL, NULL, NULL, '', 0.00),
(3, 4, 7, '2026-09-14 06:19:43.943310', 60000.00, 'Contraentrega', NULL, NULL, NULL, '', 0.00),
(4, 5, 7, '2026-09-14 11:18:35.956926', 60000.00, 'Contraentrega', NULL, NULL, NULL, '', 0.00),
(5, 7, 7, '2026-09-15 07:12:50.356153', 60000.00, 'Contraentrega', NULL, NULL, NULL, '', 0.00),
(6, 8, 7, '2026-09-15 07:36:18.065278', 60000.00, 'Contraentrega', 'cra 11 #9-92', 'Brayan Lara', '3227122063', 'DomicilioPropio', 0.00),
(7, 9, 7, '2026-09-15 07:57:41.462402', 60000.00, 'Contraentrega', 'cra 11 #9-92', 'Brayan Lara', '3227122063', 'DomicilioPropio', 0.00),
(8, 10, 7, '2026-09-15 10:49:28.098112', 190000.00, 'Contraentrega', NULL, NULL, NULL, 'RetiroTienda', 0.00);

/* FacturasPorTienda : 9 filas */
INSERT INTO `FacturasPorTienda` (`Id_FacturaTienda`, `Id_FacturaUniversal`, `Id_Tienda`, `Subtotal`, `Metodo_Pago`, `Comprobante_QR`, `Descuento`, `Id_Cupon`) VALUES
(2, 2, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(3, 3, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(4, 4, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(5, 5, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(6, 6, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(7, 7, 2, 60000.00, 'Contraentrega', NULL, 0.00, NULL),
(8, 8, 2, 45000.00, 'Contraentrega', NULL, 0.00, NULL),
(9, 8, 4, 135000.00, 'Contraentrega', NULL, 0.00, NULL),
(10, 8, 3, 10000.00, 'Contraentrega', NULL, 0.00, NULL);

/* CuponesUso : 0 filas */

/* HistorialVentas : 9 filas */
INSERT INTO `HistorialVentas` (`Id_Venta`, `Id_Tienda`, `Id_Usuario`, `Fecha`, `Total`, `Estado`, `Id_FacturaTienda`, `Estado_Envio`, `Fecha_Estado_Envio`) VALUES
(2, 2, 7, '2026-09-11 12:29:19.542969', 60000.00, 'Cancelada', NULL, 'Recibido', NULL),
(3, 2, 7, '2026-09-14 06:19:44.013556', 60000.00, 'Finalizado', 3, 'Entregado', '2026-09-14 06:19:44.013556'),
(4, 2, 7, '2026-09-14 11:18:36.025714', 60000.00, 'Finalizado', 4, 'Entregado', '2026-09-14 11:18:36.025714'),
(5, 2, 7, '2026-09-15 07:12:50.435293', 60000.00, 'Finalizado', 5, 'Entregado', '2026-09-15 07:12:50.435293'),
(6, 2, 7, '2026-09-15 07:36:18.226639', 60000.00, 'Finalizado', 6, 'Entregado', '2026-09-15 07:36:18.226639'),
(7, 2, 7, '2026-09-15 07:57:41.513063', 60000.00, 'Finalizado', 7, 'Entregado', '2026-09-15 07:57:41.513063'),
(8, 2, 7, '2026-09-15 10:49:28.163950', 45000.00, 'Finalizado', 8, 'Entregado', '2026-09-15 10:49:28.163950'),
(9, 4, 7, '2026-09-15 10:49:28.196333', 135000.00, 'Finalizado', 9, 'Entregado', '2026-09-15 10:49:28.196333'),
(10, 3, 7, '2026-09-15 10:49:28.196663', 10000.00, 'Finalizado', 10, 'Entregado', '2026-09-15 10:49:28.196663');

/* HistorialEstadosEnvio : 17 filas */
INSERT INTO `HistorialEstadosEnvio` (`Id_CambioEnvio`, `Id_Venta`, `Estado`, `Fecha`) VALUES
(1, 2, 'Recibido', '2026-09-11 12:29:19.542969'),
(2, 3, 'Recibido', '2026-09-14 06:19:44.013556'),
(3, 4, 'Recibido', '2026-09-14 11:18:36.025714'),
(4, 5, 'Recibido', '2026-09-15 07:12:50.435293'),
(5, 6, 'Recibido', '2026-09-15 07:36:18.226639'),
(6, 7, 'Recibido', '2026-09-15 07:57:41.513063'),
(7, 8, 'Recibido', '2026-09-15 10:49:28.163950'),
(8, 10, 'Recibido', '2026-09-15 10:49:28.196663'),
(9, 9, 'Recibido', '2026-09-15 10:49:28.196333'),
(10, 3, 'Entregado', '2026-09-14 06:19:44.013556'),
(11, 4, 'Entregado', '2026-09-14 11:18:36.025714'),
(12, 5, 'Entregado', '2026-09-15 07:12:50.435293'),
(13, 6, 'Entregado', '2026-09-15 07:36:18.226639'),
(14, 7, 'Entregado', '2026-09-15 07:57:41.513063'),
(15, 8, 'Entregado', '2026-09-15 10:49:28.163950'),
(16, 9, 'Entregado', '2026-09-15 10:49:28.196333'),
(17, 10, 'Entregado', '2026-09-15 10:49:28.196663');

/* Anuncios : 4 filas */
INSERT INTO `Anuncios` (`Id_Anuncio`, `Imagen`, `Titulo`, `Id_Tienda`, `Orden`, `Activo`) VALUES
(1, 'alimajo.jpg', 'Alimajo Crochet', 2, 1, 1),
(2, 'bella-luna.jpg', 'Bella Luna Cosméticos', 3, 2, 1),
(3, 'datol-sport.jpg', 'Datol Sport', 4, 3, 1),
(4, 'full-tecnology.jpg', 'Full Tecnology', 5, 4, 1);

/* Avisos : 1 filas */
INSERT INTO `Avisos` (`Id_Aviso`, `Id_Tienda`, `Tipo`, `Contenido`, `Fecha_Publicacion`) VALUES
(3, 2, 'Texto', 'Descuento fin de semana', '2026-10-05 08:38:54.918971');

/* Calificaciones : 1 filas */
INSERT INTO `Calificaciones` (`Id_Calificacion`, `Id_Usuario`, `Id_Tienda`, `Puntuacion`, `Comentario`, `Fecha`) VALUES
(1, 7, 2, 5, 'muy lindo', '2026-09-14 06:06:52.829404');

/* CalificacionesProducto : 0 filas */

/* Chats : 13 filas */
INSERT INTO `Chats` (`Id_Chat`, `Id_UsuarioOrigen`, `Id_UsuarioDestino`, `Mensaje`, `Fecha`, `Estado`, `Id_Cupon`, `Leido`) VALUES
(1, 7, 6, 'Buenas tardes', '2026-09-11 12:23:59.618335', 'Activo', NULL, 1),
(2, 7, 6, 'perra', '2026-09-11 12:24:22.429943', 'Activo', NULL, 1),
(3, 6, 7, '>:c', '2026-09-11 12:31:35.303682', 'Activo', NULL, 1),
(4, 7, 6, 'hola', '2026-09-14 06:06:22.516071', 'Activo', NULL, 1),
(5, 7, 6, 'mlp', '2026-09-14 06:06:30.336635', 'Activo', NULL, 1),
(6, 7, 6, 'pirobo', '2026-09-14 06:25:34.326160', 'Activo', NULL, 1),
(7, 2, 6, 'Me contaron por ahí que brayan te habló mal. ¿Es verdad?', '2026-09-14 09:49:13.770521', 'Activo', NULL, 1),
(8, 6, 2, 'shi', '2026-09-14 09:50:34.780085', 'Activo', NULL, 1),
(9, 2, 7, 'viste los perros de la esquina', '2026-09-14 10:43:29.277578', 'Activo', NULL, 1),
(10, 2, 7, 'negro', '2026-09-14 10:43:39.172676', 'Activo', NULL, 1),
(11, 2, 7, 'camaco', '2026-09-14 10:43:44.588460', 'Activo', NULL, 1),
(12, 2, 6, 'p3rr4', '2026-10-10 15:09:05.952439', 'Activo', NULL, 1),
(13, 6, 7, 'Te comparto el cupón USUARIO: 10% de descuento en Alimajo, válido hasta el 23/10/2026. Escríbelo al pagar.', '2026-10-16 07:28:36.288806', 'Activo', 2, 1);

/* DispositivosConfiables : 30 filas */
INSERT INTO `DispositivosConfiables` (`Id_Dispositivo`, `Id_Usuario`, `TokenHash`, `Fecha_Creacion`, `Fecha_Expira`) VALUES
(2, 7, '4CDDA929457B2CB1FDF322A301F33118EF0DE1C08D3FB546CD6641716C821AE1', '2026-09-14 06:05:47.213393', '2026-12-13 06:05:47.209882'),
(3, 6, '44562F336156AC9B4EAA2D8DC170B6AD7E9013766DE0A37A2F8383B3E061604D', '2026-09-14 06:09:32.282917', '2026-12-13 06:09:32.282854'),
(4, 7, '5A62E469BA8B9A2C4D3F17DD4936A8403E93A548C4C13D2F39723C26066F05B3', '2026-09-14 06:17:06.619842', '2026-12-13 06:17:06.619788'),
(5, 6, 'C25D56AF1F9A0F77C18E6AEDA1574EFE2109B41F8755893EBF62A632775C56E0', '2026-09-14 06:20:49.363524', '2026-12-13 06:20:49.363481'),
(6, 7, '3DBC291AAC239BA9C7D9990B25E5A6DD543B4DA5735D4ECE3555C3231B877315', '2026-09-14 06:25:12.286107', '2026-12-13 06:25:12.286016'),
(7, 6, '549A6F35E0F48F8CF36C372C56D508FA2D46C0DB1E0E8D8E78391DDD6DE98DE9', '2026-09-14 08:26:57.283077', '2026-12-13 08:26:57.282373'),
(9, 6, 'AD815ADC3B23217C78CFC6F7E63B222BF3DCEAD2F94FB7039A1945F1131A1E7D', '2026-09-14 09:50:24.639905', '2026-12-13 09:50:24.639478'),
(10, 9, 'DB204C1E706577E0E8DCB4033BA4C943A14E5161FC086418DA0F0CF79E44C3C3', '2026-09-14 09:52:43.087482', '2026-12-13 09:52:43.087428'),
(12, 10, '31F6660E32ACBE2AEA0D1E0057D7C775AD5B5B1123995B29917D4AB4A40561E4', '2026-09-14 09:56:11.936237', '2026-12-13 09:56:11.936188'),
(14, 7, '1D4EA6A8F5070396C11EA9F4998F2D159828C29B5C78AF9C086B1A96A867F282', '2026-09-14 10:35:09.081741', '2026-12-13 10:35:09.081304'),
(16, 7, '6C4FFC81F4CB03622F0C9FDE5E068490BB3585A0E845944C6C4FD6379D95D0F4', '2026-09-14 10:44:14.076485', '2026-12-13 10:44:14.076409'),
(17, 6, '6C75E4AE623872ADEF5B6655C5DB9F2A28DC6A08EAEABC8DC16047682BB262E9', '2026-09-14 11:06:03.351519', '2026-12-13 11:06:03.351096'),
(18, 7, '7F5B3557487086EC019C7A44AF29E04A98F9C2D85A6F345B04F3DF4945D5A836', '2026-09-14 11:07:42.488084', '2026-12-13 11:07:42.488031'),
(19, 6, '7B1810DB6369AAFD47EBB7DDFE7EE0D7D6AEAFF59F1513600CDA86EB3CA2EF89', '2026-09-14 11:12:49.190672', '2026-12-13 11:12:49.190635'),
(21, 11, '3B5EDF9095F17A4A03D48538644B2A35AFDD2149515006C4476EE08981325FFF', '2026-09-15 10:21:47.768207', '2026-12-14 10:21:47.767554'),
(22, 6, '74D710C2B522CD2B83312E1CE8C6B5B0564D009B415E4385A7133056A8749194', '2026-09-15 10:29:41.643452', '2026-12-14 10:29:41.643418'),
(23, 10, 'B8E72DBCBBE8E8A69DCF99580ECEE7831BFB4BEE5065508BF75EC1F381238C5C', '2026-09-15 10:34:39.852048', '2026-12-14 10:34:39.852013'),
(25, 10, '57AABA6988877ED79F60B60DFC32A277CA0D0D967561C39CDCEBCE83377FEA65', '2026-09-15 10:37:39.274312', '2026-12-14 10:37:39.274278'),
(26, 9, '71B86AD7BF90117B4229F9977FE2DF9848E3A179772937F85A15602886BA0EF7', '2026-09-15 10:55:50.918064', '2026-12-14 10:55:50.917684'),
(28, 32, 'E9C26871186093475745C8E3872C7BC059412672FFC1F8A7355ECE41393F8DE4', '2026-10-05 08:36:10.916106', '2027-01-03 08:36:10.915288'),
(29, 6, 'D44040282E68F4B7BCF52159038D746B82ECB9EFD5A4126A39FCFB13FAF4A54A', '2026-10-05 08:38:25.533387', '2027-01-03 08:38:25.533329'),
(32, 2, 'FCD5BDC234284F62B106A972FCDFEA5F1CC9ECBCF56D8B8FA48921BD29EA14D8', '2026-10-16 06:20:44.092973', '2027-01-14 06:20:44.092441'),
(33, 7, 'FB42D59134D393D2D0D9910EDE1161FEDB57DF783804BAABA0F3A1D5AEDBA2DB', '2026-10-16 06:21:49.371910', '2027-01-14 06:21:49.371875'),
(34, 6, '0F5DE0D49AB3B59D40B0E684E59057FF8F453917031FFC4FAA4DF2B009FA18B4', '2026-10-16 06:23:15.248651', '2027-01-14 06:23:15.248590'),
(35, 2, 'BD583418F593ECC00B61AD70299FF7E90E487DF69CBB539BB9A39D89B4E0FFAD', '2026-10-16 07:25:49.907717', '2027-01-14 07:25:49.907461'),
(36, 6, '137762A8FCDCC40CF562ACC0BCC118AECEE83B4A595611A9D9536BFE16C6E2B5', '2026-10-16 07:27:13.957681', '2027-01-14 07:27:13.957642'),
(37, 7, '47DF1396A138B4FA7163088B129961B08A8ECA421D20893D2B7CE083DC11A151', '2026-10-16 07:29:19.311879', '2027-01-14 07:29:19.311855'),
(38, 6, '71BB2CD70EBDE22875362AA3D1F3C54AFE6E509422FE8873384BF844C3F1A100', '2026-10-16 07:30:40.641266', '2027-01-14 07:30:40.641236'),
(39, 7, 'C615CDC94C2F3552B8E441EBE0624B7A33506F86C6815C4A1D1BFF6DDE1CE621', '2026-10-16 07:31:21.133156', '2027-01-14 07:31:21.133134'),
(40, 33, '095E68EBC16737DCAD87959A4CE05E0EC27000124D7BEE8454C6D434C4DAEFD1', '2026-10-16 07:36:21.472862', '2027-01-14 07:36:21.472835');

/* Favoritos : 0 filas */

/* LogsAdmin : 12 filas */
INSERT INTO `LogsAdmin` (`Id_Log`, `Id_admin`, `Accion`, `Entidad_Afectada`, `Fecha`) VALUES
(2, 2, 'Aprobó solicitud de tienda', 'Petición #2 — Alimajo', '2026-09-11 12:17:38.603394'),
(7, 2, 'Bloqueó usuario por 1 días', 'Usuario #7 — brayancamilo7233@gmail.com — Motivo: me cae mal', '2026-09-14 09:48:10.095156'),
(8, 2, 'Desbloqueó usuario', 'Usuario #7 — brayancamilo7233@gmail.com', '2026-09-14 09:48:18.920071'),
(9, 2, 'Elevó usuario a Admin', 'Usuario #9 — juanm.acero2020@gmail.com', '2026-09-14 09:53:49.247480'),
(10, 2, 'Elevó usuario a Admin', 'Usuario #10 — alejo.oliveros80@gmail.com', '2026-09-14 09:58:25.074495'),
(11, 2, 'Bloqueó usuario por 1 días', 'Usuario #7 — brayancamilo7233@gmail.com — Motivo: Por acoso', '2026-09-14 10:48:06.438197'),
(12, 2, 'Desbloqueó usuario', 'Usuario #7 — brayancamilo7233@gmail.com', '2026-09-14 10:48:36.969511'),
(13, 2, 'Quitó rol de Admin', 'Usuario #10 — alejo.oliveros80@gmail.com', '2026-09-15 10:00:46.172307'),
(14, 2, 'Aprobó solicitud de tienda', 'Petición #3 — Bella Luna', '2026-09-15 10:23:25.818610'),
(15, 2, 'Aprobó solicitud de tienda', 'Petición #4 — Datol Sport', '2026-09-15 10:36:51.568091'),
(16, 2, 'Quitó rol de Admin', 'Usuario #9 — juanm.acero2020@gmail.com', '2026-09-15 10:47:38.529725'),
(17, 2, 'Aprobó solicitud de tienda', 'Petición #5 — Full Tecnology', '2026-09-15 10:57:13.268950');

/* MembresiasVendedor : 0 filas */

/* Mensajes : 77 filas */
INSERT INTO `Mensajes` (`Id_Mensaje`, `Id_UsuarioOrigen`, `Id_UsuarioDestino`, `Canal`, `Contenido`, `Fecha`, `Estado_Entrega`, `Leido`) VALUES
(4, 2, 6, 'Pagina', 'Tu solicitud para crear la tienda "Alimajo" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-11 12:17:38.643700', 'Enviado', 1),
(5, 2, 6, 'Correo', 'Tu solicitud para crear la tienda "Alimajo" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-11 12:17:42.955648', 'Enviado', 1),
(6, 2, 6, 'Sms', 'Tu solicitud para crear la tienda "Alimajo" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-11 12:17:42.961015', 'Enviado', 1),
(37, 2, 7, 'Pagina', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: me cae mal', '2026-09-14 09:48:10.211702', 'Enviado', 1),
(38, 2, 7, 'Correo', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: me cae mal', '2026-09-14 09:48:13.324512', 'Enviado', 1),
(39, 2, 7, 'Sms', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: me cae mal', '2026-09-14 09:48:13.328878', 'Enviado', 1),
(40, 2, 7, 'Pagina', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 09:48:18.926830', 'Enviado', 1),
(41, 2, 7, 'Correo', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 09:48:21.817802', 'Enviado', 1),
(42, 2, 7, 'Sms', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 09:48:21.820683', 'Enviado', 1),
(43, 2, 9, 'Pagina', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:53:49.256460', 'Enviado', 1),
(44, 2, 9, 'Correo', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:53:52.376251', 'Enviado', 1),
(45, 2, 9, 'Sms', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:53:52.380402', 'Enviado', 1),
(46, 2, 10, 'Pagina', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:58:25.082576', 'Enviado', 0),
(47, 2, 10, 'Correo', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:58:37.680023', 'Enviado', 0),
(48, 2, 10, 'Sms', 'Tu cuenta de MultiShop fue elevada a rol Administrador.', '2026-09-14 09:58:37.682495', 'Enviado', 0),
(49, 6, 2, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:26.647689', 'Enviado', 1),
(50, 6, 2, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:29.493131', 'Enviado', 1),
(51, 6, 2, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:29.497168', 'Enviado', 1),
(52, 6, 9, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:29.534456', 'Enviado', 1),
(53, 6, 9, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:32.681413', 'Enviado', 1),
(54, 6, 9, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:32.683730', 'Enviado', 1),
(55, 6, 2, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:30.102641', 'Enviado', 1),
(56, 6, 2, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:33.445362', 'Enviado', 1),
(57, 6, 2, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:33.448028', 'Enviado', 1),
(58, 6, 10, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:32.705814', 'Enviado', 0),
(59, 6, 10, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:35.741131', 'Enviado', 0),
(60, 6, 10, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:35.743612', 'Enviado', 0),
(61, 6, 9, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:33.453628', 'Enviado', 1),
(62, 6, 9, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:36.666881', 'Enviado', 1),
(63, 6, 9, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:36.669171', 'Enviado', 1),
(64, 6, 7, 'Pagina', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:35.750514', 'Enviado', 1),
(65, 6, 7, 'Correo', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:38.919493', 'Enviado', 1),
(66, 6, 7, 'Sms', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:38.921960', 'Enviado', 1),
(67, 6, 10, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:36.675163', 'Enviado', 0),
(68, 6, 10, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:40.336548', 'Enviado', 0),
(69, 6, 10, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: me amenazó con embarazarme :(', '2026-09-14 10:45:40.339133', 'Enviado', 0),
(70, 6, 7, 'Pagina', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:40.353373', 'Enviado', 1),
(71, 6, 7, 'Correo', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:44.553760', 'Enviado', 1),
(72, 6, 7, 'Sms', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-14 10:45:44.556870', 'Enviado', 1),
(73, 2, 7, 'Pagina', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: Por acoso', '2026-09-14 10:48:06.466742', 'Enviado', 1),
(74, 2, 7, 'Correo', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: Por acoso', '2026-09-14 10:48:10.328289', 'Enviado', 1),
(75, 2, 7, 'Sms', 'Tu cuenta de MultiShop fue bloqueada por 1 días (hasta el 15/09/2026). Motivo: Por acoso', '2026-09-14 10:48:10.330501', 'Enviado', 1),
(76, 2, 7, 'Pagina', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 10:48:36.974974', 'Enviado', 1),
(77, 2, 7, 'Correo', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 10:48:41.739668', 'Enviado', 1),
(78, 2, 7, 'Sms', 'Tu cuenta de MultiShop fue reactivada por el administrador.', '2026-09-14 10:48:41.742375', 'Enviado', 1),
(79, 2, 6, 'Pagina', 'ya lo bloquee', '2026-09-14 10:49:45.034066', 'Enviado', 1),
(80, 2, 6, 'Correo', 'ya lo bloquee', '2026-09-14 10:49:49.512165', 'Enviado', 1),
(81, 2, 6, 'Sms', 'ya lo bloquee', '2026-09-14 10:49:49.514419', 'Enviado', 1),
(82, 2, 6, 'Pagina', 'ya lo bloquee', '2026-09-14 10:49:53.867448', 'Enviado', 1),
(83, 2, 6, 'Correo', 'ya lo bloquee', '2026-09-14 10:49:58.001132', 'Enviado', 1),
(84, 2, 6, 'Sms', 'ya lo bloquee', '2026-09-14 10:49:58.003487', 'Enviado', 1),
(85, 6, 2, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:50.105178', 'Enviado', 1),
(86, 6, 2, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:53.193055', 'Enviado', 1),
(87, 6, 2, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:53.197548', 'Enviado', 1),
(88, 6, 9, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:53.245820', 'Enviado', 1),
(89, 6, 9, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:56.428963', 'Enviado', 1),
(90, 6, 9, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:56.432014', 'Enviado', 1),
(91, 6, 10, 'Pagina', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:17:56.441554', 'Enviado', 0),
(92, 6, 10, 'Correo', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:18:00.357220', 'Enviado', 0),
(93, 6, 10, 'Sms', 'El vendedor Magdy Chisino reportó una conversación con Brayan Lara. Motivo: hl', '2026-09-15 06:18:00.359924', 'Enviado', 0),
(94, 6, 7, 'Pagina', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-15 06:18:00.368638', 'Enviado', 1),
(95, 6, 7, 'Correo', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-15 06:18:06.099934', 'Enviado', 1),
(96, 6, 7, 'Sms', 'Una tienda reportó tu conversación por comportamiento inapropiado. Un administrador de MultiShop revisará el caso.', '2026-09-15 06:18:06.102235', 'Enviado', 1),
(97, 6, 7, 'Pagina', 'La tienda Alimajo canceló tu pedido del 11/09/2026 por $60.000. Si ya habías pagado, contacta a la tienda o radica una PQRS.', '2026-09-15 09:55:49.819316', 'Enviado', 1),
(98, 6, 7, 'Correo', 'La tienda Alimajo canceló tu pedido del 11/09/2026 por $60.000. Si ya habías pagado, contacta a la tienda o radica una PQRS.', '2026-09-15 09:55:53.379954', 'Enviado', 1),
(99, 2, 10, 'Pagina', 'Tu cuenta de MultiShop volvió a rol Cliente.', '2026-09-15 10:00:46.289352', 'Enviado', 0),
(100, 2, 10, 'Correo', 'Tu cuenta de MultiShop volvió a rol Cliente.', '2026-09-15 10:00:50.457259', 'Enviado', 0),
(101, 2, 11, 'Pagina', 'Tu solicitud para crear la tienda "Bella Luna" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:23:25.852797', 'Enviado', 0),
(102, 2, 11, 'Correo', 'Tu solicitud para crear la tienda "Bella Luna" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:23:29.545524', 'Enviado', 0),
(103, 2, 10, 'Pagina', 'Tu solicitud para crear la tienda "Datol Sport" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:36:51.575263', 'Enviado', 0),
(104, 2, 10, 'Correo', 'Tu solicitud para crear la tienda "Datol Sport" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:36:55.355606', 'Enviado', 0),
(105, 2, 9, 'Pagina', 'Tu cuenta de MultiShop volvió a rol Cliente.', '2026-09-15 10:47:38.536401', 'Enviado', 1),
(106, 2, 9, 'Correo', 'Tu cuenta de MultiShop volvió a rol Cliente.', '2026-09-15 10:47:42.850420', 'Enviado', 1),
(107, 2, 9, 'Pagina', 'Tu solicitud para crear la tienda "Full Tecnology" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:57:13.296452', 'Enviado', 1),
(108, 2, 9, 'Correo', 'Tu solicitud para crear la tienda "Full Tecnology" fue aprobada. Tu cuenta ahora tiene rol Vendedor.', '2026-09-15 10:57:17.229582', 'Enviado', 1),
(109, 2, 6, 'Pagina', 'ok', '2026-09-15 10:57:33.499264', 'Enviado', 1),
(110, 2, 6, 'Correo', 'ok', '2026-09-15 10:57:37.103485', 'Enviado', 1);

/* PeticionesCreacionTienda : 4 filas */
INSERT INTO `PeticionesCreacionTienda` (`Id_Peticion`, `Id_Usuario`, `Nombre_Tienda_Solicitada`, `Id_Categoria`, `DocumentosAdjuntos`, `Estado`, `Fecha`, `Rol_Asignado`) VALUES
(2, 6, 'Alimajo', 5, '{}', 'Aceptada', '2026-09-11 12:16:49.668830', 'Vendedor'),
(3, 11, 'Bella Luna', 7, '{}', 'Aceptada', '2026-09-15 10:22:41.019267', 'Vendedor'),
(4, 10, 'Datol Sport', 2, '{}', 'Aceptada', '2026-09-15 10:36:01.906958', 'Vendedor'),
(5, 9, 'Full Tecnology', 4, '{}', 'Aceptada', '2026-09-15 10:56:41.250978', 'Vendedor');

/* Pqrs : 4 filas */
INSERT INTO `Pqrs` (`Id_PQRS`, `Id_Usuario`, `Id_Tienda`, `Tipo`, `Descripcion`, `Respuesta`, `Estado`, `Fecha`) VALUES
(1, 7, 2, 'Sugerencia', 'Traer los elementos limpios', 'chinga tu madre', 'Respondida', '2026-09-11 12:28:28.609493'),
(4, 6, NULL, 'Queja', 'Reporte de chat contra Brayan Lara (usuario #7). Motivo: me amenazó con embarazarme :(. Últimos mensajes: Buenas tardes | perra | >:c | hola | mlp | pirobo', 'ya lo bloquee', 'Respondida', '2026-09-14 10:45:26.595756'),
(5, 6, NULL, 'Queja', 'Reporte de chat contra Brayan Lara (usuario #7). Motivo: me amenazó con embarazarme :(. Últimos mensajes: Buenas tardes | perra | >:c | hola | mlp | pirobo', 'ya lo bloquee', 'Respondida', '2026-09-14 10:45:30.080384'),
(6, 6, NULL, 'Queja', 'Reporte de chat contra Brayan Lara (usuario #7). Motivo: hl. Últimos mensajes: Buenas tardes | perra | >:c | hola | mlp | pirobo', 'ok', 'Respondida', '2026-09-15 06:17:49.903455');

/* TokensRecuperacion : 6 filas */
INSERT INTO `TokensRecuperacion` (`Id_Token`, `Id_Usuario`, `TokenHash`, `Fecha_Creacion`, `Fecha_Expira`, `Usado`) VALUES
(1, 9, '1CAF97376023945FA9D774B2A11A6FD63BCB79EB53BF86FA40B6E91572FB8050', '2026-10-15 21:27:00.127191', '2026-10-15 21:57:00.127232', 1),
(2, 9, '9D5DB6CE1D53F3D62084A3D3CF2D994A46127132DA62D7E552406E1A4C1A9B4C', '2026-10-15 21:28:55.463533', '2026-10-15 21:58:55.463925', 1),
(3, 2, 'B7D8EC5187B79875DBF7D4B18EFE28DF9AD67AD13E748D65660EF99F116E7EAD', '2026-10-15 21:30:47.456102', '2026-10-15 22:00:47.456103', 1),
(4, 9, '4D608B3DEB9CCFB324CE13E362D0182C4966843DBF97EB8A575DE02CC7D48BC2', '2026-10-15 22:25:04.970840', '2026-10-15 22:55:04.970871', 0),
(5, 2, 'D79D738E17C285D28B2E85F77B529328FE8E7687760FA18D6ADBF1BCC0972EEE', '2026-10-16 06:18:11.770764', '2026-10-16 06:48:11.770841', 1),
(6, 2, '7603702E5273ABB886D2A8A5D487AAC7DBFBE72A789A43A431801EBDDDF2AAD6', '2026-10-16 06:19:37.303109', '2026-10-16 06:49:37.303110', 1);

/* __EFMigrationsHistory : 14 filas */
INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`) VALUES
('20260911160237_InicialMultishop', '8.0.30'),
('20260911162328_AgregarComprobanteQR', '8.0.30'),
('20260911164322_AgregarSegundoAdmin', '8.0.30'),
('20260911165420_EliminarPrimerAdmin', '8.0.30'),
('20260914092315_CorreccionesRondaDos', '8.0.30'),
('20260914144234_BloqueoConMotivoYAutomatico', '8.0.30'),
('20260915122712_AgregarEntregaFactura', '8.0.30'),
('20260915131300_ColoresPersonalizadosTienda', '8.0.30'),
('20260915134403_EliminarSeguimientoDomicilios', '8.0.30'),
('20260916113310_AgregarVariantesProducto', '8.0.30'),
('20260916161932_AgregarFondoNavbarTienda', '8.0.30'),
('20261016020813_SeguridadYLogicaF1', '8.0.30'),
('20261016022451_RecuperacionContrasena', '8.0.30'),
('20261016023920_ModeloF3', '8.0.30');

SET FOREIGN_KEY_CHECKS = 1;
