--Campos de auditoria 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--Fecha de creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
ON UPDATE CURRENT_TIMESTAMP, --Fecha de actualización
created_by INT NOT NULL, -- Usuario que creó el registro
updated_by INT NOT NULL, -- Usuario que creó el registro
deleted BOOLEAN DEFAULT FALSE, -- Si es true, significa que el registro ha sido borrado

ALTER TABLE usuarios --Modificar tabla
--Agrega una restriccion (FK)
ADD CONSTRAINT fk_usuarios_tipo_usuario
--Añade reeencia (FK)
FOREIGN KEY (tipo_usuarios_id) REFERENCES 
tipo_usuario(id_tipo_usuario); --Añade referencia (FK)