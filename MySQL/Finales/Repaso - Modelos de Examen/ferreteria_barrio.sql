CREATE DATABASE db_ferreteria;

USE db_ferreteria;

# Creacion de Tablas

# Tabla cliente
CREATE TABLE `db_ferreteria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_cliente`));
  
# Tabla producto
CREATE TABLE `db_ferreteria`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  `precio_producto` DECIMAL NOT NULL,
  PRIMARY KEY (`id_producto`));
  
# Tabla deposito
CREATE TABLE `db_ferreteria`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha_ingreso` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `producto_fk_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `producto_fk`
    FOREIGN KEY (`id_producto`)
    REFERENCES `db_ferreteria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Tabla pedido
CREATE TABLE `db_ferreteria`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_deposito` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `direccion_pedido` VARCHAR(30) NOT NULL,
  `precio_pedido` DECIMAL NOT NULL,
  `fecha_pedido` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `deposito_fk_idx` (`id_deposito` ASC) VISIBLE,
  INDEX `cliente_fk_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `deposito_fk`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `db_ferreteria`.`deposito` (`id_deposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_fk`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_ferreteria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Insertions

# Ingreso de clientes
INSERT INTO `db_ferreteria`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Nicolas', 'Mayoral', 'Castelli 315', '2604348538');
INSERT INTO `db_ferreteria`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Bruno', 'Bobadilla', 'Entre Rios 550', '2604723554');
INSERT INTO `db_ferreteria`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Julian', 'Castillo', 'Ballofet 1000', '2604775728');

SELECT * FROM cliente;

# Ingreso de productos
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Martillo', 'Martillo. Herramienta de mano.', '1500');
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Pinza', 'Pinza. Herramienta de mano utilizada para cortar', '1400');
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Tornillo', 'Insumo de construcción', '30');
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Tuerca', 'Insumo de construcción', '40');
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Arandela', 'Insumo de construcción.', '25');
INSERT INTO `db_ferreteria`.`producto` (`nombre`, `descripcion`, `precio_producto`) VALUES ('Clavo', 'Clavo de medida estandar.', '20');

SELECT * FROM producto;

# Ingreso de deposito
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('1', '50', current_timestamp());
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('2', '50', current_timestamp());
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('3', '500', current_timestamp());
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('4', '400', current_timestamp());
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('5', '300', current_timestamp());
INSERT INTO `db_ferreteria`.`deposito` (`id_producto`, `cantidad`, `fecha_ingreso`) VALUES ('6', '800', current_timestamp());

SELECT * FROM deposito;

SELECT * FROM deposito d INNER JOIN producto p ON (d.id_producto = p.id_producto);

# Ingreso de pedidos
INSERT INTO `db_ferreteria`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('1', '1', '1', (select direccion from cliente where id_cliente = 1), '1500', current_timestamp());
INSERT INTO `db_ferreteria`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('6', '2', '20', (select direccion from cliente where id_cliente = 2), '400', current_timestamp());
INSERT INTO `db_ferreteria`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('2', '3', '2', (select direccion from cliente where id_cliente = 3), '2800', current_timestamp());

SELECT * FROM pedido;

# Consultas

# Consultar Stock por fecha
SELECT
	P.nombre as 'Producto',
    P.descripcion as 'Descripción',
    D.cantidad as 'Cantidad',
    P.precio_producto as 'Precio por Unidad',
    D.fecha_ingreso as 'Fecha de Ingreso'
FROM deposito D INNER JOIN producto P ON (D.id_producto = P.id_producto) WHERE DATE(fecha_ingreso) = DATE('2022-07-07%');

# Consultar pedidos diarios

# Muestra todos los pedidos diarios con detalles de los mismos
SELECT
	C.nombre as 'Cliente',
	P.nombre as 'Producto',
    Pe.cantidad as 'Cantidad',
    Pe.precio_pedido as 'Precio del Pedido',
    Pe.direccion_pedido as 'Direccion de destino',
    Pe.fecha_pedido as 'Fecha del Pedido'
FROM producto P INNER JOIN Deposito D ON (P.id_producto = D.id_producto) 
INNER JOIN pedido Pe ON (D.id_deposito = Pe.id_deposito)
INNER JOIN cliente C ON (Pe.id_cliente = C.id_cliente)
WHERE DATE(fecha_pedido) = DATE('2022-07-07%');

# Muestra el numero de pedidos diarios solamente
SELECT 
	COUNT(id_pedido) AS 'Pedidos de Hoy'
FROM pedido WHERE DATE(fecha_pedido) = DATE('2022-07-07%');

# Creacion de vistas

CREATE VIEW Consultar_Stock AS
SELECT
	P.nombre as 'Producto',
    P.descripcion as 'Descripción',
    D.cantidad as 'Cantidad',
    P.precio_producto as 'Precio por Unidad',
    D.fecha_ingreso as 'Fecha de Ingreso'
FROM deposito D INNER JOIN producto P ON (D.id_producto = P.id_producto);

CREATE VIEW Vista_Pedidos AS
SELECT
	C.nombre as 'Cliente',
	P.nombre as 'Producto',
    Pe.cantidad as 'Cantidad',
    Pe.precio_pedido as 'Precio del Pedido',
    Pe.direccion_pedido as 'Direccion de destino',
    Pe.fecha_pedido as 'Fecha del Pedido'
FROM producto P INNER JOIN Deposito D ON (P.id_producto = D.id_producto) 
INNER JOIN pedido Pe ON (D.id_deposito = Pe.id_deposito)
INNER JOIN cliente C ON (Pe.id_cliente = C.id_cliente);

# Llamar a las vistas
SELECT * FROM Consultar_Stock;
SELECT * FROM Vista_Pedidos;
