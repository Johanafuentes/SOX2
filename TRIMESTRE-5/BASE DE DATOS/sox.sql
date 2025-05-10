-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2025 a las 03:46:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sox`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_ruta`
--

CREATE TABLE `asignacion_ruta` (
  `id_asignacion` int(11) NOT NULL,
  `id_ruta` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `id_conductor` int(11) DEFAULT NULL,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `estado` enum('pendiente','en_progreso','completado','cancelado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignacion_ruta`
--

INSERT INTO `asignacion_ruta` (`id_asignacion`, `id_ruta`, `id_pedido`, `id_vehiculo`, `id_conductor`, `fecha_asignacion`, `estado`) VALUES
(1, 1, 1, 1, 1, '2025-04-22 01:21:53', 'pendiente'),
(2, 2, 2, 2, 2, '2025-04-22 01:21:53', 'en_progreso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL COMMENT 'ID único de la categoría',
  `nombre_categoria` varchar(100) NOT NULL COMMENT 'Nombre único de la categoría',
  `descripcion` text DEFAULT NULL COMMENT 'Descripción de la categoría',
  `estado` enum('activo','inactivo') DEFAULT 'activo' COMMENT 'Estado actual de la categoría',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación',
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Última fecha de actualización'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de categorías para productos del inventario';

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`, `descripcion`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'Electrónica', 'Dispositivos electrónicos como televisores, laptops, celulares, etc.', 'activo', '2025-04-22 06:28:14', '2025-04-22 06:28:14'),
(2, 'Ropa', 'Prendas de vestir para hombres, mujeres y niños.', 'activo', '2025-04-22 06:28:14', '2025-04-22 06:28:14'),
(3, 'Alimentos', 'Productos comestibles, perecederos o no.', 'activo', '2025-04-22 06:28:14', '2025-04-22 06:28:14'),
(4, 'Papelería', 'Artículos de oficina, útiles escolares y papelería general.', 'inactivo', '2025-04-22 06:28:14', '2025-04-22 06:28:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conductores`
--

CREATE TABLE `conductores` (
  `id_conductor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `licencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `conductores`
--

INSERT INTO `conductores` (`id_conductor`, `nombre`, `licencia`) VALUES
(1, 'Juan Pérez', 'L123456'),
(2, 'Ana Gómez', 'L654321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `id_devolucion` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL CHECK (`cantidad` > 0),
  `motivo` varchar(255) NOT NULL,
  `fecha_devolucion` datetime DEFAULT current_timestamp(),
  `recibido_por` varchar(100) DEFAULT NULL,
  `estado` enum('pendiente','procesada','rechazada') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `devoluciones`
--

INSERT INTO `devoluciones` (`id_devolucion`, `id_producto`, `cantidad`, `motivo`, `fecha_devolucion`, `recibido_por`, `estado`, `observaciones`) VALUES
(1, 1, 2, 'Producto defectuoso', '2025-04-22 01:46:59', 'Luis Gómez', 'pendiente', 'Teclas no responden correctamente'),
(2, 2, 1, 'Error en envío', '2025-04-22 01:46:59', 'Marta Pérez', 'procesada', 'Cliente recibió modelo equivocado'),
(3, 3, 1, 'Cliente no satisfecho', '2025-04-22 01:46:59', 'Carlos Ruiz', 'rechazada', 'Sin detalles adicionales'),
(4, 1, 2, 'Producto defectuoso', '2025-04-22 01:59:25', 'Luis Hernández', 'pendiente', 'Teclados no funcionan correctamente'),
(5, 2, 1, 'Error en envío', '2025-04-22 01:59:25', 'Ana Gómez', 'procesada', 'Cliente recibió modelo equivocado'),
(6, 3, 3, 'Cliente no satisfecho', '2025-04-22 01:59:25', 'Carlos Fernández', 'rechazada', 'Producto no cumple expectativas'),
(7, 1, 1, 'Producto dañado', '2025-04-22 01:59:25', 'Raúl Sánchez', 'pendiente', 'Pantalla con píxeles muertos'),
(8, 2, 2, 'No es lo que pedí', '2025-04-22 01:59:25', 'Marta López', 'procesada', 'Cambio por modelo diferente solicitado'),
(9, 3, 1, 'Cliente canceló pedido', '2025-04-22 01:59:25', 'Eduardo Pérez', 'rechazada', 'Cancelación fuera de tiempo'),
(10, 1, 3, 'Defectos de fabricación', '2025-04-22 01:59:25', 'Carla Martínez', 'pendiente', 'Problema con el ensamblaje'),
(11, 2, 4, 'No es lo que esperaba', '2025-04-22 01:59:25', 'Luis Hernández', 'procesada', 'Cambio aceptado por el cliente'),
(12, 3, 2, 'Producto no compatible', '2025-04-22 01:59:25', 'Marta Torres', 'rechazada', 'Producto incompatible con otros equipos'),
(13, 1, 5, 'Producto defectuoso', '2025-04-22 01:59:25', 'Antonio Castillo', 'pendiente', 'Problemas con la conectividad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrega_mercancia`
--

CREATE TABLE `entrega_mercancia` (
  `id_entrega` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL CHECK (`cantidad` > 0),
  `destinatario` varchar(100) NOT NULL,
  `fecha_entrega` datetime DEFAULT current_timestamp(),
  `entregado_por` varchar(100) DEFAULT NULL,
  `tipo_entrega` enum('venta','traslado','donación','otro') DEFAULT 'venta',
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `entrega_mercancia`
--

INSERT INTO `entrega_mercancia` (`id_entrega`, `id_producto`, `cantidad`, `destinatario`, `fecha_entrega`, `entregado_por`, `tipo_entrega`, `observaciones`) VALUES
(1, 1, 2, 'Oficina Administración', '2025-04-22 01:44:33', 'Carlos Soto', 'traslado', 'Entrega para nuevo personal'),
(2, 2, 5, 'Cliente Juan Pérez', '2025-04-22 01:44:33', 'María Gómez', 'venta', 'Venta al por menor'),
(3, 3, 1, 'Fundación La Esperanza', '2025-04-22 01:44:33', 'Pedro Luna', 'donación', 'Entrega sin fines de lucro'),
(4, 1, 2, 'Oficina Administrativa', '2025-04-22 01:57:38', 'Carlos Soto', 'traslado', 'Entrega para nuevo personal'),
(5, 2, 3, 'Sucursal Norte', '2025-04-22 01:57:38', 'Ana Gómez', 'venta', 'Entrega de productos a tienda'),
(6, 3, 5, 'Cliente Juan Pérez', '2025-04-22 01:57:38', 'Luis Ramírez', 'venta', 'Compra de productos al por mayor'),
(7, 1, 1, 'Sucursal Este', '2025-04-22 01:57:38', 'Marta Torres', 'traslado', 'Productos destinados a almacén de sucursal'),
(8, 2, 2, 'Sucursal Oeste', '2025-04-22 01:57:38', 'Raúl Sánchez', 'venta', 'Entrega para el cliente final'),
(9, 3, 4, 'Cliente Laura Díaz', '2025-04-22 01:57:38', 'Carla Martínez', 'donación', 'Donación a fundación local'),
(10, 1, 3, 'Sucursal Centro', '2025-04-22 01:57:38', 'Eduardo Pérez', 'traslado', 'Se reubican productos por reabastecimiento'),
(11, 2, 1, 'Cliente Pedro Rodríguez', '2025-04-22 01:57:38', 'Luis Hernández', 'venta', 'Venta realizada al cliente final'),
(12, 3, 6, 'Sucursal Norte', '2025-04-22 01:57:38', 'Antonio Castillo', 'venta', 'Entrega para punto de venta'),
(13, 1, 2, 'Sucursal Sur', '2025-04-22 01:57:38', 'Marta López', 'traslado', 'Movimiento de mercancía entre sucursales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gestion_despachos`
--

CREATE TABLE `gestion_despachos` (
  `id_despacho` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_despachada` int(11) NOT NULL CHECK (`cantidad_despachada` > 0),
  `destino` varchar(100) NOT NULL,
  `fecha_despacho` datetime DEFAULT current_timestamp(),
  `encargado` varchar(100) DEFAULT NULL,
  `estado` enum('pendiente','en_transito','entregado','cancelado') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `gestion_despachos`
--

INSERT INTO `gestion_despachos` (`id_despacho`, `id_producto`, `cantidad_despachada`, `destino`, `fecha_despacho`, `encargado`, `estado`, `observaciones`) VALUES
(1, 1, 2, 'Sucursal Norte', '2025-04-22 01:49:35', 'Luis Morales', 'en_transito', 'Se entregará el lunes por la mañana'),
(2, 2, 4, 'Sucursal Centro', '2025-04-22 01:49:35', 'Ana Rojas', 'pendiente', 'Empaque en proceso'),
(3, 3, 1, 'Sucursal Sur', '2025-04-22 01:49:35', 'Pedro Castillo', 'entregado', 'Despacho completado sin inconvenientes'),
(4, 1, 2, 'Sucursal Oeste', '2025-04-22 01:55:34', 'Carlos Soto', 'en_transito', 'Se espera la llegada el lunes'),
(5, 2, 5, 'Sucursal Norte', '2025-04-22 01:55:34', 'Ana Gómez', 'pendiente', 'Por empacar'),
(6, 3, 1, 'Cliente Juan Pérez', '2025-04-22 01:55:34', 'Luis Ramírez', 'entregado', 'Entrega realizada el viernes'),
(7, 1, 3, 'Sucursal Este', '2025-04-22 01:55:34', 'Marta Torres', 'en_transito', 'Entrega parcial realizada'),
(8, 2, 2, 'Cliente Laura Díaz', '2025-04-22 01:55:34', 'Raúl Sánchez', 'pendiente', 'Por confirmar hora de entrega'),
(9, 3, 4, 'Sucursal Sur', '2025-04-22 01:55:34', 'Carlos Fernández', 'entregado', 'Despacho finalizado sin inconvenientes'),
(10, 1, 1, 'Cliente Pedro Rodríguez', '2025-04-22 01:55:34', 'Luis Hernández', 'pendiente', 'Esperando confirmación de pago'),
(11, 2, 6, 'Sucursal Centro', '2025-04-22 01:55:34', 'Eduardo Sánchez', 'en_transito', 'Se encuentra en ruta'),
(12, 3, 5, 'Sucursal Norte', '2025-04-22 01:55:34', 'Marta López', 'entregado', 'Despacho realizado exitosamente'),
(13, 1, 2, 'Sucursal Este', '2025-04-22 01:55:34', 'Antonio Castillo', 'pendiente', 'Preparando mercancía');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `descripcion`, `fecha_pedido`) VALUES
(1, 'Pedido de electrodomésticos', '2025-04-21'),
(2, 'Pedido de alimentos', '2025-04-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL COMMENT 'ID único del producto',
  `nombre_producto` varchar(150) NOT NULL COMMENT 'Nombre del producto',
  `id_categoria` int(11) DEFAULT NULL COMMENT 'Relación con la categoría del producto',
  `cantidad` int(11) DEFAULT 0 COMMENT 'Cantidad disponible en inventario',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio del producto',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de registro del producto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de productos del inventario';

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `id_categoria`, `cantidad`, `precio`, `fecha_registro`) VALUES
(1, 'Laptop Lenovo IdeaPad 3', 1, 15, 2200.00, '2025-04-22 06:28:14'),
(2, 'Camiseta Hombre Talla M', 2, 50, 12.50, '2025-04-22 06:28:14'),
(3, 'Arroz 1kg', 3, 200, 1.20, '2025-04-22 06:28:14'),
(4, 'Cuaderno Profesional', 4, 100, 2.50, '2025-04-22 06:28:14'),
(5, 'Laptop HP ProBook', NULL, 10, 2300.00, '2025-04-22 06:32:36'),
(6, 'Camisa Formal Hombre Talla L', NULL, 25, 15.50, '2025-04-22 06:32:36'),
(7, 'Arroz Integral 1kg', NULL, 100, 1.80, '2025-04-22 06:32:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas`
--

CREATE TABLE `rutas` (
  `id_ruta` int(11) NOT NULL,
  `nombre_ruta` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rutas`
--

INSERT INTO `rutas` (`id_ruta`, `nombre_ruta`, `descripcion`) VALUES
(1, 'Ruta Norte', 'Entrega zona norte'),
(2, 'Ruta Sur', 'Entrega zona sur');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `correo_usuario` varchar(100) NOT NULL,
  `contrasena_usuario` varchar(255) NOT NULL,
  `rol` enum('administrador','vendedor','almacenista','gerente','otro') DEFAULT 'otro',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo','suspendido') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `correo_usuario`, `contrasena_usuario`, `rol`, `fecha_creacion`, `estado`) VALUES
(1, 'Carlos Fernández', 'carlos@empresa.com', 'password123', 'administrador', '2025-04-22 06:51:36', 'activo'),
(2, 'Ana García', 'ana@empresa.com', 'password456', 'vendedor', '2025-04-22 06:51:36', 'activo'),
(3, 'Luis Pérez', 'luis@empresa.com', 'password789', 'almacenista', '2025-04-22 06:51:36', 'activo'),
(4, 'Marta López', 'marta@empresa.com', 'password321', 'gerente', '2025-04-22 06:51:36', 'inactivo'),
(5, 'Javier Sánchez', 'javier@empresa.com', 'password000', 'vendedor', '2025-04-22 06:51:36', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id_vehiculo` int(11) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `marca` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id_vehiculo`, `placa`, `marca`) VALUES
(1, 'ABC123', 'Toyota'),
(2, 'XYZ789', 'Ford');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion_ruta`
--
ALTER TABLE `asignacion_ruta`
  ADD PRIMARY KEY (`id_asignacion`),
  ADD KEY `id_ruta` (`id_ruta`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_vehiculo` (`id_vehiculo`),
  ADD KEY `id_conductor` (`id_conductor`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `conductores`
--
ALTER TABLE `conductores`
  ADD PRIMARY KEY (`id_conductor`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `entrega_mercancia`
--
ALTER TABLE `entrega_mercancia`
  ADD PRIMARY KEY (`id_entrega`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `gestion_despachos`
--
ALTER TABLE `gestion_despachos`
  ADD PRIMARY KEY (`id_despacho`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD PRIMARY KEY (`id_ruta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo_usuario` (`correo_usuario`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id_vehiculo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignacion_ruta`
--
ALTER TABLE `asignacion_ruta`
  MODIFY `id_asignacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID único de la categoría', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `conductores`
--
ALTER TABLE `conductores`
  MODIFY `id_conductor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `id_devolucion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `entrega_mercancia`
--
ALTER TABLE `entrega_mercancia`
  MODIFY `id_entrega` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `gestion_despachos`
--
ALTER TABLE `gestion_despachos`
  MODIFY `id_despacho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID único del producto', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `rutas`
--
ALTER TABLE `rutas`
  MODIFY `id_ruta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion_ruta`
--
ALTER TABLE `asignacion_ruta`
  ADD CONSTRAINT `asignacion_ruta_ibfk_1` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignacion_ruta_ibfk_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `asignacion_ruta_ibfk_3` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id_vehiculo`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `asignacion_ruta_ibfk_4` FOREIGN KEY (`id_conductor`) REFERENCES `conductores` (`id_conductor`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrega_mercancia`
--
ALTER TABLE `entrega_mercancia`
  ADD CONSTRAINT `entrega_mercancia_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `gestion_despachos`
--
ALTER TABLE `gestion_despachos`
  ADD CONSTRAINT `gestion_despachos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
