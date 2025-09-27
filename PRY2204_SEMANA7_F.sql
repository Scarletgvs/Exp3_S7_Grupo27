
DROP SEQUENCE seq_comuna;
DROP SEQUENCE seq_compania;

DROP TABLE titulacion CASCADE CONSTRAINTS;
DROP TABLE dominio CASCADE CONSTRAINTS;
DROP TABLE personal CASCADE CONSTRAINTS;
DROP TABLE compania CASCADE CONSTRAINTS;
DROP TABLE idioma CASCADE CONSTRAINTS;
DROP TABLE titulo CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;
DROP TABLE genero CASCADE CONSTRAINTS;
DROP TABLE estado_civil CASCADE CONSTRAINTS;

CREATE TABLE REGION (
id_region NUMBER(2) PRIMARY KEY,
nombre_region VARCHAR2(25) NOT NULL
);

CREATE TABLE COMUNA (
id_comuna NUMBER(5),
cod_region NUMBER(2),
comuna_nombre VARCHAR2(25) NOT NULL,
CONSTRAINT comuna_pk PRIMARY KEY (id_comuna, cod_region),
CONSTRAINT comuna_fk_region FOREIGN KEY (cod_region) REFERENCES region(id_region)
);

CREATE TABLE GENERO(
id_genero NUMBER(2) PRIMARY KEY,
desc_genero VARCHAR2(25) NOT NULL
);

CREATE TABLE ESTADO_CIVIL(
id_estado_civil NUMBER(2) PRIMARY KEY,
desc_est_civil VARCHAR2(25) NOT NULL
);

CREATE TABLE TITULO (
id_titulo VARCHAR2(3) PRIMARY KEY,
desc_titulo VARCHAR2(60) NOT NULL
);

CREATE TABLE IDIOMA (
id_idioma NUMBER(3) PRIMARY KEY,
nombre_idioma VARCHAR2(30) NOT NULL
);

CREATE TABLE COMPANIA(
id_empresa NUMBER(2) PRIMARY KEY,
nombre_empresa VARCHAR2(25) NOT NULL UNIQUE,
calle VARCHAR2(50) NOT NULL,
numeracion NUMBER(5) NOT NULL,
renta_promedio NUMBER(10) NOT NULL,
pct_aumento NUMBER(4,3),
cod_comuna NUMBER(5) NOT NULL,
cod_region NUMBER(2) NOT NULL,
CONSTRAINT compania_fk_comuna FOREIGN KEY (cod_comuna, cod_region) REFERENCES comuna(id_comuna, cod_region)
);


CREATE TABLE PERSONAL(
rut_persona NUMBER(8) PRIMARY KEY,
dv_persona CHAR(1) NOT NULL,
primer_nombre VARCHAR2(25) NOT NULL,
segundo_nombre VARCHAR2(25),
primer_apellido VARCHAR2(25) NOT NULL,
segundo_apellido VARCHAR2(25),
fecha_contratacion DATE NOT NULL,
fecha_nacimiento DATE NOT NULL,
email VARCHAR2(50),
calle VARCHAR2(50) NOT NULL,
numeracion NUMBER(5) NOT NULL,
sueldo NUMBER(10) NOT NULL,
cod_comuna NUMBER(5) NOT NULL,
cod_region NUMBER(2) NOT NULL,
cod_genero NUMBER(2) NOT NULL,
cod_estado_civil NUMBER(2) NOT NULL,
cod_empresa NUMBER(2) NOT NULL,
encargado_rut NUMBER(8),
CONSTRAINT personal_fk_compania FOREIGN KEY (cod_empresa) REFERENCES compania(id_empresa),
CONSTRAINT personal_fk_comuna FOREIGN KEY (cod_comuna, cod_region) REFERENCES comuna(id_comuna, cod_region),
CONSTRAINT personal_fk_estado_civil FOREIGN KEY (cod_estado_civil) REFERENCES estado_civil(id_estado_civil),
CONSTRAINT personal_fk_genero FOREIGN KEY (cod_genero) REFERENCES genero(id_genero),
CONSTRAINT personal_personal_fk FOREIGN KEY (encargado_rut) REFERENCES personal(rut_persona)
);

CREATE TABLE dominio (
id_idioma NUMBER(3),
persona_rut NUMBER(8),
nivel VARCHAR2(25) NOT NULL,
CONSTRAINT dominio_pk PRIMARY KEY (id_idioma, persona_rut),
CONSTRAINT dominio_fk_idioma FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
CONSTRAINT dominio_fk_personal FOREIGN KEY (persona_rut) REFERENCES personal(rut_persona)
);

CREATE TABLE titulacion (
cod_titulo VARCHAR2(3),
persona_rut NUMBER(8),
fecha_titulacion DATE NOT NULL,
CONSTRAINT titulacion_pk PRIMARY KEY (cod_titulo, persona_rut),
CONSTRAINT titulacion_fk_personal FOREIGN KEY (persona_rut) REFERENCES personal(rut_persona),
CONSTRAINT titulacion_fk_titulo FOREIGN KEY (cod_titulo) REFERENCES titulo(id_titulo)
);

ALTER TABLE personal ADD CONSTRAINT uk_personal_email UNIQUE (email);

ALTER TABLE personal ADD CONSTRAINT ck_personal_dv CHECK (dv_persona IN ('0','1','2','3','4','5','6','7','8','9','K'));

ALTER TABLE personal ADD CONSTRAINT ck_personal_sueldo CHECK (sueldo >= 450000);

CREATE SEQUENCE seq_comuna START WITH 1101 INCREMENT BY 6;

CREATE SEQUENCE seq_compania START WITH 10 INCREMENT BY 5;

INSERT INTO region (id_region, nombre_region) VALUES (1, 'Arica y Parinacota');
INSERT INTO region (id_region, nombre_region) VALUES (2, 'Tarapacá');
INSERT INTO region (id_region, nombre_region) VALUES (3, 'Antofagasta');
INSERT INTO region (id_region, nombre_region) VALUES (4, 'Atacama');
INSERT INTO region (id_region, nombre_region) VALUES (5, 'Coquimbo');
INSERT INTO region (id_region, nombre_region) VALUES (6, 'Valparaíso');
INSERT INTO region (id_region, nombre_region) VALUES (7, 'Metropolitana');
INSERT INTO region (id_region, nombre_region) VALUES (8, 'Libertador B.O.');
INSERT INTO region (id_region, nombre_region) VALUES (9, 'Maule');
INSERT INTO region (id_region, nombre_region) VALUES (10, 'Ñuble');
INSERT INTO region (id_region, nombre_region) VALUES (11, 'Biobío');
INSERT INTO region (id_region, nombre_region) VALUES (12, 'Araucanía');
INSERT INTO region (id_region, nombre_region) VALUES (13, 'Los Ríos');
INSERT INTO region (id_region, nombre_region) VALUES (14, 'Los Lagos');
INSERT INTO region (id_region, nombre_region) VALUES (15, 'Aysén');
INSERT INTO region (id_region, nombre_region) VALUES (16, 'Magallanes');


INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1101, 7, 'Santiago');
INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1107, 7, 'Providencia');
INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1113, 7, 'Las Condes');
INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1119, 6, 'Valparaíso');
INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1125, 6, 'Viña del Mar');
INSERT INTO comuna (id_comuna, cod_region, comuna_nombre) VALUES (1131, 11, 'Concepción');

INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (25, 'Español');
INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (28, 'Inglés');
INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (31, 'Francés');
INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (34, 'Alemán');
INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (37, 'Portugués');
INSERT INTO idioma (id_idioma, nombre_idioma) VALUES (40, 'Italiano');

INSERT INTO genero (id_genero, desc_genero) VALUES (1, 'Masculino');
INSERT INTO genero (id_genero, desc_genero) VALUES (2, 'Femenino');
INSERT INTO genero (id_genero, desc_genero) VALUES (3, 'Otro');

INSERT INTO estado_civil (id_estado_civil, desc_est_civil) VALUES (1, 'Soltero');
INSERT INTO estado_civil (id_estado_civil, desc_est_civil) VALUES (2, 'Casado');
INSERT INTO estado_civil (id_estado_civil, desc_est_civil) VALUES (3, 'Divorciado');
INSERT INTO estado_civil (id_estado_civil, desc_est_civil) VALUES (4, 'Viudo');
INSERT INTO estado_civil (id_estado_civil, desc_est_civil) VALUES (5, 'Conviviente Civil');

INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('ADM', 'Administrador de Empresas');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('CON', 'Contador Auditor');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('ING', 'Ingeniero Comercial');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('MKT', 'Ingeniero en Marketing');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('FIN', 'Ingeniero Financiero');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('INF', 'Ingeniero Informático');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('SIS', 'Analista de Sistemas');
INSERT INTO titulo (id_titulo, desc_titulo) VALUES ('BD', 'Administrador de BD');


INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region)
VALUES (seq_compania.NEXTVAL, 'Carpenter Retail', 'Av. Principal', 123, 550000, 0.100, 1101, 7);

INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region)
VALUES (seq_compania.NEXTVAL, 'Carpenter Logistics', 'Puerto', 456, 620000, 0.120, 1119, 6);

INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region)
VALUES (seq_compania.NEXTVAL, 'Carpenter Foods', 'Alameda', 789, 480000, 0.080, 1131, 11);

INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region)
VALUES (seq_compania.NEXTVAL, 'Carpenter Tech', 'Tecnológica', 321, 750000, 0.150, 1107, 7);

INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region)
VALUES (seq_compania.NEXTVAL, 'Carpenter Mining', 'Minera', 654, 680000, 0.110, 1125, 6);


INSERT INTO personal (rut_persona, dv_persona, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
                     fecha_contratacion, fecha_nacimiento, email, calle, numeracion, sueldo, 
                     cod_comuna, cod_region, cod_genero, cod_estado_civil, cod_empresa, encargado_rut)
VALUES (12345678, '9', 'Juan', 'Carlos', 'Pérez', 'González', DATE '2020-03-15', DATE '1985-07-20', 
        'juan.perez@carpenter.cl', 'Av. Siempre Viva', 742, 850000, 1101, 7, 1, 2, 10, NULL);

INSERT INTO personal (rut_persona, dv_persona, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, 
                     fecha_contratacion, fecha_nacimiento, email, calle, numeracion, sueldo, 
                     cod_comuna, cod_region, cod_genero, cod_estado_civil, cod_empresa, encargado_rut)
VALUES (23456789, '5', 'María', 'Isabel', 'García', 'López', DATE '2019-08-10', DATE '1990-11-05', 
        'maria.garcia@carpenter.cl', 'Calle Falsa', 123, 720000, 1119, 6, 2, 1, 15, 12345678);
        
INSERT INTO dominio (id_idioma, persona_rut, nivel) VALUES (25, 12345678, 'Nativo');
INSERT INTO dominio (id_idioma, persona_rut, nivel) VALUES (28, 12345678, 'Avanzado');
INSERT INTO dominio (id_idioma, persona_rut, nivel) VALUES (25, 23456789, 'Nativo');
INSERT INTO dominio (id_idioma, persona_rut, nivel) VALUES (31, 23456789, 'Intermedio');

INSERT INTO titulacion (cod_titulo, persona_rut, fecha_titulacion) VALUES ('ING', 12345678, DATE '2010-12-20');
INSERT INTO titulacion (cod_titulo, persona_rut, fecha_titulacion) VALUES ('ADM', 23456789, DATE '2015-07-15');

SELECT 
nombre_empresa AS "Nombre Empresa",
calle || ' ' || numeracion || ', ' || comuna_nombre AS "Dirección",
renta_promedio AS "Renta Promedio",
renta_promedio * (1 + pct_aumento) AS "Renta con Aumento"
FROM compania c
JOIN comuna co ON c.cod_comuna = co.id_comuna AND c.cod_region = co.cod_region
ORDER BY "Renta Promedio" DESC, "Nombre Empresa" ASC;

SELECT 
id_empresa AS "ID Empresa",
nombre_empresa AS "Nombre Empresa",
renta_promedio AS "Renta Promedio Actual",
(pct_aumento + 0.15) AS "Porcentaje Aumentado",
renta_promedio * (1 + (pct_aumento + 0.15)) AS "Renta Promedio Incrementada"
FROM compania
ORDER BY "Renta Promedio Actual" ASC, "Nombre Empresa" DESC;

SELECT 'Ejecutado correctamente' AS resultado FROM dual;
SELECT COUNT(*) AS total_tablas FROM user_tables;

