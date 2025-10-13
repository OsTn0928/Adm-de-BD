-- Nota: actualicé INSERTs / SELECTs para usar 'tipo_usuario' y 'numero_serie'

-- TIPOS DE USUARIO (antes 'roles')
INSERT INTO tipo_usuario (id_tipo_usuario, nombre, descripcion, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 'administrador', 'Acceso completo al sistema', NULL, '2024-01-10 09:00:00', NULL, '2024-01-10 09:00:00', NULL, NULL, 0),
(2, 'vecino', 'Usuario residente de la comuna', NULL, '2024-01-10 09:05:00', NULL, '2024-01-10 09:05:00', NULL, NULL, 0),
(3, 'operador', 'Operador encargado de revisar eventos', NULL, '2024-02-01 08:30:00', NULL, '2024-02-01 08:30:00', NULL, NULL, 0),
(4, 'seguridad', 'Equipo de seguridad local', NULL, '2024-03-15 10:00:00', NULL, '2024-03-15 10:00:00', NULL, NULL, 0);

-- USUARIOS (cambiado id_rol -> id_tipo_usuario)
INSERT INTO usuarios (id_usuario, nombre_usuario, contrasena_hash, nombre_completo, correo, id_tipo_usuario, telefono, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 'juan.perez', '$2y$10$hashdemojuan', 'Juan Pérez', 'juan.perez@example.com', 2, '+56-9-7123-4567', NULL, '2024-04-01 12:00:00', NULL, '2024-04-01 12:00:00', NULL, NULL, 0),
(2, 'admin.sys', '$2y$10$hashadmin', 'Administrador Sistema', 'admin@demo.local', 1, '+56-2-2345-6789', NULL, '2024-01-11 09:10:00', NULL, '2024-01-11 09:10:00', NULL, NULL, 0),
(3, 'maria.lopez', '$2y$10$hashmaria', 'María López', 'maria.lopez@example.com', 2, '+56-9-7211-3344', NULL, '2024-05-05 15:20:00', NULL, '2024-05-06 10:00:00', NULL, NULL, 0),
(4, 'carlos.op', '$2y$10$hashcarlos', 'Carlos Operador', 'carlos.op@example.com', 3, '+56-9-7000-1111', NULL, '2024-02-10 08:00:00', NULL, '2024-02-10 08:00:00', NULL, NULL, 0),
(5, 'seguridad1', '$2y$10$hashseg', 'Equipo Seguridad 1', 'seguridad1@example.org', 4, '+56-9-7555-2222', NULL, '2024-03-20 07:30:00', NULL, '2024-03-20 07:30:00', NULL, NULL, 0),
(6, 'usuario.borrado', '$2y$10$hashx', 'Usuario Borrado', 'borrado@example.com', 2, '+56-9-7000-9999', NULL, '2024-06-10 09:00:00', NULL, '2024-07-01 10:00:00', NULL, '2024-07-01 10:00:00', 1);

-- SECTORES
INSERT INTO sectores (id_sector, nombre, descripcion, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 'Sector Centro', 'Zona céntrica con alto tránsito', NULL, '2024-01-05 08:00:00', NULL, '2024-01-05 08:00:00', NULL, NULL, 0),
(2, 'Sector Norte', 'Barrios residenciales norte', NULL, '2024-01-20 10:00:00', NULL, '2024-01-20 10:00:00', NULL, NULL, 0),
(3, 'Sector Sur', 'Parques y áreas verdes al sur', NULL, '2024-02-15 11:30:00', NULL, '2024-02-15 11:30:00', NULL, NULL, 0);

-- PLAZAS
INSERT INTO plazas (id_plaza, nombre, id_sector, direccion, latitud, longitud, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 'Plaza Central', 1, 'Av. Principal 100', '-33.4489', '-70.6693', NULL, '2024-01-06 09:00:00', NULL, '2024-01-06 09:00:00', NULL, NULL, 0),
(2, 'Plaza Norte', 2, 'Calle Norte 45', '-33.4400', '-70.6600', NULL, '2024-02-01 10:00:00', NULL, '2024-02-01 10:00:00', NULL, NULL, 0),
(3, 'Parque del Sur', 3, 'Ruta Sur 200', '-33.4600', '-70.6800', NULL, '2024-03-01 11:00:00', NULL, '2024-03-01 11:00:00', NULL, NULL, 0),
(4, 'Plaza Pequeña', 1, 'Pasaje 12', '-33.4495', '-70.6680', NULL, '2024-05-10 09:30:00', NULL, '2024-05-10 09:30:00', NULL, NULL, 0),
(5, 'Plaza Cerrada', 2, 'Cerrada 5', '-33.4420', '-70.6620', NULL, '2024-06-01 08:00:00', NULL, '2024-06-01 08:00:00', NULL, '2024-09-01 12:00:00', 1);

-- CAMARAS: reemplazado campo 'identificador' por 'numero_serie'
INSERT INTO camaras (id_camara, id_plaza, numero_serie, modelo, direccion_ip, fecha_instalacion, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 1, 'CAM-PRIN-01', 'AXIS-Q6000', '192.168.1.10', '2024-01-15', NULL, '2024-01-15 08:00:00', NULL, '2024-01-15 08:00:00', NULL, NULL, 0),
(2, 1, 'CAM-PRIN-02', 'AXIS-Q6000', '192.168.1.11', '2024-01-16', NULL, '2024-01-16 08:00:00', NULL, '2024-01-16 08:00:00', NULL, NULL, 0),
(3, 2, 'CAM-NORTE-01', 'Hikvision-DS', '10.0.0.12', '2024-02-05', NULL, '2024-02-05 09:00:00', NULL, '2024-02-05 09:00:00', NULL, NULL, 0),
(4, 3, 'CAM-SUR-01', 'Dahua-X', '2001:0db8:85a3::8a2e:0370:7334', '2024-03-20', NULL, '2024-03-20 10:00:00', NULL, '2024-03-20 10:00:00', NULL, NULL, 0),
(5, 4, 'CAM-PEQ-01', 'Model-P', '172.16.5.21', '2024-05-12', NULL, '2024-05-12 09:10:00', NULL, '2024-05-12 09:10:00', NULL, NULL, 0);

-- TIPOS DE REPORTES
INSERT INTO tipos_reportes (id_tipo_reporte, codigo, nombre, descripcion, created_by, created_at)
VALUES
(1, 'INCID', 'Incidente', 'Hechos que requieren atención del equipo', NULL, '2024-01-10 09:00:00'),
(2, 'VAND', 'Vandalismo', 'Daños a infraestructura pública', NULL, '2024-02-12 10:00:00'),
(3, 'SOS', 'Emergencia', 'Situación de urgencia', NULL, '2024-03-01 11:00:00');

-- TIPOS DE EVENTOS (detección automática)
INSERT INTO tipos_eventos (id_tipo_evento, codigo, nombre, descripcion, created_by, created_at)
VALUES
(1, 'MOV', 'Movimiento', 'Detección automática de movimiento', NULL, '2024-01-20 09:00:00'),
(2, 'OBJ', 'Objetos Extraños', 'Detección de objetos abandonados', NULL, '2024-02-20 09:00:00'),
(3, 'SND', 'Sonido fuerte', 'Detección de sonido anómalo', NULL, '2024-03-15 09:30:00');

-- REPORTES (cabeceras) - nivel_gravedad entre 1 y 5, fechas en el pasado
INSERT INTO reportes (id_reporte, id_tipo_reporte, reportado_por, descripcion_reporte, fecha_hora_reporte, nivel_gravedad, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 1, 1, 'Persona sospechosa merodeando cerca del kiosco', '2025-10-05 18:30:00', 2, NULL, '2025-10-05 18:31:00', NULL, '2025-10-05 18:31:00', NULL, NULL, 0),
(2, 2, 3, 'Graffiti en el muro norte de la plaza', '2025-09-20 07:15:00', 3, NULL, '2025-09-20 07:20:00', NULL, '2025-09-20 07:20:00', NULL, NULL, 0),
(3, 3, 1, 'Persona con heridas que requiere ambulancia', '2025-08-10 22:05:00', 5, NULL, '2025-08-10 22:06:00', NULL, '2025-08-10 22:06:00', NULL, NULL, 0),
(4, 1, 6, 'Reporte antiguo de prueba (usuario borrado)', '2024-07-01 09:00:00', 1, NULL, '2024-07-01 09:00:00', NULL, '2024-07-01 09:00:00', NULL, '2024-07-02 10:00:00', 1);

-- ASOCIACIONES REPORTES - PLAZAS
INSERT INTO reportes_plazas (id_reporte, id_plaza, especificacion)
VALUES
(1, 1, 'Sector kiosco'),
(2, 1, 'Muro norte'),
(3, 3, 'Entrada sur'),
(4, 2, 'Plaza Norte (registro antiguo)');

-- ASOCIACIONES REPORTES - CAMARAS
INSERT INTO reportes_camaras (id_reporte, id_camara, especificacion)
VALUES
(1, 1, 'Captado a las 18:29'),
(1, 2, 'Otra cámara con ángulo complementario'),
(2, 3, 'Registro parcial de vandalismo'),
(3, 4, 'Ambulancia llegó luego');

-- ACCESOS USUARIOS
INSERT INTO accesos_usuarios (id_acceso, id_usuario, id_plaza, otorgado_por, fecha_otorgado, revocado_por, fecha_revocado, activo, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 1, 1, 2, '2024-04-02 09:00:00', NULL, NULL, 1, NULL, '2024-04-02 09:00:00', NULL, '2024-04-02 09:00:00', NULL, NULL, 0),
(2, 3, 1, 2, '2024-05-06 10:00:00', NULL, NULL, 1, NULL, '2024-05-06 10:00:00', NULL, '2024-05-06 10:00:00', NULL, NULL, 0),
(3, 4, 1, 2, '2024-02-11 08:15:00', NULL, NULL, 1, NULL, '2024-02-11 08:15:00', NULL, '2024-02-11 08:15:00', NULL, NULL, 0),
(4, 6, 2, 2, '2024-06-11 09:00:00', 2, '2024-07-02 11:00:00', 0, NULL, '2024-06-11 09:00:00', NULL, '2024-07-02 11:00:00', NULL, NULL, 0);

-- EVENTOS CAMARA (fechas <= NOW(), nivel_confianza 0..100)
INSERT INTO eventos_camara (id_evento, id_camara, id_tipo_evento, descripcion_evento, fecha_hora_evento, nivel_confianza, created_by, created_at, modified_by, modified_at, deleted_by, deleted_at, is_deleted)
VALUES
(1, 1, 1, 'Movimiento breve frente a la fuente', '2025-10-05 18:29:10', 85, NULL, '2025-10-05 18:29:30', NULL, '2025-10-05 18:29:30', NULL, NULL, 0),
(2, 2, 2, 'Objeto detectado en vía peatonal', '2025-09-18 12:10:05', 72, NULL, '2025-09-18 12:11:00', NULL, '2025-09-18 12:11:00', NULL, NULL, 0),
(3, 3, 1, 'Movimiento prolongado en sector norte', '2025-09-01 23:45:00', 60, NULL, '2025-09-01 23:46:00', NULL, '2025-09-01 23:46:00', NULL, NULL, 0),
(4, 4, 3, 'Ruido fuerte detectado cerca de la cancha', '2025-08-20 03:20:10', 40, NULL, '2025-08-20 03:21:00', NULL, '2025-08-20 03:21:00', NULL, NULL, 0),
(5, 5, NULL, 'Evento test sin tipo de evento asignado', '2025-07-10 14:00:00', 10, NULL, '2025-07-10 14:00:10', NULL, '2025-07-10 14:00:10', NULL, '2025-09-01 12:00:00', 1);


-- 1) Todos los tipos de usuario (tabla reemplazada)
SELECT * FROM tipo_usuario;

-- 2) Usuarios activos con su tipo de usuario (excluye usuarios marcados como borrados)
SELECT u.id_usuario, u.nombre_usuario, u.nombre_completo, u.correo, t.nombre AS tipo_usuario, u.telefono
FROM usuarios u
JOIN tipo_usuario t ON u.id_tipo_usuario = t.id_tipo_usuario
WHERE u.is_deleted = 0
ORDER BY u.nombre_completo;

-- 3) Todas las cámaras activas con su plaza y sector (uso de numero_serie)
SELECT c.id_camara, c.numero_serie, c.modelo, c.direccion_ip, c.fecha_instalacion,
       p.id_plaza, p.nombre AS plaza, s.id_sector, s.nombre AS sector
FROM camaras c
JOIN plazas p ON c.id_plaza = p.id_plaza
JOIN sectores s ON p.id_sector = s.id_sector
WHERE c.is_deleted = 0
ORDER BY s.nombre, p.nombre, c.numero_serie;

-- 4) Cámaras con dirección IPv6 (detección simple: contiene ':')
SELECT * FROM camaras
WHERE direccion_ip LIKE '%:%' AND is_deleted = 0;

-- 5) Eventos de la última semana (orden descendente) - muestra numero_serie de la cámara
SELECT e.*, c.numero_serie AS camara, t.nombre AS tipo_evento
FROM eventos_camara e
JOIN camaras c ON e.id_camara = c.id_camara
LEFT JOIN tipos_eventos t ON e.id_tipo_evento = t.id_tipo_evento
WHERE e.is_deleted = 0
  AND e.fecha_hora_evento >= NOW() - INTERVAL 7 DAY
ORDER BY e.fecha_hora_evento DESC;

-- 6) Eventos con alta confianza (>= 80)
SELECT e.id_evento, e.fecha_hora_evento, e.nivel_confianza, c.numero_serie, t.nombre
FROM eventos_camara e
JOIN camaras c ON e.id_camara = c.id_camara
LEFT JOIN tipos_eventos t ON e.id_tipo_evento = t.id_tipo_evento
WHERE e.nivel_confianza >= 80 AND e.is_deleted = 0
ORDER BY e.nivel_confianza DESC, e.fecha_hora_evento DESC;

-- 7) Eventos sin tipo asignado (NULL) -> mantuve condición is_deleted = 1 como en original
SELECT * FROM eventos_camara
WHERE id_tipo_evento IS NULL AND is_deleted = 1
ORDER BY fecha_hora_evento DESC;

-- 8) Último evento por cámara (window function + CTE)
WITH ranked AS (
  SELECT e.*, c.numero_serie,
         ROW_NUMBER() OVER (PARTITION BY e.id_camara ORDER BY e.fecha_hora_evento DESC) AS rn
  FROM eventos_camara e
  JOIN camaras c ON e.id_camara = c.id_camara
  WHERE e.is_deleted = 0
)
SELECT * FROM ranked WHERE rn = 1
ORDER BY fecha_hora_evento DESC;

-- 9) Cámaras que no tienen eventos activos
SELECT c.id_camara, c.numero_serie, p.nombre AS plaza
FROM camaras c
JOIN plazas p ON c.id_plaza = p.id_plaza
LEFT JOIN eventos_camara e ON c.id_camara = e.id_camara AND e.is_deleted = 0
WHERE e.id_evento IS NULL AND c.is_deleted = 0;

-- 10) Reportes que fueron creados por usuarios marcados como borrados (inconsistencia a revisar)
SELECT r.id_reporte,
       r.fecha_hora_reporte,
       r.descripcion_reporte,
       r.reportado_por,
       u.nombre_usuario,
       u.is_deleted
FROM reportes r
LEFT JOIN usuarios u ON r.reportado_por = u.id_usuario
WHERE (u.id_usuario IS NULL OR u.is_deleted = 1);

-- 11) Reportes con las plazas asociadas y cámaras asociadas (agregadas), usando numero_serie
SELECT r.id_reporte, r.fecha_hora_reporte, r.nivel_gravedad, r.descripcion_reporte,
       GROUP_CONCAT(DISTINCT p.nombre ORDER BY p.nombre SEPARATOR '; ') AS plazas,
       GROUP_CONCAT(DISTINCT c.numero_serie ORDER BY c.numero_serie SEPARATOR '; ') AS camaras
FROM reportes r
LEFT JOIN reportes_plazas rp ON r.id_reporte = rp.id_reporte
LEFT JOIN plazas p ON rp.id_plaza = p.id_plaza
LEFT JOIN reportes_camaras rc ON r.id_reporte = rc.id_reporte
LEFT JOIN camaras c ON rc.id_camara = c.id_camara
WHERE r.is_deleted = 0
GROUP BY r.id_reporte
ORDER BY r.fecha_hora_reporte DESC;

-- 12) Conteo de eventos por tipo durante el último mes
SELECT t.nombre AS tipo_evento, COUNT(*) AS total_eventos
FROM eventos_camara e
LEFT JOIN tipos_eventos t ON e.id_tipo_evento = t.id_tipo_evento
WHERE e.is_deleted = 0
  AND e.fecha_hora_evento >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY t.nombre
ORDER BY total_eventos DESC;

-- 13) Promedio de nivel_confianza por cámara (últimos 90 días)
SELECT c.numero_serie, ROUND(AVG(e.nivel_confianza),2) AS avg_confianza, COUNT(e.id_evento) AS eventos
FROM camaras c
JOIN eventos_camara e ON c.id_camara = e.id_camara
WHERE e.is_deleted = 0
  AND e.fecha_hora_evento >= NOW() - INTERVAL 90 DAY
GROUP BY c.id_camara
HAVING COUNT(e.id_evento) > 0
ORDER BY avg_confianza DESC;

-- 14) Distribución de reportes por nivel de gravedad
SELECT nivel_gravedad, COUNT(*) AS cantidad
FROM reportes
WHERE is_deleted = 0
GROUP BY nivel_gravedad
ORDER BY nivel_gravedad;

-- 15) Reportes recientes de alta gravedad (4 o 5)
SELECT r.id_reporte, r.fecha_hora_reporte, r.nivel_gravedad, r.descripcion_reporte, u.nombre_completo
FROM reportes r
JOIN usuarios u ON r.reportado_por = u.id_usuario
WHERE r.is_deleted = 0 AND r.nivel_gravedad >= 4
ORDER BY r.fecha_hora_reporte DESC;

-- 16) Plazas que tienen al menos una cámara activa
SELECT p.id_plaza, p.nombre
FROM plazas p
WHERE EXISTS (
  SELECT 1 FROM camaras c WHERE c.id_plaza = p.id_plaza AND c.is_deleted = 0
) AND p.is_deleted = 0
ORDER BY p.nombre;

-- 17) Usuarios (vecinos) que realizaron reportes (sin duplicados)
SELECT DISTINCT u.id_usuario, u.nombre_completo, u.nombre_usuario
FROM usuarios u
JOIN reportes r ON u.id_usuario = r.reportado_por
WHERE u.is_deleted = 0 AND r.is_deleted = 0;

-- 18) Paginación: últimos eventos (20 por página)
SELECT e.*, c.numero_serie
FROM eventos_camara e
JOIN camaras c ON e.id_camara = c.id_camara
WHERE e.is_deleted = 0
ORDER BY e.fecha_hora_evento DESC
LIMIT 20 OFFSET 0; -- reemplaza OFFSET según la página

-- 19) Búsqueda simple en descripción de reportes (LIKE)
SELECT id_reporte, fecha_hora_reporte, descripcion_reporte
FROM reportes
WHERE descripcion_reporte LIKE '%graffiti%' AND is_deleted = 0
ORDER BY fecha_hora_reporte DESC;

-- 20) Crear una vista con los últimos eventos por cámara (útil para monitoring)
CREATE OR REPLACE VIEW vw_ultimo_evento_camara AS
WITH ranked AS (
  SELECT e.*, ROW_NUMBER() OVER (PARTITION BY e.id_camara ORDER BY e.fecha_hora_evento DESC) rn
  FROM eventos_camara e
  WHERE e.is_deleted = 0
)
SELECT * FROM ranked WHERE rn = 1;

-- Ahora puedes consultar:
SELECT * FROM vw_ultimo_evento_camara;

-- 21) Plazas marcadas como borradas (soft deleted)
SELECT * FROM plazas WHERE is_deleted = 1;

-- 22) Accesos de usuarios activos a una plaza (ej. plaza id = 1)
SELECT au.id_acceso, u.nombre_completo, p.nombre AS plaza, au.fecha_otorgado, au.activo
FROM accesos_usuarios au
JOIN usuarios u ON au.id_usuario = u.id_usuario
JOIN plazas p ON au.id_plaza = p.id_plaza
WHERE au.id_plaza = 1 AND au.activo = 1 AND au.is_deleted = 0;
