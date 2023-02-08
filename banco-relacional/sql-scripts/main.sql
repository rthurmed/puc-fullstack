DROP TABLE veiculos;
DROP TABLE pessoas;
DROP TABLE alunos;
DROP TABLE estados;
DROP TABLE cidades;

CREATE TABLE veiculos 
( 
    placa   CHAR(8), 
    ano     NUMBER(4), 
    km      NUMBER(6), 
    marca   VARCHAR(50), 
    modelo  VARCHAR(50) 
);

INSERT INTO veiculos
VALUES ('IJK-1212', 2022, 0, 'Chevrolet', 'Onix');

INSERT INTO veiculos
VALUES ('IJK-1312', 2020, 0, 'Chevrolet', 'Prisma');

INSERT INTO veiculos (placa, ano, km, marca, modelo)
VALUES ('IJM-1212', 2015, 1232, 'Volkswagen', 'Gol');

INSERT INTO veiculos (placa, ano, km, marca, modelo)
VALUES ('KMD-2134', 1999, 72405, 'Ford', 'Parati');

INSERT INTO veiculos (placa, ano, km, marca, modelo)
VALUES ('KOD-1212', 2006, 155, 'Ford', 'Mustang');

SELECT * FROM veiculos;

SELECT placa, ano, modelo
FROM veiculos
WHERE ano < 2022;

UPDATE veiculos
SET modelo = 'Cruze'
WHERE placa = 'IJK-1212';

SELECT * FROM veiculos;

-- somar 100 quilometros nos veiculos cujos anos são entre 2015 e 2021
UPDATE veiculos
SET km = km + 100
WHERE ano >= 2015 AND ano <= 2021;

SELECT * FROM veiculos;

SELECT count(*) FROM veiculos;

DELETE FROM veiculos WHERE placa = 'KMD-2134';

SELECT count(*) FROM veiculos;

SELECT placa, km
FROM veiculos
ORDER BY km;

SELECT placa, ano, km, marca
FROM veiculos
WHERE ano > 2000
ORDER BY marca, km DESC;

SELECT count(*) 
FROM veiculos
WHERE marca = 'Ford';

SELECT DISTINCT marca
FROM veiculos;

CREATE TABLE pessoas
(
    cpf         VARCHAR(20)     NOT NULL,
    nome        VARCHAR(150)    NOT NULL,
    idade       NUMBER(3)       NULL,
    endereco    VARCHAR(150)
);
-- endereco é null implicitamente

-- descreve a tabela
DESC pessoas;

INSERT INTO pessoas (cpf, nome, idade, endereco)
VALUES ('23213', 'Maria', 25, 'Rua A, 20');

INSERT INTO pessoas (cpf, nome, idade, endereco)
VALUES ('90890', 'Pedro', 25, 'Rua A, 20');

INSERT INTO pessoas (cpf, nome, idade, endereco)
VALUES ('29412', 'Carlos', NULL, NULL);

INSERT INTO pessoas (cpf, nome, idade, endereco)
VALUES ('29444', 'Alice', 80, NULL);

-- omitindo as colunas nulas
INSERT INTO pessoas (cpf, nome, endereco)
VALUES ('11444', 'Antonio', 'Rua B, 80');

SELECT * FROM pessoas;

SELECT * FROM pessoas
WHERE (idade IS NULL) OR (endereco IS NULL);

SELECT * FROM pessoas
WHERE nome LIKE 'A%';

SELECT * FROM pessoas
WHERE nome LIKE '%o%';

SELECT * FROM pessoas
WHERE nome LIKE '%Carlos%';

SELECT * FROM pessoas
WHERE nome LIKE 'Mari_';

SELECT * FROM pessoas
WHERE idade IN (25, 30, 40);

ALTER TABLE pessoas
ADD sexo CHAR(1);

SELECT * FROM pessoas;

ALTER TABLE pessoas
DROP COLUMN idade;

ALTER TABLE pessoas
ADD datanasc DATE NULL;

SELECT * FROM pessoas;

INSERT INTO pessoas (cpf, nome, datanasc, endereco)
VALUES ('12410', 'Roberto', '03-FEB-1980', 'Rua D, 80');

INSERT INTO pessoas (cpf, nome, datanasc, endereco)
VALUES ('15110', 'João Roberto', DATE '1980-03-30', 'Rua F, 81');

SELECT * FROM pessoas;

SELECT to_char(SYSDATE, 'MONTH, DD, YYYY, HH24:MI:SS')
FROM dual;

SELECT nome, to_char(datanasc, 'MONTH, DD, YYYY')
FROM pessoas;

INSERT INTO pessoas (cpf, nome, datanasc, endereco)
VALUES ('23333', 'Beto', to_date('25-FEB-1979 21:36:28', 'DD-MON-YYYY HH24:MI:SS'), 'Rua E, 80');

-- printa amanhã
SELECT SYSDATE + 1
FROM dual;

-- ALUNOS

CREATE TABLE alunos
(
    nroMatricula VARCHAR(10) NOT NULL,
    cpf VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    anoIngresso NUMBER(4) NOT NULL,
    endereco VARCHAR(150) NULL,
    sexo CHAR(1) NOT NULL,
    CONSTRAINT PK_ALUNOS PRIMARY KEY (nroMatricula),
    CONSTRAINT AK1_ALUNOS UNIQUE (cpf),
    CONSTRAINT AK2_ALUNOS UNIQUE (email)
);

ALTER TABLE alunos
ADD CONSTRAINT CK_AnoIngr CHECK (anoIngresso > 2000) ;

-- ESTADOS E CIDADES

CREATE TABLE estados
(
    uf CHAR(2) NOT NULL,
    nome VARCHAR2(40) NOT NULL,
    regiao CHAR(2) NOT NULL,
    CONSTRAINT PK_ESTADOS PRIMARY KEY (uf)
);

CREATE TABLE cidades
(
    cod_cidade NUMBER(4) NOT NULL,
    nome VARCHAR2(60) NOT NULL,
    uf CHAR(2) NOT NULL,
    CONSTRAINT PK_CIDADES PRIMARY KEY (cod_cidade)
);

ALTER TABLE CIDADES
ADD
(
    CONSTRAINT FK_EST_CID
    FOREIGN KEY (uf)
    REFERENCES ESTADOS (uf)
);


