-- Añade los campos de auditoría a todas las tablas de la base de datos ejemploSelect
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT, 
    descripcion VARCHAR(50) NOT NULL CHECK (descripcion IN ('Administrador', 'Cliente', 'Moderador')),
    nivel_acceso TINYINT CHECK (nivel_acceso BETWEEN 1 AND 3),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT, -- Usuario que crea
    updated_by INT, -- Usuario que modifica
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)) -- Borrado lógico
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL CHECK (CHAR_LENGTH(nombre) >= 3 AND nombre REGEXP '^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$'),
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    activo BOOLEAN DEFAULT TRUE CHECK (activo IN (0, 1)),
    edad TINYINT CHECK (edad BETWEEN 13 AND 100),
    id_tipo INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)),
    FOREIGN KEY (id_tipo) REFERENCES tipo_usuarios(id_tipo)
);

-- Tabla: ciudad
CREATE TABLE ciudad (
    id_ciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ciudad VARCHAR(100) NOT NULL CHECK (CHAR_LENGTH(nombre_ciudad) >= 3),
    region VARCHAR(100) NOT NULL CHECK (region IN (
        'Región Metropolitana', 'Región de Valparaíso', 'Región del Biobío', 
        'Región de Coquimbo', 'Región de Los Lagos'
    )),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1))
);

-- Tabla: personas
CREATE TABLE personas (
    rut VARCHAR(13) PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL CHECK (CHAR_LENGTH(nombre_completo) >= 3 AND nombre_completo REGEXP '^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$'),
    fecha_nac DATE CHECK (fecha_nac BETWEEN '1900-01-01' AND '2025-01-01'), -- ← CORREGIDO
    id_usuario INT,
    id_ciudad INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

-- Inserciones para tipo_usuarios
INSERT INTO tipo_usuarios 
(descripcion, nivel_acceso, created_at, updated_at, created_by, updated_by, deleted) VALUES
('Administrador', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Cliente', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Moderador', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE);

-- Inserciones para usuarios
INSERT INTO usuarios 
(nombre, email, activo, edad, id_tipo, created_at, updated_at, created_by, updated_by, deleted) VALUES
('Admin Uno', 'admin01@mail.com', TRUE, 35, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Juan Valdés', 'jvaldes@mail.com', TRUE, 30, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Camila Morales', 'cmorales@mail.com', TRUE, 29, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Andrea Navarro', 'anavarro@mail.com', TRUE, 31, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Rodrigo Quezada', 'rquezada@mail.com', TRUE, 40, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Patricio Godoy', 'pgodoy@mail.com', TRUE, 27, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('María Díaz', 'mdiaz@mail.com', TRUE, 33, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Sebastián Carvajal', 'scarvajal@mail.com', TRUE, 28, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Lorena Tapia', 'ltapia@mail.com', TRUE, 24, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Ana Farías', 'afarias@mail.com', TRUE, 29, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE);

-- Inserciones para ciudad
INSERT INTO ciudad 
(nombre_ciudad, region, created_at, updated_at, created_by, updated_by, deleted) VALUES
('Santiago', 'Región Metropolitana', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Valparaíso', 'Región de Valparaíso', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Concepción', 'Región del Biobío', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('La Serena', 'Región de Coquimbo', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('Puerto Montt', 'Región de Los Lagos', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE);

-- Inserciones para personas
INSERT INTO personas 
(rut, nombre_completo, fecha_nac, id_usuario, id_ciudad, created_at, updated_at, created_by, updated_by, deleted) VALUES
('11.111.111-1', 'Juan Valdés', '1990-04-12', 2, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('22.222.222-2', 'Camila Morales', '1985-09-25', 3, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('33.333.333-3', 'Andrea Navarro', '1992-11-03', 4, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('44.444.444-4', 'Rodrigo Quezada', '1980-06-17', 5, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('55.555.555-5', 'Patricio Godoy', '1998-12-01', 6, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('66.666.666-6', 'María Díaz', '1987-07-14', 7, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('77.777.777-7', 'Sebastián Carvajal', '1993-03-22', 8, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('88.888.888-8', 'Lorena Tapia', '2000-10-10', 9, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('99.999.999-9', 'Ana Farías', '1995-01-28', 10, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE),
('10.101.010-0', 'Carlos Soto', '1991-08-08', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, FALSE);

-- 1.- Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
SELECT u.nombre AS username, u.email, tu.descripcion AS tipo_usuario
FROM usuarios u, tipo_usuarios tu
WHERE u.id_tipo = tu.id_tipo
AND tu.descripcion = 'Cliente';

-- 2.- Mostrar Personas nacidas después del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username
SELECT p.nombre_completo, p.fecha_nac, u.nombre AS username
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.fecha_nac > '1990-01-01';

-- 3.- Seleccionar nombres de personas que comiencen con la letra A
-- Seleccionar nombre y correo de la persona
SELECT p.nombre_completo, u.email
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.nombre_completo LIKE 'A%';

-- 4.- Mostrar usuarios cuyos dominios de correo sean mail.com
SELECT u.nombre, u.email
FROM usuarios u
WHERE u.email LIKE '%@mail.com';

-- 5.- Mostrar todas las personas que no viven en Valparaíso y su usuario + ciudad
SELECT p.nombre_completo, u.nombre AS username, c.nombre_ciudad
FROM personas p, usuarios u, ciudad c
WHERE p.id_usuario = u.id_usuario
AND p.id_ciudad = c.id_ciudad
AND c.nombre_ciudad <> 'Valparaíso';

-- 6.- Mostrar usuarios que contengan más de 7 caracteres de longitud en el nombre
SELECT u.nombre
FROM usuarios u
WHERE CHAR_LENGTH(u.nombre) > 7;

-- 7.- Mostrar username de personas nacidas entre 1990 y 1995
SELECT u.nombre AS username
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.fecha_nac BETWEEN '1990-01-01' AND '1995-12-31';

