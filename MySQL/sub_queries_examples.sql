# SUB CONSULTAS

USE db_example2;

SELECT * FROM empleados;

SELECT * FROM departamentos;

SELECT * FROM departamentos WHERE Id IN (SELECT DepartamentoId FROM empleados);