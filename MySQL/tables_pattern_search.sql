USE db_example2;

SELECT * FROM empleados;

# LIKE

# LIKE sirve para buscar un valor en mi tabla de la DB, se usa con WHERE
SELECT * FROM empleados WHERE Nombre LIKE 'Jones';

# Usando LIKE y un INNER JOIN
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE 'Jones';

# Contiene una 'N'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE '%n%';

# Comienza por 'J'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE 'J%';

# Termina por 'S'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE '%s';

# Si su segundo caracter empieza con 'O'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE '_o%';

# Si contiene 5 caracteres
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE '_____';

# Si empieza con 'J' y termina con 'S'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE 'j%' or E.Nombre LIKE '%s';

# Si contiene una 'N' y una 'E'
SELECT
  E.Nombre as 'Empleado',
  D.Nombre as 'Departamento'
FROM Empleados E INNER JOIN Departamentos D ON (E.DepartamentoId = D.Id)
WHERE E.Nombre LIKE '%n%' or E.Nombre LIKE '%e%';

# LIMIT
# Sintaxis consultas SELECT
SELECT 
	D.nombre as 'Departamento', 
	E.nombre as 'Empleado'
FROM Departamentos D, Empleados E LIMIT 5;

