-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-06-2020 a las 21:42:37
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ibec_bd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `auditorProcedure` (`query_sql` VARCHAR(255), `tabla` VARCHAR(20), `tipo` VARCHAR(20))  BEGIN
INSERT INTO logs_auditoria VALUES (0,NOW(),query_sql,tabla,tipo); 

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(10) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES
(1, 'Marcelo', 'Tizzi'),
(2, 'Silvia', 'Bazzano'),
(3, 'Veronica', 'Torner'),
(4, 'Juan', 'Perez'),
(5, 'Andres', 'Lopez');

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `trg_clientes_delete` AFTER DELETE ON `clientes` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'CLIENTES','DELETE'); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_clientes_insert` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'CLIENTES','INSERT'); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_clientes_update` AFTER UPDATE ON `clientes` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'CLIENTES','UPDATE'); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_auditoria`
--

CREATE TABLE `logs_auditoria` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `query_sql` text NOT NULL,
  `tabla` varchar(20) NOT NULL,
  `tipo` enum('INSERT','UPDATE','DELETE') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `logs_auditoria`
--

INSERT INTO `logs_auditoria` (`id`, `fecha`, `query_sql`, `tabla`, `tipo`) VALUES
(31, '2020-06-23', 'INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES (\'1\', \'Marcelo\', \'Tizzi\'), (\'2\', \'Silvia\', \'Bazzano\')', 'CLIENTES', 'INSERT'),
(32, '2020-06-23', 'INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES (\'1\', \'Marcelo\', \'Tizzi\'), (\'2\', \'Silvia\', \'Bazzano\')', 'CLIENTES', 'INSERT'),
(33, '2020-06-23', 'INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES (\'3\', \'Veronica\', \'Torner\'), (\'4\', \'Juan\', \'Perez\'),(\'5\', \'Andres\', \'Lopez\')', 'CLIENTES', 'INSERT'),
(34, '2020-06-23', 'INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES (\'3\', \'Veronica\', \'Torner\'), (\'4\', \'Juan\', \'Perez\'),(\'5\', \'Andres\', \'Lopez\')', 'CLIENTES', 'INSERT'),
(35, '2020-06-23', 'INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES (\'3\', \'Veronica\', \'Torner\'), (\'4\', \'Juan\', \'Perez\'),(\'5\', \'Andres\', \'Lopez\')', 'CLIENTES', 'INSERT'),
(36, '2020-06-23', 'INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES (\'1\', \'Arroz\', \'1k excelente para la cocina\', \'72\'), (\'2\', \'Vino\', \'1L Tinto\', \'250\')', 'PRODUCTOS', 'INSERT'),
(37, '2020-06-23', 'INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES (\'1\', \'Arroz\', \'1k excelente para la cocina\', \'72\'), (\'2\', \'Vino\', \'1L Tinto\', \'250\')', 'PRODUCTOS', 'INSERT'),
(38, '2020-06-23', 'INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES (\'3\', \'Harina\', \'0000\', \'95\'), (\'4\', \'Azucar\', \'1k la mejor para postres\', \'75\')', 'PRODUCTOS', 'INSERT'),
(39, '2020-06-23', 'INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES (\'3\', \'Harina\', \'0000\', \'95\'), (\'4\', \'Azucar\', \'1k la mejor para postres\', \'75\')', 'PRODUCTOS', 'INSERT'),
(40, '2020-06-23', 'INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES (\'5\', \'Agua\', \'500cc ideal para deportistas\', \'35\')', 'PRODUCTOS', 'INSERT'),
(41, '2020-06-23', 'INSERT INTO `stock` (`id`, `codigo_producto`, `id_cliente`) VALUES (\'1\', \'5\', \'1\'), (\'2\', \'2\', \'2\')', 'STOCK', 'INSERT'),
(42, '2020-06-23', 'INSERT INTO `stock` (`id`, `codigo_producto`, `id_cliente`) VALUES (\'1\', \'5\', \'1\'), (\'2\', \'2\', \'2\')', 'STOCK', 'INSERT'),
(43, '2020-06-23', 'INSERT INTO `stock` (`id`, `codigo_producto`, `id_cliente`) VALUES (\'3\', \'4\', \'3\'), (\'4\', \'5\', \'5\')', 'STOCK', 'INSERT'),
(44, '2020-06-23', 'INSERT INTO `stock` (`id`, `codigo_producto`, `id_cliente`) VALUES (\'3\', \'4\', \'3\'), (\'4\', \'5\', \'5\')', 'STOCK', 'INSERT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `codigo` int(10) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`codigo`, `nombre`, `descripcion`, `precio`) VALUES
(1, 'Arroz', '1k excelente para la cocina', 72),
(2, 'Vino', '1L Tinto', 250),
(3, 'Harina', '0000', 95),
(4, 'Azucar', '1k la mejor para postres', 75),
(5, 'Agua', '500cc ideal para deportistas', 35);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `trg_productos_delete` AFTER DELETE ON `productos` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'PRODUCTOS','DELETE'); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_productos_insert` AFTER INSERT ON `productos` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'PRODUCTOS','INSERT'); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_productos_update` AFTER UPDATE ON `productos` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'PRODUCTOS','UPDATE'); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `id` int(10) NOT NULL,
  `codigo_producto` int(10) NOT NULL,
  `id_cliente` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `stock`
--

INSERT INTO `stock` (`id`, `codigo_producto`, `id_cliente`) VALUES
(1, 5, 1),
(2, 2, 2),
(3, 4, 3),
(4, 5, 5);

--
-- Disparadores `stock`
--
DELIMITER $$
CREATE TRIGGER `trg_stock_delete` AFTER DELETE ON `stock` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'STOCK','DELETE'); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_stock_insert` AFTER INSERT ON `stock` FOR EACH ROW BEGIN
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
   CALL auditorProcedure(query_sql,'STOCK','INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_stock_update` AFTER UPDATE ON `stock` FOR EACH ROW BEGIN 
DECLARE query_sql VARCHAR(255);
SET query_sql = (SELECT info FROM INFORMATION_SCHEMA.PROCESSLIST WHERE id = CONNECTION_ID());
CALL auditorProcedure(query_sql,'STOCK','UPDATE'); 
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logs_auditoria`
--
ALTER TABLE `logs_auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_producto` (`codigo_producto`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `logs_auditoria`
--
ALTER TABLE `logs_auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `codigo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
