CREATE DATABASE db_example3;

USE db_example3;

CREATE TABLE `db_example3`.`client` (
  `id_client` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_client`));

CREATE TABLE `db_example3`.`product` (
  `id_product` INT NOT NULL,
  `nombre_producto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_product`));
  ALTER TABLE `db_example3`.`client` 
CHANGE COLUMN `id_client` `id_client` INT NOT NULL AUTO_INCREMENT ,
CHANGE COLUMN `nombre` `nombre` VARCHAR(45) NOT NULL ;

CREATE TABLE `db_example3`.`purchase` (
  `id_purchase` INT NOT NULL,
  `id_client` INT NOT NULL,
  `id_product` INT NOT NULL,
  PRIMARY KEY (`id_purchase`),
  INDEX `cliente-compra_idx` (`id_client` ASC) VISIBLE,
  INDEX `producto-compra_idx` (`id_product` ASC) VISIBLE,
  CONSTRAINT `cliente-compra`
    FOREIGN KEY (`id_client`)
    REFERENCES `db_example3`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `producto-compra`
    FOREIGN KEY (`id_product`)
    REFERENCES `db_example3`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `db_example3`.`client` (`id_client`, `nombre`) VALUES ('1', 'nicolas');
INSERT INTO `db_example3`.`client` (`id_client`, `nombre`) VALUES ('2', 'alexis');

INSERT INTO `db_example3`.`product` (`id_product`, `nombre_producto`) VALUES ('1', 'cartas');
INSERT INTO `db_example3`.`product` (`id_product`, `nombre_producto`) VALUES ('2', 'placa de video');

SELECT * FROM client;
SELECT * FROM product;

INSERT INTO `db_example3`.`purchase` (`id_purchase`, `id_client`, `id_product`) VALUES ('1', '2', '1');
INSERT INTO `db_example3`.`purchase` (`id_purchase`, `id_client`, `id_product`) VALUES ('2', '1', '1');
INSERT INTO `db_example3`.`purchase` (`id_purchase`, `id_client`, `id_product`) VALUES ('3', '2', '2');
INSERT INTO `db_example3`.`purchase` (`id_purchase`, `id_client`, `id_product`) VALUES ('4', '1', '2');

# Sub consulta join
SELECT C.nombre as "Nombre cliente",
		P.nombre_producto as "Producto"
FROM purchase Pu INNER JOIN client C ON (Pu.id_client = C.id_client) INNER JOIN product P ON (Pu.id_product = P.id_product);

# Creacion de vista
CREATE VIEW ComprasCliente AS 
SELECT C.nombre as "Nombre cliente",
		P.nombre_producto as "Producto"
FROM purchase Pu INNER JOIN client C ON (Pu.id_client = C.id_client) INNER JOIN product P ON (Pu.id_product = P.id_product);

# Llamar a la vista
SELECT * FROM ComprasCliente;