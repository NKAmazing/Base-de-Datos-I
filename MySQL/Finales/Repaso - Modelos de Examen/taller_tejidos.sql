CREATE DATABASE db_taller_tejidos;

USE db_taller_tejidos;

CREATE TABLE `db_taller_tejidos`.`pieza` (
  `id_pieza` INT NOT NULL AUTO_INCREMENT,
  `tipo_pieza` VARCHAR(45) NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_pieza`));
  ALTER TABLE `db_taller_tejidos`.`pieza` 
ADD COLUMN `cantidad_falladas` INT NOT NULL AFTER `cantidad_aprobadas`,
ADD COLUMN `fecha_produccion` TIMESTAMP NOT NULL AFTER `cantidad_falladas`,
CHANGE COLUMN `cantidad` `cantidad_aprobadas` INT NOT NULL ;
ALTER TABLE `db_taller_tejidos`.`pieza` 
CHANGE COLUMN `id_pieza` `id_pieza` INT NOT NULL , RENAME TO  `db_taller_tejidos`.`almacen_piezas` ;
ALTER TABLE `db_taller_tejidos`.`almacen_piezas` 
CHANGE COLUMN `id_pieza` `id_pieza` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE `db_taller_tejidos`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_pieza` INT NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `tipo_material` VARCHAR(45) NOT NULL,
  `talle` VARCHAR(30) NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  `precio_producto` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `pieza_producto_idx` (`id_pieza` ASC) VISIBLE,
  CONSTRAINT `pieza_producto`
    FOREIGN KEY (`id_pieza`)
    REFERENCES `db_taller_tejidos`.`almacen_piezas` (`id_pieza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `db_taller_tejidos`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `cantidad_prendas` INT NOT NULL,
  `nro_lote` INT NOT NULL,
  `fecha_ingreso` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `producto_deposito_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `producto_deposito`
    FOREIGN KEY (`id_producto`)
    REFERENCES `db_taller_tejidos`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
# Insertions

# Ingreso de piezas
INSERT INTO `db_taller_tejidos`.`pieza` (`tipo_pieza`, `cantidad`) VALUES ('espalda', '50');
INSERT INTO `db_taller_tejidos`.`pieza` (`tipo_pieza`, `cantidad`) VALUES ('frente', '50');
INSERT INTO `db_taller_tejidos`.`pieza` (`tipo_pieza`, `cantidad`) VALUES ('manga', '100');
INSERT INTO `db_taller_tejidos`.`pieza` (`tipo_pieza`, `cantidad`) VALUES ('cuello', '50');
INSERT INTO `db_taller_tejidos`.`pieza` (`tipo_pieza`, `cantidad`) VALUES ('puño', '100');
UPDATE `db_taller_tejidos`.`pieza` SET `cantidad_falladas` = '10', `fecha_produccion` = current_timestamp() WHERE (`id_pieza` = '1');
UPDATE `db_taller_tejidos`.`pieza` SET `cantidad_falladas` = '10', `fecha_produccion` = current_timestamp() WHERE (`id_pieza` = '2');
UPDATE `db_taller_tejidos`.`pieza` SET `cantidad_falladas` = '20', `fecha_produccion` = current_timestamp() WHERE (`id_pieza` = '3');
UPDATE `db_taller_tejidos`.`pieza` SET `cantidad_falladas` = '10', `fecha_produccion` = current_timestamp() WHERE (`id_pieza` = '4');
UPDATE `db_taller_tejidos`.`pieza` SET `cantidad_falladas` = '20', `fecha_produccion` = current_timestamp() WHERE (`id_pieza` = '5');

SELECT * FROM pieza;

# Ingreso producto

  