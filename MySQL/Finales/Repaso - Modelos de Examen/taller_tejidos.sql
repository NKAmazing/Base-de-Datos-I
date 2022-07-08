CREATE DATABASE db_taller_tejidos;

USE db_taller_tejidos;

CREATE TABLE `db_taller_tejidos`.`pieza` (
  `id_pieza` INT NOT NULL AUTO_INCREMENT,
  `tipo_pieza` VARCHAR(45) NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_pieza`));
  
  