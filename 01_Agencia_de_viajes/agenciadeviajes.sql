-- Crear la base de datos
CREATE DATABASE AgenciaAviones;
USE AgenciaAviones;

-- Tabla: Personas (Raíz)
CREATE TABLE Personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(15),
    rut VARCHAR(100) UNIQUE,
    created DATETIME
);

-- Tabla: TipoUsuarios
CREATE TABLE TipoUsuarios (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    created DATETIME
);

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    id_tipo_usuario INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created DATETIME,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona),
    FOREIGN KEY (id_tipo_usuario) REFERENCES TipoUsuarios(id_tipo_usuario)
);

-- Tabla: Direcciones
CREATE TABLE Direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    pais VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    calle VARCHAR(150),
    numero VARCHAR(10),
    codigo_postal VARCHAR(10),
    created DATETIME,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- Tabla: Destinos
CREATE TABLE Destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nombre_destino VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    descripcion TEXT,
    created DATETIME
);

-- Tabla: Horarios
CREATE TABLE Horarios (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    hora_salida TIME NOT NULL,
    hora_regreso TIME,
    created DATETIME
);

-- Tabla: Vuelos
CREATE TABLE Vuelos (
    id_vuelo INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    id_horario INT NOT NULL,
    numero_vuelo VARCHAR(50) NOT NULL,
    descripcion TEXT,
    created DATETIME,
    FOREIGN KEY (id_destino) REFERENCES Destinos(id_destino),
    FOREIGN KEY (id_horario) REFERENCES Horarios(id_horario)
);

-- Tabla: Reservas
CREATE TABLE Reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_vuelo INT NOT NULL,
    fecha_reserva DATETIME NOT NULL,
    created DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_vuelo) REFERENCES Vuelos(id_vuelo)
);

-- Tabla: Transportes
CREATE TABLE Transportes (
    id_transporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo_transporte VARCHAR(100),
    nombre_transporte VARCHAR(100),
    descripcion TEXT,
    created DATETIME
);

-- Tabla: ViajesTransportes
CREATE TABLE ViajesTransportes (
    id_viaje INT NOT NULL,
    id_transporte INT NOT NULL,
    PRIMARY KEY (id_viaje, id_transporte),
    FOREIGN KEY (id_viaje) REFERENCES Reservas(id_reserva),
    FOREIGN KEY (id_transporte) REFERENCES Transportes(id_transporte)
);

--INSERCIONES DE LA BASE DE DATOS

-- Insertar datos en la tabla Personas
INSERT INTO Personas (nombre, apellido, email, telefono, rut, created) VALUES
('Carlos', 'Gomez', 'carlos.gomez@gmail.com', '987654321', '12345678-9', '2025-03-10 08:30:00'),
('Ana', 'Pérez', 'ana.perez@gmail.com', '912345678', '23456789-0', '2025-03-10 09:00:00'),
('Luis', 'Martínez', 'luis.martinez@gmail.com', '923456789', '34567890-1', '2025-03-10 10:15:00'),
('María', 'Lopez', 'maria.lopez@gmail.com', '934567890', '45678901-2', '2025-03-10 11:45:00'),
('Javier', 'Rodríguez', 'javier.rodriguez@gmail.com', '945678901', '56789012-3', '2025-03-10 12:00:00');

-- Insertar datos en la tabla TipoUsuarios
INSERT INTO TipoUsuarios (nombre_tipo, descripcion, created) VALUES
('Administrador', 'Usuario con acceso completo al sistema', '2025-03-10 08:30:00'),
('Viajero', 'Usuario que realiza reservas y compra boletos', '2025-03-10 09:00:00'),
('Agente', 'Usuario que gestiona vuelos y reservas', '2025-03-10 10:00:00'),
('Supervisor', 'Usuario encargado de supervisar las operaciones', '2025-03-10 11:30:00'),
('Cliente', 'Usuario que consulta información sobre vuelos', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_persona, id_tipo_usuario, username, password, created) VALUES
(1, 1, 'carlosg', 'password123', '2025-03-10 08:30:00'),
(2, 2, 'anaperez', 'password456', '2025-03-10 09:00:00'),
(3, 3, 'luismartinez', 'password789', '2025-03-10 10:15:00'),
(4, 4, 'marialopez', 'password321', '2025-03-10 11:45:00'),
(5, 5, 'javierrodriguez', 'password654', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Direcciones
INSERT INTO Direcciones (id_persona, pais, ciudad, calle, numero, codigo_postal, created) VALUES
(1, 'Chile', 'Santiago', 'Avenida Providencia', '1234', '7500000', '2025-03-10 08:30:00'),
(2, 'Argentina', 'Buenos Aires', 'Calle Falsa', '5678', 'C1000', '2025-03-10 09:00:00'),
(3, 'Perú', 'Lima', 'Avenida Javier Prado', '1357', '15073', '2025-03-10 10:15:00'),
(4, 'Colombia', 'Bogotá', 'Carrera 10', '2468', '110231', '2025-03-10 11:45:00'),
(5, 'México', 'Ciudad de México', 'Avenida Reforma', '3690', '06500', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Destinos
INSERT INTO Destinos (nombre_destino, pais, ciudad, descripcion, created) VALUES
('Rio de Janeiro', 'Brasil', 'Rio de Janeiro', 'Famoso por sus playas y el Cristo Redentor', '2025-03-10 08:30:00'),
('Madrid', 'España', 'Madrid', 'Capital de España, conocida por su cultura y gastronomía', '2025-03-10 09:00:00'),
('Londres', 'Reino Unido', 'Londres', 'Conocida por sus monumentos históricos y su cultura diversa', '2025-03-10 10:15:00'),
('Nueva York', 'EE.UU.', 'Nueva York', 'Ciudad globalmente reconocida por sus rascacielos y entretenimiento', '2025-03-10 11:45:00'),
('Tokio', 'Japón', 'Tokio', 'Una ciudad de alta tecnología y cultura tradicional', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Horarios
INSERT INTO Horarios (hora_salida, hora_regreso, created) VALUES
('08:00:00', '12:00:00', '2025-03-10 08:30:00'),
('09:00:00', '13:00:00', '2025-03-10 09:00:00'),
('10:00:00', '14:00:00', '2025-03-10 10:15:00'),
('11:00:00', '15:00:00', '2025-03-10 11:45:00'),
('12:00:00', '16:00:00', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Vuelos
INSERT INTO Vuelos (id_destino, id_horario, numero_vuelo, descripcion, created) VALUES
(1, 1, 'BR123', 'Vuelo directo a Rio de Janeiro', '2025-03-10 08:30:00'),
(2, 2, 'ES456', 'Vuelo directo a Madrid', '2025-03-10 09:00:00'),
(3, 3, 'UK789', 'Vuelo directo a Londres', '2025-03-10 10:15:00'),
(4, 4, 'US101', 'Vuelo directo a Nueva York', '2025-03-10 11:45:00'),
(5, 5, 'JP112', 'Vuelo directo a Tokio', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Reservas
INSERT INTO Reservas (id_usuario, id_vuelo, fecha_reserva, created) VALUES
(1, 1, '2025-03-09 14:00:00', '2025-03-10 08:30:00'),
(2, 2, '2025-03-09 15:00:00', '2025-03-10 09:00:00'),
(3, 3, '2025-03-09 16:00:00', '2025-03-10 10:15:00'),
(4, 4, '2025-03-09 17:00:00', '2025-03-10 11:45:00'),
(5, 5, '2025-03-09 18:00:00', '2025-03-10 12:00:00');

-- Insertar datos en la tabla Transportes
INSERT INTO Transportes (tipo_transporte, nombre_transporte, descripcion, created) VALUES
('Autobús', 'Autobús Turístico', 'Autobús cómodo para transporte de pasajeros en ciudad', '2025-03-10 08:30:00'),
('Avión', 'Avión de línea', 'Avión comercial para vuelos nacionales e internacionales', '2025-03-10 09:00:00'),
('Tren', 'Tren rápido', 'Tren de alta velocidad para traslados dentro de Europa', '2025-03-10 10:15:00'),
('Barco', 'Ferry', 'Ferry para viajes entre islas', '2025-03-10 11:45:00'),
('Taxi', 'Taxi privado', 'Taxi para traslados rápidos dentro de la ciudad', '2025-03-10 12:00:00');

-- Insertar datos en la tabla ViajesTransportes
INSERT INTO ViajesTransportes (id_viaje, id_transporte) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
