CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Tabla TipoUsuario
CREATE TABLE TipoUsuario (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);

-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_tipo_usuario INT NOT NULL,
    FOREIGN KEY (id_tipo_usuario) REFERENCES TipoUsuario(id_tipo_usuario)
);

-- Tabla Categoria
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(100) NOT NULL,
    rut_proveedor VARCHAR(50) UNIQUE NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- Tabla Promoción
CREATE TABLE Promocion (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_promocion VARCHAR(100) NOT NULL,
    descuento DECIMAL(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Tabla intermedia ProductoPromocion
CREATE TABLE ProductoPromocion (
    id_producto INT NOT NULL,
    id_promocion INT NOT NULL,
    PRIMARY KEY (id_producto, id_promocion),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_pedido ENUM('Pendiente', 'Enviado', 'Entregado', 'Cancelado') NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Usuario(id_usuario)
);

-- Tabla intermedia DetallePedido
CREATE TABLE DetallePedido (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    metodo_pago ENUM('Tarjeta de Crédito', 'Tarjeta de Débito', 'PayPal', 'Transferencia Bancaria') NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Tabla Despacho
CREATE TABLE Despacho (
    id_despacho INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    direccion_entrega VARCHAR(255) NOT NULL,
    fecha_envio DATETIME,
    transportista VARCHAR(100),
    estado_despacho ENUM('En preparación', 'En tránsito', 'Entregado') NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Tabla Reseña
CREATE TABLE Reseña (
    id_reseña INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_reseña DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
