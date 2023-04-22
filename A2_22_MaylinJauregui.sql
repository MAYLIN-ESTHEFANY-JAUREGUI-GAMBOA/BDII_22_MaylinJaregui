/*ACTIVIDAD 2*/

/* Eliminamos la base de datos si existe*/
DROP DATABASE IF EXISTS db_SalesClothes 
GO

/*Creamos la base de datos 'db_SalesClothes'*/
CREATE DATABASE db_SalesClothes;
GO

/*Ponemos en uso la base de datos 'db_SalesClothes'*/
USE db_SalesClothes;
GO

/*Configuramos el idioma 'español' en el servidor*/
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Configuramos el formato de fecha en dmy en el servidor*/
SET DATEFORMAT dmy
GO

/* Datos de la tabla client*/
/*Insertar registros en la tabla client*/
INSERT INTO client (type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES 
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperalese@gmail.com', '991692597', '2005-01-19'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavilae@gmail.com', '982514752', '1990-03-03'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '1995-10-03'),
('CNE', '352514789', 'Claudia Maria', 'Martínez Rodriguez', 'claudiamartinez@yahoo.com', '995522147', '1992-09-23'),
('CNE', '142536792', 'Mario Tadeo', 'Farfàn Castillo', 'mariotadeo@outlook.com', '973125478', '1997-11-25'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '1992-10-17'),
('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '1990-05-27'),
('CNE', '442233698', 'Rosario', 'Prada Velásquez', 'rosarioprada@outlook.com', '971144782', '1990-11-05');

SELECT * FROM client;

/*Insertar registros en la tabla client*/
/*Insertar los siguientes registros en la tabla seller:*/
/*id | type_document | number_document | names |   last_name  | salary  | cell_phone | email | active*/

/*Insertar datos en la tabla seller*/
INSERT INTO seller (type_document, number_document, names, last_name, salary, cell_phone, email)
VALUES 
('DNI', '11224578', 'Oscar', 'Paredes Flores', 1025.00, '985566251', 'oparedes@miempresa.com'),
('CNE', '889922365', 'Azucena', 'Valle Alcazar', 1025.00, '966338874', 'avalle@miempresa.com'),
('DNI', '44771123', 'Rosario', 'Huarca Tarazona', 1025.00, '933665521', 'rhuaraca@miempresa.com');

INSERT INTO clothes (descriptions, brand, amount, size, price)
VALUES
('Polo camisero Adidas', 'Adidas', 20, 'Medium', 40.50),
('Short playero Nike', 'Nike', 30, 'Medium', 55.50),
('Camisa sport Adams', 'Adams', 60, 'Large', 60.80),
('Camisa sport Adams', 'Adams', 70, 'Medium', 58.75),
('Buzo de verano Reebok', 'Reebok', 45, 'Small', 62.90),
('Pantalón Jean Lewis', 'Lewis', 35, 'Large', 73.60);


SELECT * FROM seller;
SELECT * FROM clothes;


/*Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI*/
SELECT * FROM client WHERE type_document = 'DNI';

/*Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com.*/
SELECT * FROM client WHERE email LIKE '%@outlook.com';

/*Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE.*/
SELECT * FROM seller WHERE type_document = 'CNE';

/*Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00*/
SELECT * FROM clothes WHERE price <= 55.00;

/*Listar todas las prendas de ropa (clothes) cuya marca sea Adams.*/
SELECT * FROM clothes WHERE brand = 'Adams';

/*Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id.*/
UPDATE client SET active = 0 WHERE id = 8;

/*Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id.*/
UPDATE seller SET active = 0 WHERE id = 1;

/*Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id*/
UPDATE clothes SET active = 0 WHERE id = 6;
