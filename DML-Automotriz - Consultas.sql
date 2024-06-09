# DML-Automotriz - CONSULTAS

USE automotriz;


#1. Obtener el historial de reparaciones de un vehículo específico

SELECT * FROM reparacion WHERE vehiculo_id = 1;

#2. Calcular el costo total de todas las reparaciones realizadas por un empleado
#    específico en un período de tiempo

SELECT 
	empleado_id AS EMPLEADO,
	SUM(costo_total) AS costo_total_reparaciones
FROM reparacion
WHERE empleado_id = 1
AND fecha BETWEEN '2023-01-01' AND '2023-03-31';

#3. Listar todos los clientes y los vehículos que poseen

SELECT 
	concat(c.nombre, ' ', c.apellido) AS CLIENTE,
    v.modelo AS VEHICULO,
    v.placa AS PLACA
FROM 
	cliente c
INNER JOIN 
	vehiculo v ON c.id = v.cliente_id;
    
#4. Obtener la cantidad de piezas en inventario para cada pieza

SELECT 
	p.nombre AS Pieza,
    i.cantidad AS Cantidad
FROM 
	pieza p
INNER JOIN 
	inventario i ON p.inventario_id = i.id;
    






