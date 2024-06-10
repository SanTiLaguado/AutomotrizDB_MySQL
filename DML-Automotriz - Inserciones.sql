# DML-Automotriz - INSERCION DE DATOS

USE automotriz;

INSERT INTO ciudad (nombre) VALUES 
('Bucaramanga'), 
('Medellin'), 
('Bogota DC');

INSERT INTO region (nombre) VALUES 
('Santander'), 
('Antioquia'), 
('Bogota DC');

INSERT INTO pais (nombre) VALUES 
('Colombia');

INSERT INTO tipo_telefono (tipo) VALUES 
('Móvil'), 
('Fijo'), 
('Fax');

INSERT INTO cliente (nombre, apellido, email) VALUES 
('Juan', 'Pérez', 'juan.perez@example.com'), 
('Ana', 'Gómez', 'ana.gomez@example.com'), 
('Luis', 'Martínez', 'luis.martinez@example.com'),
('Maria Fernanda', 'Araque', 'mafe.araque@example.com');

INSERT INTO marca (nombre) VALUES 
('Toyota'), 
('Honda'), 
('Ford');

INSERT INTO servicio (nombre, descripcion, costo) VALUES 
('Cambio de aceite', 'Cambio de aceite del motor', 30.00), 
('Alineación', 'Alineación de ruedas', 50.00), 
('Revisión de frenos', 'Inspección y ajuste de frenos', 40.00);

INSERT INTO cargo (puesto) VALUES 
('Mecánico'), 
('Supervisor'), 
('Administrador');

INSERT INTO contacto (nombre, apellido, email) VALUES 
('Carlos', 'Gómez', 'carlos.gomez@example.com'), 
('Marta', 'López', 'marta.lopez@example.com'), 
('Pedro', 'Sánchez', 'pedro.sanchez@example.com');

INSERT INTO ubicacion (nombre , direccion) VALUES 
('Almacén Central', 'Calle 15 Carrera Central A'), 
('Sucursal Norte', 'Calle 75 Carretera NORTE'), 
('Sucursal Sur', 'Calle 23 Carrera 12 Sur');

INSERT INTO inventario (cantidad, ubicacion_id) VALUES 
(100, 1), 
(50, 2), 
(200, 3);

INSERT INTO pieza (nombre, descripcion, inventario_id) VALUES 
('Filtro de aceite', 'Filtro de aceite para motor', 1), 
('Bujía', 'Bujía para encendido', 2), 
('Pastilla de freno', 'Pastilla de freno para autos', 3);

INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES 
(1, 1, 1, 1, 'Calle Falsa 123'), 
(2, 1, 2, 2, 'Avenida Siempre Viva 456'), 
(3, 1, 3, 3, 'Boulevard de los Sueños Rotos 789');

INSERT INTO telefono_cliente (cliente_id, tipo_id, numero) VALUES 
(1, 1, '555-1234'), 
(2, 2, '316-5678'), 
(3, 1, '555-9101');

INSERT INTO vehiculo (placa, marca_id, modelo, año_fabricacion, cliente_id) VALUES 
('ABC123', 1, 'Corolla', 2020, 1), 
('DEF456', 2, 'Civic', 2019, 2), 
('GHI789', 3, 'Focus', 2018, 3);

INSERT INTO empleado (nombre, apellido, cargo_id, email) VALUES 
('Pedro', 'Martínez', 1, 'pedro.martinez@example.com'), 
('Lucía', 'Hernández', 2, 'lucia.hernandez@example.com'), 
('José', 'Fernández', 3, 'jose.fernandez@example.com');

INSERT INTO telefono_empleado (empleado_id, tipo_id, numero) VALUES 
(1, 1, '555-5678'), 
(2, 2, '555-8765'), 
(3, 3, '555-2345');

INSERT INTO reparacion (fecha, empleado_id, vehiculo_id, duracion, costo_total, descripcion) VALUES 
('2023-01-15', 1, 1, 3, 200.00, 'Revisión general'), 
('2023-02-20', 2, 2, 4,300.00, 'Cambio de frenos'), 
('2023-03-10', 3, 3, 2,150.00, 'Cambio de aceite');

INSERT INTO reparacion_servicio (reparacion_id, servicio_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3);

INSERT INTO proveedor (nombre, contacto_id, email) VALUES 
('Proveedor1', 1, 'proveedor1@example.com'), 
('Proveedor2', 2, 'proveedor2@example.com'), 
('Proveedor3', 3, 'proveedor3@example.com');

INSERT INTO telefono_proveedor (proveedor_id, tipo_id, numero) VALUES 
(1, 1, '555-8765'), 
(2, 2, '555-4321'), 
(3, 3, '555-6789');

INSERT INTO precio (proveedor_id, pieza_id, precio_venta, precio_proveedor) VALUES 
(1, 1, 50.00, 25.00), 
(2, 2, 40.00, 20.00), 
(3, 3, 30.00, 15.00);

INSERT INTO reparacion_piezas (reparacion_id, pieza_id, cantidad) VALUES 
(1, 1, 1), 
(2, 2, 2), 
(3, 3, 3);

INSERT INTO cita (fecha_hora, cliente_id, vehiculo_id) VALUES 
('2023-01-10 10:00:00', 1, 1), 
('2023-02-15 11:00:00', 2, 2), 
('2023-03-20 12:00:00', 3, 3);

INSERT INTO cita_servicio (cita_id, servicio_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3);

INSERT INTO orden_compra (fecha, proveedor_id, empleado_id, total) VALUES 
('2023-01-01', 1, 1, 500.00), 
('2023-02-02', 2, 2, 600.00), 
('2023-03-03', 3, 3, 700.00);


INSERT INTO orden_detalle (orden_id, pieza_id, cantidad) VALUES 
(1, 1, 10), 
(2, 2, 20), 
(3, 3, 30);

INSERT INTO factura (fecha, cliente_id, total) VALUES 
('2023-01-16', 1, 200.00), 
('2023-02-17', 2, 300.00), 
('2023-03-18', 3, 400.00);

INSERT INTO pago (fecha, cliente_id, factura_id, total) VALUES 
('2023-01-17', 1, 1, 200.00), 
('2023-02-18', 2, 2, 300.00), 
('2023-03-19', 3, 3, 400.00);

INSERT INTO detalle_factura (factura_id, reparacion_id, cantidad, precio_unitario) VALUES 
(1, 1, 1, 200.00), 
(2, 2, 1, 300.00), 
(3, 3, 1, 400.00);







