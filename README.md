# Proyecto MySQL - AutomotrizDB

**CONSULTAS**



1. **Obtener el historial de reparaciones de un vehículo específico**

   ```mysql
   		SELECT
       ->     fecha AS FECHA,
       ->     duracion AS DURACION,
       ->     costo_total AS TOTAL,
       ->     descripcion AS DESCRIPCION
       ->  FROM reparacion WHERE vehiculo_id = 1;
   +------------+----------+--------+----------------------------+
   | FECHA      | DURACION | TOTAL  | DESCRIPCION                |
   +------------+----------+--------+----------------------------+
   | 2023-01-15 |        3 | 200.00 | Revisión general           |
   | 2024-05-20 |        3 | 220.00 | Cambio de filtro de aceite |
   +------------+----------+--------+----------------------------+
   ```

   Se seleccionan las columnas `fecha`, `duracion`, `costo_total`,  y `descripcion` de la tabla `reparacion` donde el `vehiculo_id` es 1. Esto proporciona el historial completo de reparaciones para ese vehículo específico.
   

2. **Calcular el costo total de todas las reparaciones realizadas por un empleado específico en un período de tiempo**

  ```mysql
  	   SELECT
      ->    empleado_id AS EMPLEADO,
      ->    SUM(costo_total) AS COSTO_TOTAL_DE_REPARACIONES
      -> FROM reparacion
      -> WHERE empleado_id = 1
      -> AND fecha BETWEEN '2023-01-01' AND '2023-03-31';
  +----------+-----------------------------+
  | EMPLEADO | COSTO_TOTAL_DE_REPARACIONES |
  +----------+-----------------------------+
  |        1 |                      200.00 |
  +----------+-----------------------------+
  ```

  Se selecciona el `empleado_id` y se calcula la suma de `costo_total` de las reparaciones realizadas por el empleado con id 1 dentro del rango de fechas especificado.
  

3. **Listar todos los clientes y los vehículos que poseen**

   ```mysql
   	-> SELECT
       ->  concat(c.nombre, ' ', c.apellido) AS CLIENTE,
       ->     v.modelo AS VEHICULO,
       ->     v.placa AS PLACA
       -> FROM
       ->  cliente c
       -> INNER JOIN
       ->  vehiculo v ON c.id = v.cliente_id;
   +----------------+----------+--------+
   | CLIENTE        | VEHICULO | PLACA  |
   +----------------+----------+--------+
   | Juan Pérez     | Corolla  | ABC123 |
   | Ana Gómez      | Civic    | DEF456 |
   | Luis Martínez  | Focus    | GHI789 |
   +----------------+----------+--------+
   ```

​	Se realiza un `INNER JOIN` entre las tablas `cliente` y `vehiculo` para obtener los nombres completos de los clientes y los detalles de sus vehículos.


4. **Obtener la cantidad de piezas en inventario para cada pieza**

   ```mysql
   	-> SELECT
       ->  p.nombre AS PIEZA,
       ->     i.stock_actual AS CANTIDAD
       -> FROM
       ->  pieza p
       -> INNER JOIN
       ->  inventario i ON p.inventario_id = i.id;
   +-------------------+----------+
   | PIEZA             | CANTIDAD |
   +-------------------+----------+
   | Filtro de aceite  |      175 |
   | Bujía             |       48 |
   | Pastilla de freno |       32 |
   +-------------------+----------+
   ```

   Se realiza un `INNER JOIN` entre las tablas `pieza` e `inventario` para obtener el nombre de la pieza y su cantidad actual en inventario.
   

5. **Obtener las citas programadas para un día específico**

   ```mysql
   	-> SELECT * FROM cita c WHERE DATE(fecha_hora) = '2023-01-10';
   +----+---------------------+------------+-------------+
   | id | fecha_hora          | cliente_id | vehiculo_id |
   +----+---------------------+------------+-------------+
   |  1 | 2023-01-10 10:00:00 |          1 |           1 |
   +----+---------------------+------------+-------------+
   ```

   Se seleccionan todas las columnas de la tabla `cita` donde la fecha es el 10 de enero de 2023.

6. **Generar una factura para un cliente específico en una fecha determinada**

   ```mysql
   	-> SELECT * FROM factura f
       -> WHERE f.cliente_id = 2 AND DATE(fecha) = '2023-02-17';
   +----+------------+------------+--------+
   | id | fecha      | cliente_id | total  |
   +----+------------+------------+--------+
   |  2 | 2023-02-17 |          2 | 300.00 |
   +----+------------+------------+--------+
   ```

   Se seleccionan todas las facturas emitidas al cliente específico (`cliente_id = 2`) en una fecha determinada (17 de febrero de 2023), utilizando la función `DATE` para comparar la fecha.
   

7. **Listar todas las órdenes de compra y sus detalles**

   ```mysql
   	->	SELECT
       ->  oc.id AS ID,
       ->  oc.fecha AS FECHA,
       ->     oc.empleado_id AS EMPLEADO,
       ->     oc.proveedor_id AS PROOVEDOR,
       ->     od.pieza_id AS PIEZA,
       ->     od.cantidad AS CANT
       -> FROM
       ->  orden_compra oc
       -> INNER JOIN orden_detalle od ON oc.id = od.orden_id;
   +----+------------+----------+-----------+-------+------+
   | ID | FECHA      | EMPLEADO | PROOVEDOR | PIEZA | CANT |
   +----+------------+----------+-----------+-------+------+
   |  1 | 2023-01-01 |        1 |         1 |     1 |   10 |
   |  2 | 2023-02-02 |        2 |         2 |     2 |   20 |
   |  3 | 2023-03-03 |        3 |         3 |     3 |   30 |
   +----+------------+----------+-----------+-------+------+
   ```

   Se realiza un `INNER JOIN` entre las tablas `orden_compra` y `orden_detalle` para obtener todos los detalles de cada orden de compra.
   

8. **Obtener el costo total de piezas utilizadas en una reparación específica**

   ```mysql
   	-> SELECT
       ->     r.id AS ID_REPARACION,
       ->  rp.pieza_id AS ID_PIEZA,
       ->     pv.precio_venta AS PRECIO_UND,
       ->     rp.cantidad AS CANT,
       ->     SUM(pv.precio_venta * rp.cantidad) AS TOTAL
       -> FROM
       ->     reparacion r
       -> INNER JOIN
       ->     reparacion_piezas rp ON r.id = rp.reparacion_id
       -> INNER JOIN
       ->     pieza p ON rp.pieza_id = p.id
       -> INNER JOIN
       ->  precio pv ON p.id = pv.pieza_id
       -> WHERE
       ->     r.id = 3
       -> GROUP BY
       ->  r.id, rp.pieza_id, pv.precio_venta;
   +---------------+----------+------------+------+-------+
   | ID_REPARACION | ID_PIEZA | PRECIO_UND | CANT | TOTAL |
   +---------------+----------+------------+------+-------+
   |             3 |        3 |      30.00 |    3 | 90.00 |
   +---------------+----------+------------+------+-------+
   ```

   Se seleccionan los detalles de las piezas utilizadas en la reparación con `reparacion_id = 3` y se calcula el costo total sumando el precio unitario multiplicado por la cantidad de cada pieza.
   

9. **Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad menor que un umbral)**

  ```mysql
  	-> SELECT
      ->  p.nombre AS PIEZA,
      ->  i.stock_actual AS CANTIDAD
      -> FROM
      ->  pieza p
      -> INNER JOIN
      ->  inventario i ON p.inventario_id = i.id
      -> WHERE
      ->  i.stock_actual <= 50;
  +-------------------+----------+
  | PIEZA             | CANTIDAD |
  +-------------------+----------+
  | Bujía             |       48 |
  | Pastilla de freno |       32 |
  +-------------------+----------+
  ```

  Se combinan las tablas `pieza` e `inventario` para seleccionar las piezas cuyo stock actual es menor o igual a 50. 
  

10. **Obtener la lista de servicios más solicitados en un período específico**

    ```mysql
    	-> SELECT
        ->  s.nombre AS SERVICIO,
        ->  COUNT(cs.servicio_id) AS CANTIDAD
        -> FROM servicio s
        -> INNER JOIN
        ->  cita_servicio cs ON s.id = cs.servicio_id
        -> INNER JOIN
        ->  cita c ON cs.cita_id = c.id
        -> WHERE c.fecha_hora BETWEEN '2023-01-01' AND '2023-03-31'
        -> GROUP BY s.nombre
        -> ORDER BY CANTIDAD DESC;
    +---------------------+----------+
    | SERVICIO            | CANTIDAD |
    +---------------------+----------+
    | Cambio de aceite    |        1 |
    | Alineación          |        1 |
    | Revisión de frenos  |        1 |
    +---------------------+----------+
    ```

    Se cuenta la cantidad de veces que cada servicio fue solicitado en citas dentro del período especificado y se ordena la lista de servicios por cantidad de solicitudes en orden descendente. En este caso, cada servicio se ha solicitado 1 vez en el periodo seleccionado
    

11. **Obtener el costo total de reparaciones para cada cliente en un período específico**

    ```mysql
    	-> SELECT
        ->  c.id AS ID_CLIENTE,
        ->  concat(c.nombre, ' ', c.apellido) AS CLIENTE,
        ->  SUM(costo_total) AS COSTO_TOTAL_EN_REPARACIONES
        -> FROM reparacion r
        -> INNER JOIN
        ->  vehiculo v ON r.vehiculo_id = v.id
        -> INNER JOIN
        ->  cliente c ON v.cliente_id = c.id
        -> WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
        -> GROUP BY c.id;
    +------------+----------------+-----------------------------+
    | ID_CLIENTE | CLIENTE        | COSTO_TOTAL_EN_REPARACIONES |
    +------------+----------------+-----------------------------+
    |          1 | Juan Pérez     |                      200.00 |
    |          2 | Ana Gómez      |                      300.00 |
    |          3 | Luis Martínez  |                      150.00 |
    +------------+----------------+-----------------------------+
    ```

    Se suman los costos totales de reparaciones asociadas a los vehículos de cada cliente dentro del período especificado. Esto proporciona el gasto total en reparaciones por cliente.

12. **Listar los empleados con mayor cantidad de reparaciones realizadas en un período específico**

    ```mysql
    	-> SELECT
        ->  e.id AS ID_EMPLEADO,
        ->  CONCAT(e.nombre, ' ', e.apellido) AS NOMBRE,
        ->  COUNT(r.id) AS CANTIDAD_REPARACIONES
        -> FROM reparacion r
        -> INNER JOIN
        ->  empleado e ON r.empleado_id = e.id
        -> WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
        -> GROUP BY e.id
        -> ORDER BY CANTIDAD_REPARACIONES DESC;
    +-------------+-------------------+-----------------------+
    | ID_EMPLEADO | NOMBRE            | CANTIDAD_REPARACIONES |
    +-------------+-------------------+-----------------------+
    |           1 | Pedro Martínez    |                     1 |
    |           2 | Lucía Hernández   |                     1 |
    |           3 | José Fernández    |                     1 |
    +-------------+-------------------+-----------------------+
    ```

    Se cuenta el número de reparaciones realizadas por cada empleado dentro del período especificado y se ordena la lista de empleados por cantidad de reparaciones en orden descendente.
    

13. **Obtener las piezas más utilizadas en reparaciones durante un período específico**

    ```mysql
    	-> SELECT
        ->     r.id AS ID_REP,
        ->     r.fecha AS FECHA_REP,
        ->     rp.pieza_id AS ID_PIEZA,
        ->     p.nombre AS PIEZA,
        ->  COUNT(rp.pieza_id) AS VECES_USADA
        -> FROM
        ->     reparacion r
        -> INNER JOIN
        ->     reparacion_piezas rp ON r.id = rp.reparacion_id
        -> INNER JOIN
        ->     pieza p ON rp.pieza_id = p.id
        -> WHERE r.fecha BETWEEN '2023-01-01' AND '2023-03-31'
        -> GROUP BY
        ->  r.id, rp.pieza_id
        -> ORDER BY
        ->  VECES_USADA DESC;
    +--------+------------+----------+-------------------+-------------+
    | ID_REP | FECHA_REP  | ID_PIEZA | PIEZA             | VECES_USADA |
    +--------+------------+----------+-------------------+-------------+
    |      1 | 2023-01-15 |        1 | Filtro de aceite  |           1 |
    |      2 | 2023-02-20 |        2 | Bujía             |           1 |
    |      3 | 2023-03-10 |        3 | Pastilla de freno |           1 |
    +--------+------------+----------+-------------------+-------------+
    ```

    Se cuenta cuántas veces cada pieza fue utilizada en reparaciones dentro del período especificado. Igualmente en este caso cada pieza se ha utilizado 1 vez en el periodo seleccionado.
    

14. **Calcular el promedio de costo de reparaciones por vehículo**

    ```mysql
    	-> SELECT
        ->  v.modelo AS VEHICULO,
        ->  AVG(r.costo_total) AS PROMEDIO_COSTO
        -> FROM
        ->  vehiculo v
        -> INNER JOIN
        ->  reparacion r ON v.id = r.vehiculo_id
        -> GROUP BY v.modelo;
    +----------+----------------+
    | VEHICULO | PROMEDIO_COSTO |
    +----------+----------------+
    | Corolla  |     210.000000 |
    | Civic    |     200.000000 |
    | Focus    |     150.000000 |
    +----------+----------------+
    ```

    Utilizando la función `AVG`  se calcula el costo promedio de las reparaciones asociadas a cada modelo de vehículo que se ha reparado en el taller.
    

15. **Obtener el inventario de piezas por proveedor**

    ```mysql
    	-> SELECT
        ->  pvd.nombre AS PROVEEDOR,
        ->  p.nombre AS PIEZA,
        ->  i.stock_actual AS CANTIDAD
        -> FROM
        ->  pieza p
        -> INNER JOIN
        ->  precio pr ON p.id = pr.pieza_id
        -> INNER JOIN
        ->  proveedor pvd ON pr.proveedor_id = pvd.id
        -> INNER JOIN
        ->  inventario i ON p.inventario_id = i.id;
    +------------+-------------------+----------+
    | PROVEEDOR  | PIEZA             | CANTIDAD |
    +------------+-------------------+----------+
    | Proveedor1 | Filtro de aceite  |      175 |
    | Proveedor2 | Bujía             |       48 |
    | Proveedor3 | Pastilla de freno |       32 |
    +------------+-------------------+----------+
    ```

    Se combinan las tablas `proveedores` ,  `piezas`, `precios`  e `inventario` para obtener la cantidad de piezas en inventario suministradas por cada proveedor.
    

16. **Listar los clientes que no han realizado reparaciones en el último año**

    ```mysql
    	-> SELECT
        ->  CONCAT(c.nombre, ' ', c.apellido) AS CLIENTE
        -> FROM cliente c
        -> WHERE c.id NOT IN (
        ->  SELECT
        ->   ci.cliente_id
        ->  FROM cita ci WHERE ci.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
        ->  );
    +-----------------------+
    | CLIENTE               |
    +-----------------------+
    | Luis Martínez         |
    | Maria Fernanda Araque |
    +-----------------------+
    ```

    Se seleccionan los clientes que no tienen citas registradas en el último año, ya que si no han agendado una cita, por consiguiente no han realizado ninguna reparación.
    

17. **Obtener las ganancias totales del taller en un período específico**

    ```mysql
    	-> SELECT SUM(total) AS TOTAL_GANANCIAS
        -> FROM pago
        -> WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
    +-----------------+
    | TOTAL_GANANCIAS |
    +-----------------+
    |          900.00 |
    +-----------------+
    ```

    Se suma el total de pagos hechos en el periodo seleccionado, para sacar el TOTAL de ganancias.
    

18. **Listar los empleados y el total de horas trabajadas en reparaciones en un período específico (asumiendo que se registra la duración de cada reparación)**

    ```mysql
    	-> SELECT
        ->  e.id AS ID_EMPLEADO,
        ->     CONCAT(e.nombre, ' ', e.apellido) AS NOMBRE,
        ->  r.duracion AS CANTIDAD_HORAS
        -> FROM reparacion r
        -> INNER JOIN
        ->  empleado e ON r.empleado_id = e.id
        -> WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31'
        -> GROUP BY r.id
        -> ORDER BY CANTIDAD_HORAS DESC;
    +-------------+-------------------+----------------+
    | ID_EMPLEADO | NOMBRE            | CANTIDAD_HORAS |
    +-------------+-------------------+----------------+
    |           2 | Lucía Hernández   |              4 |
    |           1 | Pedro Martínez    |              3 |
    |           3 | José Fernández    |              2 |
    +-------------+-------------------+----------------+
    ```

    Se suman las duraciones de las reparaciones realizadas por cada empleado dentro del período especificado y se ordenan de mayor a menor.
    

19. **Obtener el listado de servicios prestados por cada empleado en un período específico**

    ```mysql
    	-> SELECT
        ->  CONCAT(e.nombre, ' ', e.apellido) AS EMPLEADO,
        ->  s.nombre AS SERVICIOS
        -> FROM
        ->  servicio s
        -> INNER JOIN
        ->  reparacion_servicio rs ON s.id = rs.servicio_id
        -> INNER JOIN
        ->  reparacion r ON rs.reparacion_id = r.id
        -> INNER JOIN
        ->  empleado e ON r.empleado_id = e.id
        -> WHERE
        ->  r.fecha BETWEEN '2023-01-01' AND '2023-03-31'
        -> ORDER BY EMPLEADO DESC;
    +-------------------+---------------------+
    | EMPLEADO          | SERVICIOS           |
    +-------------------+---------------------+
    | Pedro Martínez    | Cambio de aceite    |
    | Lucía Hernández   | Alineación          |
    | José Fernández    | Revisión de frenos  |
    +-------------------+---------------------+
    ```

    Se realiza una combinación entre las tablas de servicios, reparaciones y empleados para listar los servicios realizados por cada empleado. En este caso, cada empleado ha hecho solo 1 servicio dentro del período especificado.

    

**SUB CONSULTAS**



1. **Obtener el cliente que ha gastado más en reparaciones durante el último año.**

   ```mysql
   SELECT
       ->     c.id AS ID_CLIENTE,
       ->     CONCAT(c.nombre, ' ', c.apellido) AS CLIENTE,
       ->     (SELECT SUM(r.costo_total)
       ->      FROM reparacion r
       ->      WHERE r.vehiculo_id = v.id
       ->      AND r.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
       ->      GROUP BY r.vehiculo_id
       ->      ORDER BY SUM(r.costo_total) DESC)
       ->      AS COSTO_TOTAL_EN_REPARACIONES
       -> FROM cliente c
       -> INNER JOIN vehiculo v ON c.id = v.cliente_id
       -> LIMIT 1;
   +------------+-------------+-----------------------------+
   | ID_CLIENTE | CLIENTE     | COSTO_TOTAL_EN_REPARACIONES |
   +------------+-------------+-----------------------------+
   |          1 | Juan Pérez  |                      220.00 |
   +------------+-------------+-----------------------------+
   ```

   Se suma el costo total de todas las reparaciones de cada cliente en el intervalo de 1 año, se ordenan de mayor a menor y se limita la consulta a 1 resultado, para que muestre solo el cliente que mas ha gastado.
   
2. **Obtener la pieza más utilizada en reparaciones durante el último mes**

   ```mysql
   	-> SELECT
       ->  p.id AS PIEZA_ID,
       ->     p.nombre AS PIEZA,
       ->     COUNT(rp.pieza_id) AS VECES_USADA
       -> FROM
       ->  pieza p
       -> INNER JOIN
       ->  reparacion_piezas rp ON p.id = rp.pieza_id
       -> INNER JOIN
       ->  reparacion r ON rp.reparacion_id = r.id
       -> WHERE
       ->  r.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
       -> GROUP BY
       ->  p.id
       -> LIMIT 1;
   +----------+------------------+-------------+
   | PIEZA_ID | PIEZA            | VECES_USADA |
   +----------+------------------+-------------+
   |        1 | Filtro de aceite |           1 |
   +----------+------------------+-------------+
   ```

   Se cuenta el numero de veces que se ha utilizado cada pieza en el intervalo de 1 mes y se limita la consulta a 1 resultado, para que muestre solo la pieza mas utilizada.
   
3. **Obtener los proveedores que suministran las piezas más caras**

   ```mysql
   	-> SELECT
       ->  p.id AS ID,
       ->  p.nombre AS NOMBRE
       -> FROM proveedor p
       -> INNER JOIN
       ->  precio pr ON p.id = pr.proveedor_id
       -> WHERE pr.precio_proveedor = (
       ->  SELECT MAX(precio_proveedor) FROM precio
       -> );
   +----+------------+
   | ID | NOMBRE     |
   +----+------------+
   |  1 | Proveedor1 |
   +----+------------+
   ```

   Se utiliza la función `MAX` para retornar el precio mas alto, y se relaciona con el proveedor, para saber cual es el proveedor con piezas mas caras
   

4. **Listar las reparaciones que no utilizaron piezas específicas durante el último año**

  ```mysql
  	-> SELECT * FROM reparacion r
      -> WHERE
      ->  r.fecha >= date_sub(curdate(), INTERVAL 1 YEAR)
      -> AND r.id NOT IN (
      ->  SELECT rp.reparacion_id
      ->     FROM reparacion_piezas rp
      ->     WHERE rp.pieza_id IN (1, 3)
      ->     );
  +----+------------+-------------+-------------+----------+-------------+-------------------+
  | id | fecha      | empleado_id | vehiculo_id | duracion | costo_total | descripcion       |
  +----+------------+-------------+-------------+----------+-------------+-------------------+
  |  5 | 2024-05-21 |           2 |           2 |        2 |      100.00 | Cambio de bujías  |
  +----+------------+-------------+-------------+----------+-------------+-------------------+
  ```

  Se seleccionan todas las reparaciones que no incluyen la pieza con id 1 y 3, en el intervalo de 1 año.
  
5. **Obtener las piezas que están en inventario por debajo del 10% del stock inicial**

   ```mysql
   	-> SELECT
       ->  p.id AS ID,
       ->     p.nombre AS NOMBRE,
       ->     i.stock_actual AS STOCK_ACTUAL,
       ->     i.stock_inicial AS STOCK_INICIAL
       -> FROM pieza p
       -> INNER JOIN
       ->  inventario i ON p.inventario_id = i.id
       -> WHERE i.stock_actual <= (
       ->  SELECT stock_inicial*0.1
       ->     FROM inventario
       ->     WHERE id = p.inventario_id
       -> );
   +----+-------------------+--------------+---------------+
   | ID | NOMBRE            | STOCK_ACTUAL | STOCK_INICIAL |
   +----+-------------------+--------------+---------------+
   |  2 | Bujía             |           48 |           500 |
   |  3 | Pastilla de freno |           32 |           500 |
   +----+-------------------+--------------+---------------+
   ```

   Se hace la operación para retornar el 10% del stock inicial designado, y se seleccionan las piezas que tienen stock actual menor o igual.