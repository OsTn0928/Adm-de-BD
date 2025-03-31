CREATE DATABASE FlightDB;
USE FlightDB;

CREATE TABLE Tipo_Usuarios (
    id_tipo_usuario INT PRIMARY KEY,
    nombre_tipo VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    id_tipo_usuario INT NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_tipo_usuario) REFERENCES Tipo_Usuarios(id_tipo_usuario)
);

CREATE TABLE Ubicaciones (
    id_ubicacion INT PRIMARY KEY,
    ciudad VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Aeropuertos (
    id_aeropuerto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    codigo_iata VARCHAR(10) UNIQUE NOT NULL,
    id_ubicacion INT NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion)
);

CREATE TABLE Vuelos (
    id_vuelo INT PRIMARY KEY,
    numero_vuelo VARCHAR(50) UNIQUE NOT NULL,
    aerolinea VARCHAR(255) NOT NULL,
    id_origen INT NOT NULL,
    id_destino INT NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_origen) REFERENCES Aeropuertos(id_aeropuerto),
    FOREIGN KEY (id_destino) REFERENCES Aeropuertos(id_aeropuerto)
);

CREATE TABLE Vuelos_Programados (
    id_vuelo_programado INT PRIMARY KEY,
    id_vuelo INT NOT NULL,
    fecha_hora_salida DATETIME NOT NULL,
    fecha_hora_llegada DATETIME NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_vuelo) REFERENCES Vuelos(id_vuelo)
);

CREATE TABLE Escalas (
    id_escala INT PRIMARY KEY,
    id_vuelo_programado INT NOT NULL,
    id_aeropuerto INT NOT NULL,
    fecha_hora_llegada DATETIME NOT NULL,
    fecha_hora_salida DATETIME NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_vuelo_programado) REFERENCES Vuelos_Programados(id_vuelo_programado),
    FOREIGN KEY (id_aeropuerto) REFERENCES Aeropuertos(id_aeropuerto)
);

CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_hora_reserva DATETIME NOT NULL,
    cantidad_pasajeros INT NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    estado_reserva VARCHAR(50) NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Reservas_Vuelos (
    id_reserva_vuelo INT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_vuelo_programado INT NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva),
    FOREIGN KEY (id_vuelo_programado) REFERENCES Vuelos_Programados(id_vuelo_programado)
);

CREATE TABLE Asientos (
    id_asiento INT PRIMARY KEY,
    id_reserva INT NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL UNIQUE,
    clase VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    CREATED DATETIME NOT NULL,
    MODIFIED DATETIME NOT NULL,
    DELETED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
);
