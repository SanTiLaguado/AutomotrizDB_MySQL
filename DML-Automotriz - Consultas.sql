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
	p.nombre AS PIEZA,
    i.stock_actual AS CANTIDAD
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
	p.nombre AS PIEZA,
    i.stock_actual AS CANTIDAD
FROM 
	pieza p
INNER JOIN 
	inventario i ON p.inventario_id = i.id
WHERE
	i.stock_actual <= 50;
    
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
		ci.cliente_id
	FROM cita ci WHERE ci.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    );

#17. Obtener las ganancias totales del taller en un período específico

SELECT SUM(total) AS TOTAL_GANANCIAS FROM pago;

#18. Listar los empleados y el total de horas trabajadas en reparaciones en un
#     período específico (asumiendo que se registra la duración de cada reparación)

SELECT 
	e.id AS ID_EMPLEADO,
    CONCAT(e.nombre, ' ', e.apellido) AS NOMBRE,
	r.duracion AS CANTIDAD_HORAS
FROM reparacion r
INNER JOIN 
	empleado e ON r.empleado_id = e.id
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY r.id
ORDER BY CANTIDAD_HORAS DESC;

# 19. Obtener el listado de servicios prestados por cada empleado en un período
#     específico

SELECT 
	CONCAT(e.nombre, ' ', e.apellido) AS EMPLEADO,
	s.nombre AS SERVICIOS
FROM 
	servicio s
INNER JOIN 
	reparacion_servicio rs ON s.id = rs.servicio_id
INNER JOIN
	reparacion r ON rs.reparacion_id = r.id
INNER JOIN
	empleado e ON r.empleado_id = e.id
WHERE
	r.fecha BETWEEN '2023-01-01' AND '2023-03-31'
ORDER BY EMPLEADO DESC;


## SUBCONSULTAS

# 1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

SELECT 
    c.id AS ID_CLIENTE,
    CONCAT(c.nombre, ' ', c.apellido) AS CLIENTE,
    SUM(r.costo_total) AS COSTO_TOTAL_EN_REPARACIONES
FROM reparacion r
INNER JOIN 
    vehiculo v ON r.vehiculo_id = v.id
INNER JOIN
    cliente c ON v.cliente_id = c.id
WHERE r.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.id, c.nombre, c.apellido
ORDER BY COSTO_TOTAL_EN_REPARACIONES DESC
LIMIT 1;

#2. Obtener la pieza más utilizada en reparaciones durante el último mes

SELECT
	p.id AS PIEZA_ID,
    p.nombre AS PIEZA,
    COUNT(rp.pieza_id) AS VECES_USADA
FROM
	pieza p
INNER JOIN
	reparacion_piezas rp ON p.id = rp.pieza_id
INNER JOIN
	reparacion r ON rp.reparacion_id = r.id
WHERE
	r.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY
	p.id
LIMIT 1;

#3. Obtener los proveedores que suministran las piezas más caras

SELECT 
	p.id AS ID,
	p.nombre AS NOMBRE
FROM proveedor p
INNER JOIN
	precio pr ON p.id = pr.proveedor_id
WHERE pr.precio_proveedor = (
	SELECT MAX(precio_proveedor) FROM precio
);

#4. Listar las reparaciones que no utilizaron piezas específicas durante
#   el último año

SELECT * FROM reparacion r
WHERE
	r.fecha >= date_sub(curdate(), INTERVAL 1 YEAR)
AND r.id NOT IN (
	SELECT rp.reparacion_id
    FROM reparacion_piezas rp
    WHERE rp.pieza_id IN (1, 3)
    );
    
#5. Obtener las piezas que están en inventario 
#   por debajo del 10% del stock inicial

SELECT
	p.id AS ID,
    p.nombre AS NOMBRE,
    i.stock_actual AS STOCK_ACTUAL,
    i.stock_inicial AS STOCK_INICIAL
FROM pieza p
INNER JOIN
	inventario i ON p.inventario_id = i.id
WHERE i.stock_actual <= (
	SELECT stock_inicial*0.1
    FROM inventario
    WHERE id = p.inventario_id
);




