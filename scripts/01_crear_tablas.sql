-- Reinicio controlado del esquema de la actividad
DROP TABLE IF EXISTS orden_productos;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS orden_venta;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS cliente;

-- Entidades principales
CREATE TABLE cliente (
    cc INTEGER PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE empleado (
    id_empleado INTEGER PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    cargo VARCHAR(60) NOT NULL
);

CREATE TABLE producto (
    codigo INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DOUBLE PRECISION NOT NULL CHECK (precio > 0)
);

-- Órdenes y ventas
CREATE TABLE orden_venta (
    nro INTEGER PRIMARY KEY,
    fecha_solicitud DATE NOT NULL,
    domicilio VARCHAR(150) NOT NULL,
    cc INTEGER NOT NULL REFERENCES cliente (cc),
    id_empleado INTEGER NOT NULL REFERENCES empleado (id_empleado)
);

CREATE TABLE venta (
    nro INTEGER PRIMARY KEY REFERENCES orden_venta (nro),
    fecha_venta DATE NOT NULL,
    descripcion VARCHAR(200) NOT NULL
);

CREATE TABLE orden_productos (
    codigo INTEGER NOT NULL REFERENCES producto (codigo),
    nro INTEGER NOT NULL REFERENCES orden_venta (nro),
    descuento DOUBLE PRECISION NOT NULL DEFAULT 0 CHECK (descuento BETWEEN 0 AND 1),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    PRIMARY KEY (codigo, nro)
);
