CREATE DATABASE db_biblioteca;
 
CREATE TABLE Autores (
	id INT auto_increment primary key,
	nome VARCHAR(100) NOT NULL,
	nacionalidade VARCHAR(50)
);

CREATE TABLE  Livros (
	id INT auto_increment primary key,
	titulo VARCHAR(150) NOT NULL,
	ano_publicacao INT,
	autor_id INT
);

CREATE TABLE Usuarios (
	id INT auto_increment primary key,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE
);

CREATE TABLE Emprestimos (
	id INT auto_increment primary key,
	usuario_id INT,
	livro_id INT,
	data_emprestimo DATE NOT NULL,
	data_devolucao DATE NULL
);

INSERT INTO Autores (nome, nacionalidade) VALUES
('Clarice Lispector', 'Ucraniana'),
('Machado de Assis', 'Brasileiro'),
('George Orwell', 'Britânico');

INSERT INTO Livros (titulo, ano_publicacao, autor_id) VALUES 
('Dom Casmurro', 2029, 1),
('Memórias Póstumas de Brás Cubas', 1881, 1),
('A Hora da Estrela', 1977, 2),
('1984', 1949, 3),
('A Revolução dos Bichos', 2020, 3);

INSERT INTO Usuarios (nome, email) VALUES 
('Beatriz Rafaele', 'beatriz.rafaele@email.com'),
('Eduardo Pereira', 'eduardopereira09@email.com'),
('João Carlos', 'joao.carlos23@email.com');

INSERT INTO Emprestimos (usuario_id, livro_id, data_emprestimo, data_devolucao) VALUES 
(1, 4, '2025-08-10', NULL),  
(2, 1, '2025-08-12', NULL),  
(3, 3, '2025-08-15', NULL);  

UPDATE Autores SET nome = 'Clarice Lispector Filha' WHERE id = 1;
UPDATE Usuarios SET email = 'eduardo.pereira@email.com' WHERE id = 2;
UPDATE Livros SET titulo = 'Dom Casmurro - Origem' WHERE id = 1;

DELETE FROM Emprestimos WHERE id = 1;
DELETE FROM Usuários WHERE id = 1;

SELECT * FROM Livros;
SELECT * FROM Emprestimos;
SELECT * FROM Livros WHERE ano_publicacao > 2015;
SELECT * FROM Autores WHERE nacionalidade = 'Brasileiro' OR nacionalidade = 'Brasileira';
