 -- 1) Crie o Banco de Dados conforme solicitado.
CREATE DATABASE uni_go_medgroup_ANDRESSA;
use uni_go_medgroup_ANDRESSA;

-- 2) Crie todas as tabelas acima exatamente como estão
CREATE TABLE Usuarios (
	id INT auto_increment primary key,
    nome VARCHAR(45),
    email VARCHAR(50),
    senha VARCHAR(45),
    tipo_usuario INT
);

CREATE TABLE Pacientes (
	id INT auto_increment primary key,
    usuarios_id INT,
    cpf VARCHAR(11),
    rg VARCHAR(45),
    telefone VARCHAR(45),
    data_nasc DATE,
    foreign key (usuarios_id) references Usuarios(id)
);

CREATE TABLE Especialidades(
	id INT auto_increment primary key,
    nome VARCHAR(45)
);

CREATE TABLE Clinicas (
	id INT auto_increment primary key,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    cep VARCHAR(45)
);

CREATE TABLE Medicos (
	id INT auto_increment primary key,
    crm VARCHAR(45),
    usuarios_id INT,
    clinicas_id INT,
    especialidades_id INT,
	foreign key (usuarios_id) references Usuarios(id),
    foreign key (clinicas_id) references Clinicas(id),
    foreign key (especialidades_id) references Especialidades(id)
);

CREATE TABLE Consultas_medicas (
	idconsulta_medica INT auto_increment primary key,
    data_consulta DATETIME,
    status INT,
    preco DECIMAL(10, 2),
    medicos_id INT,
    pacientes_id INT,
    foreign key (medicos_id) references Medicos(id),
    foreign key (pacientes_id) references Pacientes(id)
);

-- 3) Insira exatamente as mesmas informações de forma correta em todas as tabelas criadas.

INSERT INTO Usuarios(nome, email,  tipo_usuario, senha) VALUES
('Ligia', 'ligia@gmail.com', 1, '1234566'),
('Alexandre ', 'alexandre @gmail.com', 1, '123R72RA'),
('Fernando ', 'fernando @gmail.com', 1, 'WDFU82FS'),
('Henrique', 'henrique@gmail.com', 1, 'NUFsfg93'),
('João', 'joao@hotmail.com', 1, 'MFI98ed8F'),
('Bruno', 'bruno@gmail.com', 1, 'mIRU3j9'),
('Mariana', 'mariana@outlook.com', 1, 'mifU3IJF9'),
('Ricardo Lemos', 'ricardo.lemos@spmedicalgroup.com.br', 2, 'MVIV3f9J'),
('Roberto Possarle', 'roberto.possarle@spmedicalgroup.com.br', 2, 'sdfsgd747'),
('Helena Strada', 'helena.strada@spmedicalgroup.com.br', 2, 'fMFIOu3d');

INSERT INTO Pacientes(usuarios_id, cpf, rg, telefone, data_nasc) VALUES
(1, '94839859000', '303721200', '92997499363', '1983-10-13'),
(2, '73556944057', '442167921', '67993133836', '2001-07-23'),
(3, '16839938002', '192306169', '27983039237', '1978-10-10'),
(4, '14332654765', '100084990', '85993837455', '1985-10-13'),
(5, '91305348010', '248884566', '96997330446', '1975-08-27'),
(6, '79799299004', '476501684', '51981325898', '1972-03-21'),
(7, '13771913039', '104319094', '81985296053', '2018-03-05');

INSERT INTO Especialidades(nome) VALUES
('Acupuntura'),
('Anestesiologia'),
('Angiologia'),
('Cardiologia'),
('Cirurgião Cardiovascular'),
('Cirurgião Geral'),
('Dermatologista'),
('Urologista'),
('Pediatra'),
('Psiquiatra');

INSERT INTO Clinicas (nome, endereco, cep) VALUES
('Clinica A', 'Av. Universitária, 5520', '75083515');

INSERT INTO Medicos (crm, especialidades_id, clinicas_id, usuarios_id) VALUES
('54356SP', 2, 1, 8),
('53452GO', 5, 1, 9),
('65463SP', 10, 1, 10);

INSERT INTO Consultas_medicas (medicos_id, pacientes_id, data_consulta, status, preco) VALUES
(1, 3, '2019-01-20 15:00', 1, 400.00),
(2, 2, '2018-01-06 10:00', 2, 400.00),
(1, 2, '2019-02-07 11:00', 3, 400.00),
(3, 2, '2018-02-06 10:00', 2, 400.00),
(2, 1, '2019-02-07 11:00', 3, 400.00),
(2, 3, '2019-02-08 15:00', 1, 400.00),
(3, 1, '2019-02-09 11:00', 2, 400.00);

-- 4) Como você selecionaria todos os dados da tabela paciente?
SELECT * FROM Pacientes;

-- 5) Como você selecionaria todos os pacientes que têm o nome "João"?
SELECT u.id, u.nome
FROM Pacientes p
INNER JOIN Usuarios u ON p.usuarios_id = u.id
WHERE u.nome = 'João';

-- 6) Como você selecionaria todas as consultas médicas agendadas para uma data específica, por exemplo, 2019-07-02? 
SELECT idconsulta_medica, data_consulta FROM Consultas_medicas  WHERE data_consulta LIKE '2019-07-02%';

-- 7) Quantos pacientes estão cadastrados no sistema?
SELECT COUNT(id) pacientes_cadastrados FROM Pacientes;

-- 8) Como você contaria quantas consultas cada paciente tem? 
SELECT u.nome, COUNT(idconsulta_medica) total_consultas
FROM Pacientes p 
INNER JOIN Usuarios u ON u.id = p.usuarios_id
LEFT JOIN Consultas_medicas cm ON  cm.pacientes_id = p.id
GROUP BY u.nome
ORDER BY total_consultas DESC;

-- 9)  Como você somaria o número total de consultas realizadas por cada médico? 
SELECT m.crm, COUNT(id) total_consultas
FROM Medicos m
LEFT JOIN Consultas_medicas cm ON m.id = cm.pacientes_id
GROUP BY m.crm
ORDER BY total_consultas DESC;

-- 10) Qual é a data da consulta mais antiga registrada no sistema?
SELECT data_consulta 
FROM Consultas_medicas
ORDER BY data_consulta
LIMIT 1;







