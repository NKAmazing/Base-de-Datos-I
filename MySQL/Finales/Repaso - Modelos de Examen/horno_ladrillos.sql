CREATE DATABASE db_ladrillos;

USE db_ladrillos;

# Tabla producto
CREATE TABLE `db_ladrillos`.`producto` (
  `id_ladrillo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(50) NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`id_ladrillo`));

# Tabla deposito
CREATE TABLE `db_ladrillos`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_ladrillo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `ladrillos foreign key_idx` (`id_ladrillo` ASC) VISIBLE,
  CONSTRAINT `ladrillos foreign key`
    FOREIGN KEY (`id_ladrillo`)
    REFERENCES `db_ladrillos`.`producto` (`id_ladrillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    ALTER TABLE `db_ladrillos`.`deposito` 
CHANGE COLUMN `fecha` `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ;

# Tabla cliente
CREATE TABLE `db_ladrillos`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_cliente`));

# Tabla de pedidos
CREATE TABLE `db_ladrillos`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_deposito` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `direccion_pedido` VARCHAR(50) NOT NULL,
  `precio_pedido` DECIMAL NOT NULL,
  `fecha_pedido` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `cliente_fk_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `deposito_fk_idx` (`id_deposito` ASC) VISIBLE,
  CONSTRAINT `deposito_fk`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `db_ladrillos`.`deposito` (`id_deposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_fk`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_ladrillos`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Insertar datos en las tablas

# Ingreso de clientes
INSERT INTO `db_ladrillos`.`cliente` (`id_cliente`, `tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('1', 'Consumidor final', 'Nicolas', 'Mayoral', 'Castelli 315', '2604348538');
INSERT INTO `db_ladrillos`.`cliente` (`id_cliente`, `tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('2', 'Consumidor final', 'Julian', 'Castillo', 'Ballofet 1000', '2604775624');
INSERT INTO `db_ladrillos`.`cliente` (`id_cliente`, `tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('3', 'Consumidor final', 'Juan', 'Sueta', 'Sobremonte 1200', '2604423877');

# Reviso si estan los datos
SELECT * FROM cliente;

# Ingreso de productos
INSERT INTO `db_ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo horneado', 'Ladrillo recien horneado', '50');
INSERT INTO `db_ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo de Adobon', 'Ladrillo comun de adobon', '110');
INSERT INTO `db_ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo de construcción', 'Ladrillo de construcción estandar', '120');
INSERT INTO `db_ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Palet Ladrillo de Adobon', 'Palet de 500 unidades de ladrillo Adobon', '50000');
INSERT INTO `db_ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Palet Ladrillo de Construcción', 'Palet de 500 unidades de ladrillo de construcción', '60000');

# Reviso si estan los datos
SELECT * FROM producto;

# Ingreso de deposito
INSERT INTO `db_ladrillos`.`deposito` (`id_ladrillo`, `cantidad`, `fecha`) VALUES ('1', '5000', current_timestamp());
INSERT INTO `db_ladrillos`.`deposito` (`id_ladrillo`, `cantidad`, `fecha`) VALUES ('2', 2000, current_timestamp());
INSERT INTO `db_ladrillos`.`deposito` (`id_ladrillo`, `cantidad`, `fecha`) VALUES ('3', 3000, current_timestamp());
INSERT INTO `db_ladrillos`.`deposito` (`id_ladrillo`, `cantidad`, `fecha`) VALUES ('4', '3', current_timestamp());
INSERT INTO `db_ladrillos`.`deposito` (`id_ladrillo`, `cantidad`, `fecha`) VALUES ('5', '7', current_timestamp());

# Reviso si estan los datos
SELECT * FROM deposito;

# Ingreso de pedido
INSERT INTO `db_ladrillos`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('5', '1', '2', 'Castelli 315', '240', current_timestamp());
INSERT INTO `db_ladrillos`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('4', '3', '1', 'Sobremonte 1200', '110', current_timestamp());
INSERT INTO `db_ladrillos`.`pedido` (`id_deposito`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('5', '2', '3', 'Ballofet 1000', '360', current_timestamp());

# Reviso si estan los datos
SELECT * FROM pedido;

# Creacion de Consultas

# Consulta 1
SELECT 
	P.nombre as 'Nombre de producto',
	D.cantidad as 'Cantidad',
    P.precio as 'Precio',
    D.fecha as 'Fecha y Hora'
FROM deposito D INNER JOIN producto P ON (D.id_ladrillo = P.id_ladrillo) WHERE D.fecha LIKE('%2022-07-06 12:15:28%');

# Consulta 2
SELECT
	count(id_pedido) as 'Cantidad de pedidos de Hoy'
FROM pedido WHERE fecha_pedido LIKE('2022-07-06%');

# Creacion de Vistas
CREATE VIEW VistaDeposito AS 
SELECT 
	P.nombre as 'Nombre de producto',
	D.cantidad as 'Cantidad',
    P.precio as 'Precio',
    D.fecha as 'Fecha y Hora'
FROM deposito D INNER JOIN producto P ON (D.id_ladrillo = P.id_ladrillo) WHERE D.fecha LIKE('%2022-07-06 12:15:28%');

SELECT * FROM VistaDeposito;

CREATE VIEW VistaPedidos AS
SELECT
	count(id_pedido) as 'Cantidad de pedidos de Hoy'
FROM pedido WHERE fecha_pedido LIKE('2022-07-06%');

SELECT * FROM VistaPedidos;



