-- EXERCICIO
-- Crie uma tabela MEDICOS com os campos 'crm', 'nome' e 'especialidade'.
-- - Crie uma tabela PACIENTES com os campos 'cpf', 'nome' e 'sexo'.
-- - Crie uma tabela chamada MEDICOSPACIENTES com os campos 'crm' e 'cpf'. Esta tabela servirá para saber quaismédicos tratam de quais pacientes (e, por consequência, quais pacientes são atendidos por quais médicos).
-- - Defina uma FK entre MEDICOSPACIENTES.crm e MEDICOS.crm.
-- - Defina outra FK entre MEDICOSPACIENTES.cpf e PACIENTES.cpf.
-- - Qual será a chave primária da tabela MEDICOSPACIENTES?
-- - E se quiséssemos armazenar o histórico de consultas entre médicos e pacientes? Crie uma tabela de consultas, que contenha a data de cada consulta.

DROP TABLE medicos;
DROP TABLE pacientes;
DROP TABLE medicospacientes;
DROP TABLE consultas;

CREATE TABLE medicos
(
    crm CHAR(10) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(255),
    CONSTRAINT pk_medicos PRIMARY KEY (crm)
);

CREATE TABLE pacientes
(
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sexo CHAR(1) NOT NULL,
    CONSTRAINT pk_pacientes PRIMARY KEY (cpf)
);

CREATE TABLE medicospacientes
(
    crm CHAR(10) NOT NULL,
    cpf CHAR(11) NOT NULL,
    CONSTRAINT pk_medicospacientes PRIMARY KEY (crm, cpf)
);

ALTER TABLE medicospacientes ADD CONSTRAINT fk_mc_medicos FOREIGN KEY (crm) REFERENCES medicos(crm);
ALTER TABLE medicospacientes ADD CONSTRAINT fk_mc_pacientes FOREIGN KEY (cpf) REFERENCES pacientes(cpf);

CREATE TABLE consultas
(
    id INTEGER NOT NULL,
    crm CHAR(10) NOT NULL,
    cpf CHAR(11) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT pk_consultas PRIMARY KEY (id)
);

ALTER TABLE consultas ADD CONSTRAINT fk_consulta_mc_crm FOREIGN KEY (crm) REFERENCES medicospacientes(crm);
ALTER TABLE consultas ADD CONSTRAINT fk_consulta_mc_cpf FOREIGN KEY (cpf) REFERENCES medicospacientes(cpf);

