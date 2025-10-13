-- 1. Aplicar Procedimientos almacenados en un ambiente simulado
-- 2. Crear procedimientos almacenados por cada tabla:
-- Insertar datos con procedure
-- Borrado lógico
-- Mostrar datos activos
-- Mostrar todos los datos


-- Insertar datos con procedure
DELIMITER //
CREATE PROCEDURE InsertarUsuario(
    IN p_nombre_usuario VARCHAR(50),
    IN p_contrasena_hash VARCHAR(255),
    IN p_nombre_completo VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_id_rol INT,
    IN p_telefono VARCHAR(20),
    IN p_created_by INT
)
BEGIN
    INSERT INTO usuarios (nombre_usuario, contrasena_hash, nombre_completo, correo, id_rol, telefono, created_by, created_at, is_deleted)
    VALUES (p_nombre_usuario, p_contrasena_hash, p_nombre_completo, p_correo, p_id_rol, p_telefono, p_created_by, CURRENT_TIMESTAMP, 0);
END //


-- Borrado lógico
DELIMITER //
CREATE PROCEDURE BorradoUsuarioLogico(
    IN p_id_usuario INT,
    IN p_deleted_by INT
)
BEGIN
    UPDATE usuarios
    SET is_deleted = 1,
        deleted_by = p_deleted_by,
        deleted_at = CURRENT_TIMESTAMP
    WHERE id_usuario = p_id_usuario;
END //

-- Mostrar datos inactivos
DELIMITER //
CREATE PROCEDURE MostrarUsuariosInactivos()
BEGIN
    SELECT * FROM usuarios WHERE is_deleted = 1;
END //

--- Mostrar datos activos
DELIMITER //
CREATE PROCEDURE MostrarUsuariosActivos()
BEGIN
    SELECT * FROM usuarios WHERE is_deleted = 0;
END //

-- Mostrar todos los datos
DELIMITER //
CREATE PROCEDURE ShowAllData()
BEGIN
    SELECT * FROM usuarios;
    SELECT * FROM roles;
    SELECT * FROM sectores;
    SELECT * FROM plazas;
    SELECT * FROM camaras;
    SELECT * FROM tipos_reportes;
    SELECT * FROM tipos_eventos;
    SELECT * FROM reportes;
    SELECT * FROM reportes_plazas;
    SELECT * FROM reportes_camaras;
    SELECT * FROM accesos_usuarios;
    SELECT * FROM eventos_camara;
END //


-- Ejemplo de llamada a los procedimientos almacenados
CALL InsertarUsuario(
    'nuevo.usuario',           -- p_nombre_usuario
    'xeashnuevo',              -- p_contrasena_hash
    'Nuevo Usuario',           -- p_nombre_completo
    'nuevo.usuario@email.com', -- p_correo
    2,                         -- p_id_rol (ejemplo)
    '987654321',               -- p_telefono
    1                          -- p_created_by (id del usuario que creó)
);

SELECT * FROM usuarios WHERE nombre_usuario = 'nuevo.usuario';

-- Mostrar usuarios activos
CALL MostrarUsuariosActivos();

 -- Borrar lógicamente al usuario con id 1
CALL BorradoUsuarioLogico(1, 2);  

-- Verificar que los usuarios 1 y 2 están marcados como borrados
CALL MostrarUsuariosInactivos();

-- Mostrar todos los usuarios (incluidos los borrados)
CALL ShowAllData();

