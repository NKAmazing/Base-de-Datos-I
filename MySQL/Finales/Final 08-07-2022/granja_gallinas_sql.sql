# Examen Final BD I - Nicolas Mayoral

# Creacion de la Base de datos
CREATE DATABASE db_granja_gallinas;

USE db_granja_gallinas;

# Creacion de Tablas

# Tabla cliente
CREATE TABLE `db_granja_gallinas`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_cliente`));
  
# Tabla producto
CREATE TABLE `db_granja_gallinas`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  `precio_producto` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_producto`));

# Tabla deposito
CREATE TABLE `db_granja_gallinas`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha_ingreso` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `producto_to_deposito_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `producto_to_deposito`
    FOREIGN KEY (`id_producto`)
    REFERENCES `db_granja_gallinas`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
ALTER TABLE `db_granja_gallinas`.`deposito` 
ADD COLUMN `nombre` VARCHAR(45) NOT NULL AFTER `id_producto`;
ALTER TABLE `db_granja_gallinas`.`deposito` 
ADD COLUMN `cantidad_maple` INT NOT NULL AFTER `nombre`,
CHANGE COLUMN `cantidad` `cantidad_huevos` INT NOT NULL ;

# Tabla pedido
CREATE TABLE `db_granja_gallinas`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_deposito` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad_pedido` INT NOT NULL,
  `precio_pedido` DECIMAL(10,2) NOT NULL,
  `direccion_pedido` VARCHAR(30) NOT NULL,
  `fecha_pedido` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `deposito_to_pedido_idx` (`id_deposito` ASC) VISIBLE,
  INDEX `cliente_to_pedido_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `deposito_to_pedido`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `db_granja_gallinas`.`deposito` (`id_deposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_to_pedido`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_granja_gallinas`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Ingreso de datos

# Ingreso de clientes
INSERT INTO `db_granja_gallinas`.`cliente` (`nombre`, `direccion`) VALUES ('Nicolas Mayoral', 'Castelli 315');
INSERT INTO `db_granja_gallinas`.`cliente` (`nombre`, `direccion`) VALUES ('Julian Castillo', 'Ballofet 1000');
INSERT INTO `db_granja_gallinas`.`cliente` (`nombre`, `direccion`) VALUES ('Facundo Caceres', 'Saavedra 288');

SELECT * FROM cliente;

# Ingreso de productos
INSERT INTO `db_granja_gallinas`.`producto` (`nombre_producto`, `descripcion`, `precio_producto`) VALUES ('Huevo blanco', 'Un simple huevo blanco recien recolectado', '40.00');
INSERT INTO `db_granja_gallinas`.`producto` (`nombre_producto`, `descripcion`, `precio_producto`) VALUES ('Huevo amarillo', 'Un simple huevo amarillo recien recolectado', '45.00');

SELECT * FROM producto;

# Ingreso de produccion al deposito
INSERT INTO `db_granja_gallinas`.`deposito` (`id_producto`, `nombre`, `cantidad_maple`, `cantidad_huevos`, `fecha_ingreso`) VALUES ('1', 'Maple de Huevos Blancos', '1', '30', current_timestamp());
INSERT INTO `db_granja_gallinas`.`deposito` (`id_producto`, `nombre`, `cantidad_maple`, `cantidad_huevos`, `fecha_ingreso`) VALUES ('2', 'Maple de Huevos Amarillos', '1', '30', current_timestamp());
INSERT INTO `db_granja_gallinas`.`deposito` (`id_producto`, `nombre`, `cantidad_maple`, `cantidad_huevos`, `fecha_ingreso`) VALUES ('1', 'Maple de Huevos Blancos', '2', '60', current_timestamp());

SELECT * FROM deposito;

# Ingreso de pedidos
INSERT INTO `db_granja_gallinas`.`pedido` (`id_deposito`, `id_cliente`, `cantidad_pedido`, `precio_pedido`, `direccion_pedido`, `fecha_pedido`) VALUES ('1', '1', (select cantidad_maple from deposito where id_deposito = 1), (select 40.00*cantidad_huevos from deposito where id_deposito = 1), (select direccion from cliente where id_cliente = 1), current_timestamp());
INSERT INTO `db_granja_gallinas`.`pedido` (`id_deposito`, `id_cliente`, `cantidad_pedido`, `precio_pedido`, `direccion_pedido`, `fecha_pedido`) VALUES ('2', '2', (select cantidad_maple from deposito where id_deposito = 2), (select 45.00*cantidad_huevos from deposito where id_deposito = 2), (select direccion from cliente where id_cliente = 2), current_timestamp());
INSERT INTO `db_granja_gallinas`.`pedido` (`id_deposito`, `id_cliente`, `cantidad_pedido`, `precio_pedido`, `direccion_pedido`, `fecha_pedido`) VALUES ('3', '3', (select cantidad_maple from deposito where id_deposito = 3), (select 40.00*cantidad_huevos from deposito where id_deposito = 3), (select direccion from cliente where id_cliente = 3), current_timestamp());

SELECT * FROM pedido;

# Consultas

# Produccion diaria
SELECT
	D.nombre as 'Nombre',
    D.cantidad_maple as 'Cantidad',
    D.cantidad_huevos as 'Cantidad de Huevos',
    P.precio_producto as 'Precio Huevo Individual',
    P.precio_producto*D.cantidad_huevos as 'Precio total lote',
    D.fecha_ingreso as 'Fecha de producción'
FROM deposito D INNER JOIN producto P ON (D.id_producto = P.id_producto) WHERE D.fecha_ingreso LIKE('2022-07-08%');

# Pedidos diarios
SELECT
	C.nombre as 'Nombre Cliente',
    D.nombre as 'Nombre Producto',
    D.cantidad_maple as 'Cantidad',
    Pe.direccion_pedido as 'Direccion de destino',
    Pe.fecha_pedido as 'Fecha de Pedido',
    Pe.precio_pedido as 'Precio Total Pedido'
FROM pedido Pe INNER JOIN cliente C ON (Pe.id_cliente = C.id_cliente)
INNER JOIN deposito D ON (Pe.id_deposito = D.id_deposito) WHERE Pe.fecha_pedido LIKE('2022-07-08%');


