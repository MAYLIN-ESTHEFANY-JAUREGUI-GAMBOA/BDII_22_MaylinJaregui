/*ACTIVIDAD 1*/

/* Eliminamos la base de datos si existe*/
DROP DATABASE IF EXISTS db_SalesClothes 
GO

/*Creamos la base de datos 'db_SalesClothes'*/
CREATE DATABASE db_SalesClothes
GO

/*Ponemos en uso la base de datos 'db_SalesClothes'*/
USE db_SalesClothes
GO

/*Configuramos el idioma 'español' en el servidor*/
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Configuramos el formato de fecha en dmy en el servidor*/
SET DATEFORMAT dmy
GO

 /*Borrar tablas*/
DROP TABLE IF EXISTS seller
GO

/*Crear la tabla 'client'*/
CREATE TABLE client (
    id INT IDENTITY(1,1) PRIMARY KEY, /*El campo 'id' es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.*/
    type_document CHAR(3) NOT NULL,
    number_document CHAR(15) NOT NULL,
    names VARCHAR(60) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    email VARCHAR(80) NOT NULL,
    cell_phone CHAR(9) NOT NULL,
    birthdate DATE NOT NULL,
    active BIT DEFAULT 1, /*El campo 'active' tendrá como valor predeterminado 1, que significa que el cliente está activo.*/
)
 

/* Restricciones para la tabla 'client'*/
/*El campo 'type_document' sólo puede admitir datos como DNI ó CNE*/
ALTER TABLE client
   ADD CONSTRAINT pjy_type_document CHECK (type_document IN ('DNI', 'CNE')) 

/*El campo 'number_document' sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.*/
ALTER TABLE client
   ADD CONSTRAINT pjy_number_document CHECK (number_document LIKE '%[0-9]%' AND (type_document = 'DNI' AND LEN(number_document) = 8 OR type_document = 'CNE' AND LEN(number_document) = 9))
    
/*El el campo 'email' sólo permite correos electrónicos válidos, por ejemplo: mario@gmail.com*/
ALTER TABLE client
   ADD CONSTRAINT pjy_email CHECK (email LIKE '%@%.%')  

/*El campo 'cell_phone' acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.*/
ALTER TABLE client
   ADD CONSTRAINT pjy_cell_phone CHECK (cell_phone LIKE '%[0-9]%' AND LEN(cell_phone) = 9) 

/*El campo 'birthdate' sólo permite la fecha de nacimiento de clientes mayores de edad.*/
ALTER TABLE client
   ADD CONSTRAINT pjy_birthdate CHECK (DATEDIFF(yy, birthdate, GETDATE()) >= 18) 


/*Crear la tabla 'seller'*/
CREATE TABLE seller (
    id int IDENTITY(1,1) PRIMARY KEY,/*El campo 'id' es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno*/
    type_document char(3) NOT NULL, 
    number_document char(15) NOT NULL, 
    names varchar(60) NOT NULL, 
    last_name varchar(90) NOT NULL,
    salary decimal(8,2) NOT NULL DEFAULT 1025, /*El campo 'salary' tiene como valor predeterminado 1025*/
    cell_phone char(9) NOT NULL,
    email varchar(80) NOT NULL, 
    active bit NOT NULL DEFAULT 1 /*El campo 'active' tendrá como valor predeterminado 1, que significa que el cliente está activo*/
);


/* Restricciones para la tabla 'seller'*/
/*El campo 'type_document' sólo puede admitir datos como DNI ó CNE*/
ALTER TABLE seller
 ADD CONSTRAINT QTC_type_document_seller CHECK (type_document IN ('DNI', 'CNE'))

/*El campo 'number_document' sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE*/
ALTER TABLE seller
 ADD CONSTRAINT QTC_number_document_seller CHECK (
    (type_document = 'DNI' AND LEN(number_document) = 8 AND number_document NOT LIKE '%[^0-9]%')
    OR (type_document = 'CNE' AND LEN(number_document) = 9 AND number_document NOT LIKE '%[^0-9]%'))

/*El campo 'cell_phone' acepta solamente 9 dígitos numéricos, por ejemplo: 997158238*/
ALTER TABLE seller
 ADD CONSTRAINT QTC_cell_phone_seller CHECK (cell_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

/*El el campo 'email' sólo permite correos electrónicos válidos, por ejemplo: roxana@gmail.com*/
ALTER TABLE seller
 ADD CONSTRAINT QTC_email_seller CHECK (
    email LIKE '%@%.%' AND email NOT LIKE '%[^a-zA-Z0-9@._-]%')

ALTER TABLE seller/*ELIMINAR*/ 
 DROP CONSTRAINT QTC_number_document_seller 
GO


/*Crear la tabla 'clothes' y sus restricciones '*/
CREATE TABLE clothes (
  id int PRIMARY KEY IDENTITY(1,1), /*El campo 'id' es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno*/
  descriptions varchar(60),
  brand varchar(60),
  amount int,
  size varchar(10),
  price decimal(8,2),
  active bit DEFAULT 1 /*El campo' active' tendrá como valor predeterminado 1, que significa que el cliente está activo*/
);


/*Crear la tabla 'clothes' y sus restricciones '*/
CREATE TABLE sale (
    id int PRIMARY KEY IDENTITY(1,1),/*El campo 'id' es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno*/
    date_time datetime DEFAULT GETDATE(), /*El campo 'date_time' debe tener como valor predeterminado la fecha y hora del servidor*/
    seller_id int REFERENCES seller(id), /*Referencia a la 'tabla seller'*/
    client_id int REFERENCES client(id), /*Referencia a la 'tabla client'*/
    active bit DEFAULT 1 /*El campo 'active' tendrá como valor predeterminado 1, que significa que el cliente está activo*/
);


/* Crear la tabla sale_detail con la siguiente estructura:*/
CREATE TABLE sale_detail (
    id int IDENTITY(1,1) PRIMARY KEY,  /*Clave primaria para la tabla, autoincrementable*/
    sale_id int,  /*Clave foránea a la tabla sale*/
    clothes_id int, /*Clave foránea a la tabla clothes*/
    amount int,  /*Cantidad de ropa vendida*/
    CONSTRAINT FK_sale_detail_sale FOREIGN KEY (sale_id) REFERENCES sale (id), /*Restricción para la clave foránea sale_id*/
    CONSTRAINT FK_sale_detail_clothes FOREIGN KEY (clothes_id) REFERENCES clothes (id)  /*Restricción para la clave foránea clothes_id*/
);


/*Relación entre tabla client y tabla sale:*/
ALTER TABLE sale
ADD CONSTRAINT FK_sale_client_id
FOREIGN KEY (client_id) REFERENCES client(id)

/*Relación entre tabla seller y tabla sale:*/
ALTER TABLE sale
ADD CONSTRAINT FK_sale_seller_id
FOREIGN KEY (seller_id) REFERENCES seller(id)

/*Relación entre tabla sale y tabla sale_detail:*/
ALTER TABLE sale_detail
ADD CONSTRAINT FK_sale_detail_sale_id
FOREIGN KEY (sale_id) REFERENCES sale(id)

ALTER TABLE sale_detail
ADD CONSTRAINT FK_sale_detail_clothes_id
FOREIGN KEY (clothes_id) REFERENCES clothes(id)

/*Relación entre tabla clothes y tabla sale_detail:*/
ALTER TABLE sale_detail /*Eliminar*/
DROP CONSTRAINT FK_sale_detail_clothes;

ALTER TABLE sale_detail
ADD CONSTRAINT FK_sale_detail_clothes
FOREIGN KEY (clothes_id) REFERENCES clothes (id);
