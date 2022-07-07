CREATE DATABASE db_plantacion_manzanas;

USE db_plantacion_manzanas;

# Creacion de Tablas

# Tabla cliente
CREATE TABLE `db_plantacion_manzanas`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_cliente`));

# Tabla producto
CREATE TABLE `db_plantacion_manzanas`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `cliente_fk_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `cliente_fk`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_plantacion_manzanas`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    ALTER TABLE `db_plantacion_manzanas`.`producto` 
DROP FOREIGN KEY `cliente_fk`;
ALTER TABLE `db_plantacion_manzanas`.`producto` 
DROP COLUMN `id_cliente`,
DROP INDEX `cliente_fk_idx` ;
;
    
# Tabla produccion
CREATE TABLE `db_plantacion_manzanas`.`produccion` (
  `id_produccion` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_produccion`),
  INDEX `producto_fk_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `producto_fk`
    FOREIGN KEY (`id_producto`)
    REFERENCES `db_plantacion_manzanas`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
# Tabla pedido
CREATE TABLE `db_plantacion_manzanas`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_produccion` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `direccion_pedido` VARCHAR(30) NOT NULL,
  `precio_pedido` DECIMAL NOT NULL,
  `fecha_pedido` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `produccion_fk_idx` (`id_produccion` ASC) VISIBLE,
  INDEX `cliente_fk_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `produccion_fk`
    FOREIGN KEY (`id_produccion`)
    REFERENCES `db_plantacion_manzanas`.`produccion` (`id_produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_pedido_fk`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_plantacion_manzanas`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
# Insertar datos
    
# Ingresar clientes    
INSERT INTO `db_plantacion_manzanas`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Nicolas', 'Mayoral', 'Castelli 315', '2604348538');
INSERT INTO `db_plantacion_manzanas`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Bruno', 'Bobadilla', 'Entre Rios 550', '2604723554');
INSERT INTO `db_plantacion_manzanas`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Julian', 'Castillo', 'Ballofet 1000', '2604775728');

SELECT * FROM cliente;

# Ingresar productos
INSERT INTO `db_plantacion_manzanas`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Manzana', 'Manzana cosechada que supera el tamaño establecido de norma', '50');
INSERT INTO `db_plantacion_manzanas`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Botella de Sidra', 'Botella de 750cc de sidra', '150');
INSERT INTO `db_plantacion_manzanas`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Bolsa de Manzanas', 'Bolsa que contiene doce Manzanas', '600');

SELECT * FROM producto;

# Ingresar producciones
INSERT INTO `db_plantacion_manzanas`.`produccion` (`id_producto`, `cantidad`, `fecha`) VALUES ('1', '5400', current_timestamp());
INSERT INTO `db_plantacion_manzanas`.`produccion` (`id_producto`, `cantidad`, `fecha`) VALUES ('2', '150', current_timestamp());
UPDATE `db_plantacion_manzanas`.`produccion` SET `cantidad` = '3600' WHERE (`id_produccion` = '1');
INSERT INTO `db_plantacion_manzanas`.`produccion` (`id_producto`, `cantidad`, `fecha`) VALUES ('3', '300', current_timestamp());

SELECT * FROM produccion;

# Ingresar pedidos
INSERT INTO `db_plantacion_manzanas`.`pedido` (`id_produccion`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('1', '3', '50', 'Ballofet 1000', '2500', current_timestamp());
INSERT INTO `db_plantacion_manzanas`.`pedido` (`id_produccion`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('3', '2', '1', 'Entre Rios 550', '600', current_timestamp());
INSERT INTO `db_plantacion_manzanas`.`pedido` (`id_produccion`, `id_cliente`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('2', '1', '5', 'Castelli 315', '750', current_timestamp());

SELECT * FROM pedido;

# Consultas

CREATE VIEW Vista_Produccion AS
SELECT
	P.nombre as 'Nombre',
    P.descripcion as 'Descripcion',
    Pr.cantidad as 'Cantidad',
    P.precio as 'Precio',
    Pr.fecha as 'Fecha de produccion'
FROM producto P INNER JOIN produccion Pr ON (P.id_producto = Pr.id_producto)
WHERE Pr.fecha LIKE('2022-07-07%');

CREATE VIEW Vista_Pedidos AS
SELECT
	P.nombre as 'Nombre',
    Pe.cantidad as 'Cantidad',
    Pe.direccion_pedido as 'Direccion',
    Pe.fecha_pedido as 'Fecha de Pedido'
FROM pedido Pe INNER JOIN produccion Pr ON (Pe.id_produccion = Pr.id_produccion)
INNER JOIN producto P ON (Pr.id_producto = P.id_producto)
WHERE fecha_pedido LIKE('2022-07-07%');

CREATE VIEW Vista_Cantidad_Pedidos AS
SELECT
	COUNT(id_pedido) as 'Total Pedidos diarios'
FROM pedido WHERE fecha_pedido LIKE('2022-07-07%');

# Llamo a las vistas
SELECT * FROM Vista_Produccion;
SELECT * FROM Vista_Pedidos;
SELECT * FROM Vista_Cantidad_Pedidos;



