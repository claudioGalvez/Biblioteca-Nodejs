CREATE DATABASE BIBLIOTECA;

USE BIBLIOTECA;

CREATE TABLE LIBROS (
    idBook INT(10) NOT NULL PRIMARY KEY,
    nombreBook VARCHAR(50) NOT NULL,
    editorial VARCHAR(50) NOT NULL,
    autor VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    cantidad INT(10) NOT NULL,
    disponibles INT(10) NOT NULL,
    precio INT(10) NOT NULL
);

ALTER TABLE LIBROS
    MODIFY idBook INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

DESCRIBE LIBROS;

CREATE TABLE ALUMNOS (
    id INT(11) NOT NULL PRIMARY KEY,
    userName VARCHAR(15) NOT NULL,
    password VARCHAR(60) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

ALTER TABLE ALUMNOS
    MODIFY id INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

DESCRIBE ALUMNOS;

CREATE TABLE COMPROBANTES (
    idComprobante INT (10) NOT NULL PRIMARY KEY,
    idCompBook INT(10) NOT NULL,
    idCompUser INT(11) NOT NULL,
    fecha DATE NOT NULL,
    importe INT(15) NOT NULL
);

ALTER TABLE COMPROBANTES
    MODIFY idComprobante INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE COMPROBANTES
    ADD CONSTRAINT fk_comprobante_1 FOREIGN KEY (idCompBook) REFERENCES LIBROS(idBook);

ALTER TABLE COMPROBANTES
    ADD CONSTRAINT fk_comprobante_2 FOREIGN KEY (idCompUser) REFERENCES ALUMNOS(id);

DESCRIBE COMPROBANTES;

CREATE TABLE PRESTAMOS (
    idActivity INT (10) NOT NULL PRIMARY KEY,
    idActBook INT(10) NOT NULL,
    idActUser INT(11) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    indicadorDevolucion CHAR NOT NULL
);

ALTER TABLE PRESTAMOS
    MODIFY idActivity INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE PRESTAMOS
    ADD CONSTRAINT fk_prestamos_1 FOREIGN KEY (idActBook) REFERENCES LIBROS(idBook);

ALTER TABLE PRESTAMOS
    ADD CONSTRAINT fk_prestamos_2 FOREIGN KEY (idActUser) REFERENCES ALUMNOS(id);

DESCRIBE PRESTAMOS;

CREATE TABLE LINKS (
    idLink INT (10) NOT NULL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    url VARCHAR(255) NOT NULL,
    descripcionLinks TEXT,
    idUserLinks INT(11),
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_user FOREIGN KEY (idUserLinks) REFERENCES ALUMNOS(id)
);

ALTER TABLE LINKS
    MODIFY idLink INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

DESCRIBE LINKS;
