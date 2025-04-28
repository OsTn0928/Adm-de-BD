-- Crear la base de datos
CREATE DATABASE sistema_ventas;

-- Seleccionar la base de datos para trabajar
USE sistema_ventas;

-- Crear la tabla tipo_usuarios
CREATE TABLE tipo_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nombre_tipo VARCHAR(50) NOT NULL, -- Tipo de usuario (Admin, Cliente)
    
    -- Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha creación
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Crear la tabla usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nombre_usuario VARCHAR(100) NOT NULL, -- Nombre del usuario
    correo VARCHAR(100) UNIQUE, -- Correo electrónico único
    tipo_usuario_id INT, -- Relación a tipo_usuarios
    
    -- Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha creación
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Agregar la relación entre la tabla usuarios y tipo_usuarios
ALTER TABLE usuarios
ADD CONSTRAINT fk_usuario_tipo_usuario
FOREIGN KEY (tipo_usuario_id) REFERENCES tipo_usuarios(id);

-- Crear la tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nombre VARCHAR(100) NOT NULL, -- Nombre del producto
    precio DECIMAL(10, 2) NOT NULL, -- Precio del producto
    stock INT NOT NULL, -- Stock disponible
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha creación
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Crear la tabla ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    usuario_id INT, -- Relación al usuario que realizó la venta
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha automática de la venta
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Relación entre ventas y usuarios
ALTER TABLE ventas
ADD CONSTRAINT fk_venta_usuario
FOREIGN KEY (usuario_id) REFERENCES usuarios(id);

-- Crear la tabla detalle_ventas
CREATE TABLE detalle_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    venta_id INT, -- Relación a la venta
    producto_id INT, -- Relación al producto
    cantidad INT NOT NULL, -- Cantidad vendida
    precio_unitario DECIMAL(10, 2) NOT NULL, -- Precio por unidad
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Relación entre detalle_ventas y ventas
ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_venta
FOREIGN KEY (venta_id) REFERENCES ventas(id);

-- Relación entre detalle_ventas y productos
ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_producto
FOREIGN KEY (producto_id) REFERENCES productos(id);
