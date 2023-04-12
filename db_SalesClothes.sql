-- Si la base de datos ya existe la eliminamos --
DROP DATABASE IF EXISTS db_SalesClothes;

-- Crear base de datos Sales Clothes --
CREATE DATABASE db_SalesClothes;

-- Poner en uso la base de datos --
USE db_SalesClothes;


-- Crear la tabla client --
CREATE TABLE client (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    email varchar(80)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    birthdate date  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY  (id)
);

-- Ver estructura de tabla client --
EXEC sp_columns @table_name = 'client';

-- Listar tablas de la base de datos db_SalesClothes --
SELECT * FROM INFORMATION_SCHEMA.TABLES;

--  Crear la tabla sale --
CREATE TABLE sale (
    id int  NOT NULL,
    date_time datetime  NOT NULL,
    active bit  NOT NULL,
    client_id int  NOT NULL,
    seller_id int  NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);

-- Ver estructura de tabla sale --
EXEC sp_columns @table_name = 'sale';

-- Listar tablas de la base de datos db_SalesClothes --
SELECT * FROM INFORMATION_SCHEMA.TABLES;

--  Crear la tabla seller --
CREATE TABLE seller (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    salary decimal(8,2)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    email varchar(80)  NOT NULL,
    activo bit  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

-- Ver estructura de tabla seller --
EXEC sp_columns @table_name = 'seller';

-- Listar tablas de la base de datos db_SalesClothes --
SELECT * FROM INFORMATION_SCHEMA.TABLES;

--  Crear la tabla clothes --
CREATE TABLE clothes (
    id int  NOT NULL,
    description varchar(60)  NOT NULL,
    brand varchar(60)  NOT NULL,
    amount int  NOT NULL,
    size varchar(10)  NOT NULL,
    price decimal(8,2)  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

-- Ver estructura de tabla clothes --
EXEC sp_columns @table_name = 'clothes';

-- Listar tablas de la base de datos db_SalesClothes --
SELECT * FROM INFORMATION_SCHEMA.TABLES;

--  Crear la tabla sale_detail --
CREATE TABLE sale_detail (
    id int  NOT NULL,
    amount int  NOT NULL,
    sale_id int  NOT NULL,
    clothes_id int  NOT NULL,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

-- Ver estructura de tabla sale_detailt --
EXEC sp_columns @table_name = 'sale_detail';

-- Listar tablas de la base de datos db_SalesClothes --
SELECT * FROM INFORMATION_SCHEMA.TABLES;


-- Eliminar tabla client --
DROP TABLE client;

--Relaciones con la tabla sale con tabla client --
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

--Relaciones con la tabla sale con tabla seller --
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);

--Relaciones con la tabla sale_detail con tabla clothes --
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);

--Relaciones con la tabla sale_detail con tabla sale --
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

-- Ver relaciones creadas entre las tablas de la base de datos --
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

-- Eliminar una relación --
ALTER TABLE sale
	DROP CONSTRAINT sale_client
GO