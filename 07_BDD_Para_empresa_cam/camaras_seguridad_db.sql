CREATE DATABASE camaras_seguridad_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;
USE camaras_seguridad_db;

-- Cambié 'roles' -> 'tipo_usuario' y 'id_rol' -> 'id_tipo_usuario'
CREATE TABLE tipo_usuario (
  id_tipo_usuario TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(255),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_tipo_usuario),
  CHECK (is_deleted IN (0,1)),
  CHECK (CHAR_LENGTH(nombre) > 0)
);

CREATE TABLE usuarios (
  id_usuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
  contrasena_hash VARCHAR(255) NOT NULL,
  nombre_completo VARCHAR(200) NOT NULL,
  correo VARCHAR(150),
  id_tipo_usuario TINYINT UNSIGNED NOT NULL,
  telefono VARCHAR(30),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuarios_tipo_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id_tipo_usuario),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE sectores (
  id_sector INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(150) NOT NULL,
  descripcion VARCHAR(255),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_sector),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE plazas (
  id_plaza INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(150) NOT NULL,
  id_sector INT UNSIGNED NOT NULL,
  direccion VARCHAR(255),
  latitud VARCHAR(50),
  longitud VARCHAR(50),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_plaza),
  CONSTRAINT fk_plazas_sectores FOREIGN KEY (id_sector) REFERENCES sectores(id_sector),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE camaras (
  id_camara INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_plaza INT UNSIGNED NOT NULL,
  -- reemplazado 'identificador' por 'numero_serie' para evitar confusión con 'modelo'
  numero_serie VARCHAR(100) NOT NULL UNIQUE,
  modelo VARCHAR(100),
  direccion_ip VARCHAR(45),
  fecha_instalacion DATE,
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_camara),
  CONSTRAINT fk_camaras_plazas FOREIGN KEY (id_plaza) REFERENCES plazas(id_plaza),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE tipos_reportes (
  id_tipo_reporte INT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  nombre VARCHAR(120) NOT NULL,
  descripcion VARCHAR(255),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_tipo_reporte),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE tipos_eventos (
  id_tipo_evento INT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  nombre VARCHAR(120) NOT NULL,
  descripcion VARCHAR(255),
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_tipo_evento),
  CHECK (is_deleted IN (0,1))
);

CREATE TABLE reportes (
  id_reporte INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_tipo_reporte INT UNSIGNED NOT NULL,
  reportado_por INT UNSIGNED NOT NULL,
  descripcion_reporte VARCHAR(1000),
  fecha_hora_reporte DATETIME NOT NULL,
  nivel_gravedad TINYINT UNSIGNED NOT NULL DEFAULT 1,
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_reporte),
  CONSTRAINT fk_reportes_tipos FOREIGN KEY (id_tipo_reporte) REFERENCES tipos_reportes(id_tipo_reporte),
  CONSTRAINT fk_reportes_usuarios FOREIGN KEY (reportado_por) REFERENCES usuarios(id_usuario),
  CHECK (is_deleted IN (0,1)),
  CHECK (nivel_gravedad BETWEEN 1 AND 5)
);

CREATE TABLE reportes_plazas (
  id_reporte INT UNSIGNED NOT NULL,
  id_plaza INT UNSIGNED NOT NULL,
  especificacion VARCHAR(255),
  PRIMARY KEY (id_reporte, id_plaza),
  CONSTRAINT fk_reportes_plazas_reporte FOREIGN KEY (id_reporte) REFERENCES reportes(id_reporte),
  CONSTRAINT fk_reportes_plazas_plaza FOREIGN KEY (id_plaza) REFERENCES plazas(id_plaza)
);

CREATE TABLE reportes_camaras (
  id_reporte INT UNSIGNED NOT NULL,
  id_camara INT UNSIGNED NOT NULL,
  especificacion VARCHAR(255),
  PRIMARY KEY (id_reporte, id_camara),
  CONSTRAINT fk_reportes_camaras_reporte FOREIGN KEY (id_reporte) REFERENCES reportes(id_reporte),
  CONSTRAINT fk_reportes_camaras_camara FOREIGN KEY (id_camara) REFERENCES camaras(id_camara)
);

CREATE TABLE accesos_usuarios (
  id_acceso INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NOT NULL,
  id_plaza INT UNSIGNED NOT NULL,
  otorgado_por INT,
  fecha_otorgado DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  revocado_por INT,
  fecha_revocado DATETIME,
  activo TINYINT UNSIGNED NOT NULL DEFAULT 1,
  created_by INT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT,
  deleted_at DATETIME,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_acceso),
  CONSTRAINT fk_accesos_usuarios_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_accesos_usuarios_plazas FOREIGN KEY (id_plaza) REFERENCES plazas(id_plaza),
  CHECK (is_deleted IN (0,1)),
  CHECK (activo IN (0,1))
);

CREATE TABLE eventos_camara (
  id_evento INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_camara INT UNSIGNED NOT NULL,
  id_tipo_evento INT UNSIGNED DEFAULT NULL,
  descripcion_evento VARCHAR(1000) DEFAULT NULL,
  fecha_hora_evento DATETIME NOT NULL,
  nivel_confianza TINYINT UNSIGNED NOT NULL DEFAULT 0,
  created_by INT DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by INT DEFAULT NULL,
  modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by INT DEFAULT NULL,
  deleted_at DATETIME DEFAULT NULL,
  is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id_evento),
  CONSTRAINT fk_eventos_camara_camaras FOREIGN KEY (id_camara) REFERENCES camaras(id_camara),
  CONSTRAINT fk_eventos_camara_tipos FOREIGN KEY (id_tipo_evento) REFERENCES tipos_eventos(id_tipo_evento),
  CHECK (is_deleted IN (0,1)),
  CHECK (nivel_confianza BETWEEN 0 AND 100),
  CHECK (modified_at IS NULL OR modified_at >= created_at)
);
