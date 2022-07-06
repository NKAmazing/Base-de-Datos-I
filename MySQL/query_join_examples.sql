use db_example;

CREATE TABLE `db_example`.`empleados` (
  `id_dpto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dpto`));

CREATE TABLE `db_example`.`departamentos` (
  `id_dpto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dpto`),
  CONSTRAINT `coneccion id_dpto`
    FOREIGN KEY (`id_dpto`)
    REFERENCES `db_example`.`empleados` (`id_dpto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO empleados
values
	(31, 'Rafferty'),
    (33, 'Jones'),
    (34, 'Smith'),
    (35, 'Williams');

INSERT INTO departamentos
values
	(31, 'Sales'),
    (33, 'Engineering'),
    (34, 'Clerical'),
    (35, 'Marketing');
    
SELECT * FROM empleados;

SELECT * FROM departamentos;

SELECT * FROM empleados e inner join departamentos d on (e.id_dpto = d.id_dpto);

# Inner Join
SELECT
	e.nombre as 'Empleado',
    d.nombre as 'Departamento'
FROM empleados e inner join departamentos d on (e.id_dpto = d.id_dpto);

# En este caso left y right join no sirven porque tengo variables NOT NULL en la tabla

# Left Join - Si hay un valor nulo en la columna derecha, igualmente lo trae si o si al valor izquierdo
SELECT
	e.nombre as 'Empleado',
    d.nombre as 'Departamento'
FROM empleados e left join departamentos d on (e.id_dpto = d.id_dpto);

# Right Join - Si hay un valor nulo en la columna izquierda, igualmente lo trae si o si al valor derecho
SELECT
	e.nombre as 'Empleado',
    d.nombre as 'Departamento'
FROM empleados e right join departamentos d on (e.id_dpto = d.id_dpto);
