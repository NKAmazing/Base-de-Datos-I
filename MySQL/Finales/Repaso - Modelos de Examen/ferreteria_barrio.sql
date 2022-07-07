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