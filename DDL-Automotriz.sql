CREATE DATABASE automotriz;

USE automotriz;

CREATE TABLE ciudad (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Ciudad_Id PRIMARY KEY(id)
);

CREATE TABLE region (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Region_Id PRIMARY KEY(id)
);

CREATE TABLE pais (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Pais_Id PRIMARY KEY(id)
);

CREATE TABLE tipo_telefono (
    id INT AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    CONSTRAINT PK_tipoTelefono_Id PRIMARY KEY(id)
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    CONSTRAINT PK_Cliente_Id PRIMARY KEY(id)
);

CREATE TABLE marca (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Marca_Id PRIMARY KEY(id)
);

CREATE TABLE servicio (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Servicio_Id PRIMARY KEY(id)
);

CREATE TABLE cargo (
    id INT AUTO_INCREMENT,
    puesto VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Cargo_Id PRIMARY KEY(id)
);

CREATE TABLE contacto (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(254) NOT NULL,
    CONSTRAINT PK_Contacto_Id PRIMARY KEY(id)
);

CREATE TABLE ubicacion (
	id INT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(266) NOT NULL,
	CONSTRAINT PK_Ubicacion_Id PRIMARY KEY(id)
);

CREATE TABLE inventario (
    id INT AUTO_INCREMENT,
    cantidad INT,
    ubicacion_id INT,
    CONSTRAINT PK_Inventario_Id PRIMARY KEY (id),
    CONSTRAINT FK_Ubicacion_Inventario_Id FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(id)
);

CREATE TABLE pieza (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    inventario_id INT NOT NULL,
    CONSTRAINT PK_Pieza_Id PRIMARY KEY (id),
    CONSTRAINT FK_pieza_Inventario_Id FOREIGN KEY (inventario_id) REFERENCES inventario(id)
);

CREATE TABLE direccion_cliente (
    id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    pais_id INT NOT NULL,
    region_id INT NOT NULL,
    ciudad_id INT NOT NULL,
    detalle TEXT NOT NULL,
    CONSTRAINT PK_DireccionCliente_Id PRIMARY KEY(id),
    CONSTRAINT FK_Cliente_DireccionCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_Pais_DireccionCliente_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
    CONSTRAINT FK_Region_DireccionCliente_Id FOREIGN KEY(region_id) REFERENCES region(id),
    CONSTRAINT FK_Ciudad_DireccionCliente_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id),
    INDEX (cliente_id),
    INDEX (pais_id),
    INDEX (region_id),
    INDEX (ciudad_id)
);

CREATE TABLE telefono_cliente (
    id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    tipo_id INT NOT NULL,
    numero VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TelefonoCliente_Id PRIMARY KEY(id),
    CONSTRAINT FK_Cliente_TelefonoCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_Tipo_TelefonoCliente_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id),
    CONSTRAINT UC_TelefonoCliente_Numero UNIQUE(cliente_id, tipo_id, numero),
    INDEX (cliente_id),
    INDEX (tipo_id)
);

CREATE TABLE vehiculo (
    id INT AUTO_INCREMENT,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca_id INT NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    año_fabricacion YEAR NOT NULL,
    cliente_id INT NOT NULL,
    CONSTRAINT PK_Vehiculo_Id PRIMARY KEY (id),
    CONSTRAINT FK_Marca_Vehiculo_Id FOREIGN KEY (marca_id) REFERENCES marca(id),
    CONSTRAINT FK_Cliente_Vehiculo_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    INDEX (marca_id),
    INDEX (cliente_id)
);

CREATE TABLE empleado (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo_id INT NOT NULL,
    email VARCHAR(254) NOT NULL,
    CONSTRAINT PK_Empleado_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cargo_Empleado_Id FOREIGN KEY (cargo_id) REFERENCES cargo(id),
    INDEX (cargo_id)
);

CREATE TABLE telefono_empleado (
    id INT AUTO_INCREMENT,
    empleado_id INT NOT NULL,
    tipo_id INT NOT NULL,
    numero VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TelefonoEmpleado_Id PRIMARY KEY(id),
    CONSTRAINT FK_Empleado_TelefonoEmpleado_Id FOREIGN KEY(empleado_id) REFERENCES empleado(id),
    CONSTRAINT FK_Tipo_TelefonoEmpleado_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id),
    CONSTRAINT UC_TelefonoEmpleado_Numero UNIQUE(empleado_id, tipo_id, numero),
    INDEX (empleado_id),
    INDEX (tipo_id)
);

CREATE TABLE reparacion (
    id INT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    empleado_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    duracion INT NOT NULL,
    costo_total DECIMAL(10, 2) NOT NULL,
    descripcion TEXT NOT NULL,
    CONSTRAINT PK_Reparacion_Id PRIMARY KEY (id),
    CONSTRAINT FK_Empleado_Reparacion_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id),
    CONSTRAINT FK_Vehiculo_Reparacion_Id FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id),
    INDEX (empleado_id),
    INDEX (vehiculo_id)
);

CREATE TABLE reparacion_servicio (
    id INT AUTO_INCREMENT,
    reparacion_id INT NOT NULL,
    servicio_id INT NOT NULL,
    CONSTRAINT PK_ReparacionServicio_Id PRIMARY KEY(id),
    CONSTRAINT FK_Reparacion_ReparacionServicio_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id),
    CONSTRAINT FK_Servicio_ReparacionServicio_Id FOREIGN KEY (servicio_id) REFERENCES servicio(id),
    INDEX (reparacion_id),
    INDEX (servicio_id)
);

CREATE TABLE proveedor (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    contacto_id INT NOT NULL,
    email VARCHAR(254) NOT NULL,
    CONSTRAINT PK_Proveedor_Id PRIMARY KEY (id),
    CONSTRAINT FK_Contacto_Proveedor_Id FOREIGN KEY (contacto_id) REFERENCES contacto(id),
    INDEX (contacto_id)
);

CREATE TABLE telefono_proveedor (
    id INT AUTO_INCREMENT,
    proveedor_id INT NOT NULL,
    tipo_id INT NOT NULL,
    numero VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TelefonoProveedor_Id PRIMARY KEY(id),
    CONSTRAINT FK_Proveedor_TelefonoProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
    CONSTRAINT FK_Tipo_TelefonoProveedor_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id),
    CONSTRAINT UC_TelefonoProveedor_Numero UNIQUE(proveedor_id, tipo_id, numero),
    INDEX (proveedor_id),
    INDEX (tipo_id)
);

CREATE TABLE precio (
    proveedor_id INT NOT NULL,
    pieza_id INT NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    precio_proveedor DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Precio_Id PRIMARY KEY (proveedor_id, pieza_id),
    CONSTRAINT FK_Proveedor_Precio_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
    CONSTRAINT FK_Pieza_Precio_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id),
    INDEX (proveedor_id),
    INDEX (pieza_id)
);

CREATE TABLE reparacion_piezas (
    reparacion_id INT NOT NULL,
    pieza_id INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_ReparacionPieza_Id PRIMARY KEY (reparacion_id, pieza_id),
    CONSTRAINT FK_Reparacion_ReparacionPieza_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id),
    CONSTRAINT FK_Pieza_ReparacionPieza_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id),
    INDEX (reparacion_id),
    INDEX (pieza_id)
);

CREATE TABLE cita (
    id INT AUTO_INCREMENT,
    fecha_hora DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    CONSTRAINT PK_Cita_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cliente_Cita_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_Vehiculo_Cita_Id FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id),
    INDEX (cliente_id),
    INDEX (vehiculo_id)
);

CREATE TABLE cita_servicio (
    id INT AUTO_INCREMENT,
    cita_id INT NOT NULL,
    servicio_id INT NOT NULL,
    CONSTRAINT PK_CitaServicio_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cita_CitaServicio_Id FOREIGN KEY (cita_id) REFERENCES cita(id),
    CONSTRAINT FK_Servicio_CitaServicio_Id FOREIGN KEY (servicio_id) REFERENCES servicio(id),
    INDEX (cita_id),
    INDEX (servicio_id)
);

CREATE TABLE orden_compra (
    id INT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    proveedor_id INT NOT NULL,
    empleado_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrdenCompra_Id PRIMARY KEY (id),
    CONSTRAINT FK_Proveedor_OrdenCompra_Id FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
    CONSTRAINT FK_Empleado_OrdenCompra_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id)
);

CREATE TABLE orden_detalle (
    orden_id INT NOT NULL,
    pieza_id INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_OrdenDetalle_Id PRIMARY KEY (orden_id, pieza_id),
    CONSTRAINT FK_OrdenCompra_OrdenDetalle_Id FOREIGN KEY (orden_id) REFERENCES orden_compra(id),
    CONSTRAINT FK_Pieza_OrdenDetalle_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id),
    INDEX (orden_id),
    INDEX (pieza_id)
);

CREATE TABLE factura (
    id INT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    cliente_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Factura_Id PRIMARY KEY(id),
    CONSTRAINT FK_Cliente_Factura_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    INDEX (cliente_id)
);

CREATE TABLE pago (
    id INT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    cliente_id INT NOT NULL,
    factura_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Pago_Id PRIMARY KEY(id),
    CONSTRAINT FK_Cliente_Pago_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_Factura_Pago_Id FOREIGN KEY (factura_id) REFERENCES factura(id),
    INDEX (cliente_id),
    INDEX (factura_id)
);

CREATE TABLE detalle_factura (
    factura_id INT NOT NULL,
    reparacion_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_DetalleFactura_Id PRIMARY KEY (factura_id, reparacion_id),
    CONSTRAINT FK_Factura_DetalleFactura_Id FOREIGN KEY (factura_id) REFERENCES factura(id),
    CONSTRAINT FK_Reparacion_DetalleFactura_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id),
    INDEX (factura_id),
    INDEX (reparacion_id)
);
