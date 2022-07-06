USE db_example2;

# Creo 2 tablas con variables que pueden ser nulas
CREATE TABLE Departamentos
(
    Id int,
    Nombre varchar(20)
);

CREATE TABLE Empleados
(
    Nombre varchar(20),
    DepartamentoId int
);

# Inserto valores a la tabla dptos
INSERT INTO Departamentos VALUES(31, 'Sales');
INSERT INTO Departamentos VALUES(33, 'Engineering');
INSERT INTO Departamentos VALUES(34, 'Clerical');
INSERT INTO Departamentos VALUES(35, 'Marketing');

# Inserto valores a la tabla empleados
INSERT INTO Empleados VALUES('Rafferty', 31);
INSERT INTO Empleados VALUES('Jones', 33);
INSERT INTO Empleados VALUES('Heisenberg', 33);
INSERT INTO Empleados VALUES('Robinson', 34);
INSERT INTO Empleados VALUES('Smith', 34);
INSERT INTO Empleados VALUES('Williams', NULL);

# Hago una primera consulta para ver las tablas
SELECT * FROM Empleados;
SELECT * FROM Departamentos;

# INNER JOIN

# Utilizo un Inner Join para traer todos los datos de la interseccion entre las dos tablas
SELECT * FROM Empleados E JOIN Departamentos D ON (E.DepartamentoId = D.Id);

# Utilizo un Inner Join para mostrar solo 2 columnas que son las que contienen la informacion
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id);

# LEFT JOIN
# Se muestran TODOS los datos de la tabla de la IZQUIERDA
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E LEFT JOIN Departamentos D ON (E.DepartamentoId = D.Id);
# En la tabla de la derecha si se encuentra coincidencia apareceran, sino, aparecera NULL

# RIGHT JOIN
# Se muestran TODOS los datos de la tabla de la DERECHA
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E RIGHT JOIN Departamentos D ON (E.DepartamentoId = D.Id);
# En la tabla de la izquierda si se encuentra coincidencia apareceran, sino, aparecera NULL

# FULL JOIN
# Muestra TODAS las filas de AMBAS tablas
# No lo tengo en MySQL pero puedo hacer UNION de un LEFT y un RIGHT
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E LEFT JOIN Departamentos D ON (E.DepartamentoId = D.Id)
UNION
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E RIGHT JOIN Departamentos D ON (E.DepartamentoId = D.Id);


