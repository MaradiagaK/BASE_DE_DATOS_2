alter session set "_oracle_script"=true;
----------------------------------------------
-- CREAR USUARIO
----------------------------------------------
CREATE USER TAREA1 IDENTIFIED BY 123;

----------------------------------------------
-- DAR PERMISOS
----------------------------------------------
GRANT CONNECT, RESOURCE, DBA TO TAREA1;
GRANT UNLIMITED TABLESPACE TO TAREA1;

----------------------------------------------
-- CREAR TABLAS
----------------------------------------------
CREATE TABLE HOTEL(
    cod_hotel varchar (5) primary key not null,
    nombre_hotel varchar (10) not null,
    direccion_hotel varchar (20) not null
)

CREATE TABLE CLIENTE(
    id_cliente varchar (8) primary key not null,
    nombre_cliente varchar (30) not null,
    telefono_cliente varchar (8) not null
)

CREATE TABLE RESERVA(
    id_cliente_cliente varchar (8) not null,
    cod_hotel_hotel varchar (5) not null,
    fecha_in date not null,
    fecha_out date not null,
    cant_personas number(2) default 0, --VALOR 0 POR DEFECTO
    FOREIGN KEY (id_cliente_cliente) REFERENCES CLIENTE (id_cliente),
    FOREIGN KEY (cod_hotel_hotel) REFERENCES HOTEL (cod_hotel)
)

CREATE TABLE AEROLINEA (
    cod_aerolinea varchar (5) primary key not null,
    descuento varchar(2) not null
)

CREATE TABLE BOLETO(
    cod_boleto varchar (5) primary key not null,
    n_vuelo varchar (8) not null,
    fecha_vuelo date not null,
    destino varchar (10) not null,
    cod_aerolinea_aereolinea varchar (5),
    id_cliente_cliente varchar (8) not null,
    FOREIGN KEY (cod_aerolinea_aereolinea) REFERENCES
    AEROLINEA(cod_aerolinea),
    FOREIGN KEY (id_cliente_cliente) REFERENCES
    CLIENTE(id_cliente)
)

----------------------------------------------
-- INSERCION DE DATOS
----------------------------------------------

INSERT INTO HOTEL VALUES('001', 'HOTEL 1', 'Mexico')
INSERT INTO HOTEL VALUES('002', 'HOTEL 2', 'Guatemala')
INSERT INTO HOTEL VALUES('003', 'HOTEL 1', 'Panama')

INSERT INTO AEROLINEA VALUES('111', '12')
INSERT INTO AEROLINEA VALUES('222', '15')
INSERT INTO AEROLINEA VALUES('333', '11')
INSERT INTO AEROLINEA VALUES('444', '5')
INSERT INTO AEROLINEA VALUES('555', '5')


INSERT INTO CLIENTE VALUES('12345678', 'Kelly Maradiaga', '31553944')
INSERT INTO CLIENTE VALUES('11111111', 'Sonia Rodriguez', '32445874')


INSERT INTO BOLETO VALUES('AAAA1', '22C', '25-12-22', 'Mexico', '111', '12345678')
INSERT INTO BOLETO VALUES('AAAA2', '15D', '08-10-23', 'Guatemala', '222', '12345678')


INSERT INTO RESERVA VALUES ('11111111', '001', '12-02-23', '16-12-23', 5)
INSERT INTO RESERVA VALUES ('12345678', '001', '12-02-23', '16-12-23', default)

----------------------------------------------
-- RESTRICCION DE PAISES
----------------------------------------------

ALTER TABLE BOLETO ADD CONSTRAINT ck_destino check (destino in('Mexico', 'Guatemala', 'Panama'))

----------------------------------------------
-- RESTRICCION DE PAISES
----------------------------------------------

ALTER TABLE AEROLINEA ADD CONSTRAINT ck_descuento
check (descuento >= 10)

