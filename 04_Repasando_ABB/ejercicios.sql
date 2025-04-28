-- Crear la base de datos
CREATE DATABASE sistema_ventas;

-- Seleccionar la base de datos para trabajar
USE sistema_ventas;

-- Crear la tabla tipo_usuarios
CREATE TABLE tipo_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único
    nombre_tipo VARCHAR(50) NOT NULL,   -- Tipo de usuario (Admin, Cliente)
    
    -- Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Fecha creación
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Fecha modificación
    created_by INT,  -- Usuario que crea
    updated_by INT,  -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE  -- Borrado lógico
);

-- Crear la tabla usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Id único
    
    nombre_tipo VARCHAR(100) NOT NULL,  -- Nombre de usuario
    correo VARCHAR(100) UNIQUE,  -- Correo electrónico único
    tipo_usuario_id INT,  -- Relación a tipo_usuario
    
    -- Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Fecha creación
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Fecha modificación
    created_by INT,  -- Usuario que crea
    updated_by INT,  -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE,  -- Borrado lógico
    
    -- Relación con tipo_usuarios
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipo_usuarios(id)
);

-- Modificar la tabla 'usuarios' para agregar la clave foránea
ALTER TABLE usuarios
    ADD CONSTRAINT fk_usuario_tipo_usuario
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipo_usuarios(id);


CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    precio DECIMAL NOT NULL,
    stock INT NOT NULL,

    --Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,

    --Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE,
);

CREATE TABLE detalle_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL NOT NULL,

    --Campos de auditoría
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE,
);