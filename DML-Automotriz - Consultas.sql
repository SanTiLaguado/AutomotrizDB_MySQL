# DML-Automotriz - CONSULTAS

USE automotriz;


#1. Obtener el historial de reparaciones de un vehículo específico

SELECT * FROM reparacion WHERE vehiculo_id = 1;

#2. Calcular el costo total de todas las reparaciones realizadas por un empleado
#    específico en un período de tiempo

SELECT 
	empleado_id AS EMPLEADO,
	SUM(costo_total) AS COSTO_TOTAL_DE_REPARACIONES
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
    
#5. Obtener las citas programadas para un día específico

SELECT * FROM cita c WHERE DATE(fecha_hora) = '2023-01-10';

#6. Generar una factura para un cliente específico en una fecha determinada

SELECT * FROM factura f 
WHERE f.cliente_id = 2 AND DATE(fecha) = '2023-02-17';

#7. Listar todas las órdenes de compra y sus detalles

SELECT 
	oc.id AS ID,
	oc.fecha AS FECHA,
    oc.empleado_id AS EMPLEADO,
    oc.proveedor_id AS PROOVEDOR,
    od.pieza_id AS PIEZA,
    od.cantidad AS CANT
FROM
	orden_compra oc
INNER JOIN orden_detalle od ON oc.id = od.orden_id;

#8. Obtener el costo total de piezas utilizadas en una reparación específica


SELECT 
    r.id AS ID_REPARACION,
	rp.pieza_id AS ID_PIEZA,
    pv.precio_venta AS PRECIO_UND,
    rp.cantidad AS CANT,
    SUM(pv.precio_venta * rp.cantidad) AS TOTAL
FROM 
    reparacion r
INNER JOIN 
    reparacion_piezas rp ON r.id = rp.reparacion_id
INNER JOIN 
    pieza p ON rp.pieza_id = p.id
INNER JOIN 
	precio pv ON p.id = pv.pieza_id
WHERE 
    r.id = 3
GROUP BY
	r.id, rp.pieza_id, pv.precio_venta;

# 9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
#  menor que un umbral)

SELECT 
	p.nombre AS Pieza,
    i.cantidad AS Cantidad
FROM 
	pieza p
INNER JOIN 
	inventario i ON p.inventario_id = i.id
WHERE
	i.cantidad <= 50;
    
#10. Obtener la lista de servicios más solicitados en un período específico

SELECT 
	s.nombre AS SERVICIO,
    COUNT(cs.servicio_id) AS CANTIDAD
FROM servicio s
INNER JOIN
	cita_servicio cs ON s.id = cs.servicio_id
INNER JOIN
	cita c ON cs.cita_id = c.id
WHERE c.fecha_hora BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY s.nombre
ORDER BY CANTIDAD DESC;

#11. Obtener el costo total de reparaciones para cada cliente en un 
#    período específico

SELECT 
	c.id AS ID_CLIENTE,
    concat(c.nombre, ' ', c.apellido) AS CLIENTE,
	SUM(costo_total) AS COSTO_TOTAL_EN_REPARACIONES
FROM reparacion r
INNER JOIN 
	vehiculo v ON r.vehiculo_id = v.id
INNER JOIN
	cliente c ON v.cliente_id = c.id
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY c.id;

#12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
#    período específico

SELECT 
	e.id AS ID_EMPLEADO,
    CONCAT(e.nombre, ' ', e.apellido) AS NOMBRE,
	COUNT(r.id) AS CANTIDAD_REPARACIONES
FROM reparacion r
INNER JOIN 
	empleado e ON r.empleado_id = e.id
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY e.id
ORDER BY CANTIDAD_REPARACIONES DESC;

#13. Obtener las piezas más utilizadas en reparaciones durante un período
#	 específico

SELECT 
    r.id AS ID_REP,
    r.fecha AS FECHA_REP,
	rp.pieza_id AS ID_PIEZA,
    p.nombre AS PIEZA,
	COUNT(rp.pieza_id) AS VECES_USADA
FROM 
    reparacion r
INNER JOIN 
    reparacion_piezas rp ON r.id = rp.reparacion_id
INNER JOIN 
    pieza p ON rp.pieza_id = p.id
WHERE r.fecha BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY
	r.id, rp.pieza_id;

#14. Calcular el promedio de costo de reparaciones por vehículo

SELECT 
	v.modelo AS VEHICULO,
    AVG(r.costo_total) AS PROMEDIO_COSTO
FROM 
	vehiculo v
INNER JOIN 
	reparacion r ON v.id = r.vehiculo_id
GROUP BY v.modelo;

#15. Obtener el inventario de piezas por proveedor

SELECT 
	pvd.nombre AS PROVEEDOR,
	p.nombre AS Pieza,
    i.cantidad AS Cantidad
FROM 
	pieza p
INNER JOIN 
	precio pr ON p.id = pr.pieza_id
INNER JOIN
	proveedor pvd ON pr.proveedor_id = pvd.id
INNER JOIN 
	inventario i ON p.inventario_id = i.id;
    
#16. Listar los clientes que no han realizado reparaciones en el último año

SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS CLIENTE
FROM cliente c
WHERE c.id NOT IN (
	SELECT
		v.cliente_id
	FROM vehiculo v
    LEFT JOIN
		reparacion r ON v.id = r.vehiculo_id
	WHERE 
		r.fecha >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
);

#17. Obtener las ganancias totales del taller en un período específico

SELECT SUM(total) AS TOTAL_GANANCIAS
FROM pago WHERE




