/*Tarea:
Crear rocedimientos almacenados para insertar datos en tabla categoria.
-Borrar un campo de forma lógica
-Mostrar datos activos
-Mostrar datos todos los datos

Todo sesto usando procedimientos almacenados (DELIMITER, BEGIN, END, parámetros IN)
*/

/* =========================
   1) Base de datos
   ========================= */
DROP DATABASE IF EXISTS tienda_demo;
CREATE DATABASE tienda_demo;
USE tienda_demo;

/* =========================
   2) Tablas
   ========================= */
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  nombre     VARCHAR(100) NOT NULL,
  deleted    TINYINT(1) NOT NULL DEFAULT 0,   -- 0=activo, 1=borrado lógico
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE producto (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  nombre       VARCHAR(120) NOT NULL,
  precio       DECIMAL(10,2) NOT NULL,
  categoria_id INT NOT NULL,
  deleted      TINYINT(1) NOT NULL DEFAULT 0, -- 0=activo, 1=borrado lógico
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


--Insertar datos de prueba, minimo 10 categorias
INSERT INTO categoria(nombre) VALUES
    ('Bebidas'), ('Snacks'), ('Limpieza'), ('Lácteos'), ('Carnes'), ('Frutas'), ('Verduras'), ('Panadería'), ('Congelados'), ('Higiene');

--Instertar datos de prueba, minimo 20 por categoria
INSERT INTO producto(nombre, precio, categoria_id) VALUES
    ('Coca Cola', 1.50, 1), ('Pepsi', 1.40, 1), ('Fanta', 1.30, 1), ('Sprite', 1.20, 1), ('Agua Mineral', 0.80, 1),
    ('Papas Fritas', 2.00, 2), ('Galletas', 1.80, 2), ('Chocolates', 2.50, 2), ('Frutos Secos', 3.00, 2), ('Palomitas', 1.70, 2),
    ('Detergente', 4.00, 3), ('Jabón Líquido', 3.50, 3), ('Limpiador Multiusos', 2.80, 3), ('Esponjas', 1.20, 3), ('Guantes de Limpieza', 1.50, 3),
    ('Leche', 0.90, 4), ('Yogur', 1.10, 4), ('Queso', 2.20, 4), ('Mantequilla', 1.80, 4), ('Crema de Leche', 1.60, 4),
    ('Pollo', 5.00, 5), ('Carne de Res', 7.00, 5), ('Cerdo', 6.00, 5), ('Pescado', 8.00, 5), ('Jamón', 4.50, 5),
    ('Manzanas', 2.50, 6), ('Plátanos', 1.80, 6), ('Naranjas', 2.20, 6), ('Uvas', 3.00, 6), ('Fresas', 2.80, 6),
    ('Lechuga', 1.50, 7), ('Tomates', 2.00, 7), ('Zanahorias', 1.20, 7), ('Cebollas', 1.30, 7), ('Pepinos', 1.40, 7),
    ('Pan Integral', 2.00, 8), ('Pan Blanco', 1.80, 8), ('Baguette', 2.50, 8), ('Croissants', 3.00, 8), ('Muffins', 2.20, 8),
    ('Pizza Congelada', 5.00, 9), ('Helado', 4.00, 9), ('Vegetales Congelados', 3.50, 9), ('Papas Fritas Congeladas', 2.80, 9), ('Mariscos Congelados', 6.00, 9),
    ('Champú', 3.00, 10), ('Acondicionador', 3.50, 10), ('Jabón de Baño', 2.20, 10), ('Pasta Dental', 1.80, 10), ('Desodorante', 2.50, 10);

/* =========================
   3) Procedimientos
    ========================= */

/*Crear rocedimientos almacenados para insertar datos en tabla categoria*/
DELIMITER //
CREATE PROCEDURE sp_categoria_insertar(
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO categoria(nombre, deleted)
    VALUES (p_nombre, 0);
END//
DELIMITER ;
CALL sp_categoria_insertar('Bebidas Energéticas');
CALL sp_categoria_insertar('Snacks Saludables');

--Verificar inserciones de las Inserciones más recientes
SELECT * FROM categoria ORDER BY id DESC LIMIT 5;

--Crear procedimientos almacenados para Borrar un campo de forma lógica.
DELIMITER //
CREATE PROCEDURE sp_categoria_borrar_logico(
    IN p_id INT
)
BEGIN
    UPDATE categoria
    SET deleted = 1
    WHERE id = p_id;
END//
DELIMITER ;

--Crear procedimientos almacenados para Mostrar datos activos
DELIMITER //
CREATE PROCEDURE sp_categoria_listar_activos()
BEGIN
    SELECT * FROM categoria
    WHERE deleted = 0;
END//
DELIMITER ;

--Crear procedimientos almacenados para Mostrar datos todos los datos
DELIMITER //
CREATE PROCEDURE sp_categoria_listar_todos()
BEGIN
    SELECT * FROM categoria;
END//
DELIMITER ;

CALL sp_categoria_listar_activos();
CALL sp_categoria_borrar_logico(3);
CALL sp_categoria_listar_activos();

--Seleccionar borrado lógico
SELECT * FROM categoria WHERE deleted = 1;
