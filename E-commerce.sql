-- 1 - Criação do banco
CREATE DATABASE dv_ecommerce_Andressa_Rezende;
USE dv_ecommerce_Andressa_Rezende;

-- 2 - Criação das tabelas
CREATE TABLE Clientes (
	id INT auto_increment primary key not null,
    nome VARCHAR(100),
    email VARCHAR(45),
    endereco VARCHAR(45)
);
CREATE TABLE Categorias (
	id INT auto_increment primary key not null,
    categoria_nome VARCHAR(45),
    categoria_tipo VARCHAR(45)
);

CREATE TABLE Produtos (
	id INT auto_increment primary key not null,
    produto_nome VARCHAR (100),
    categoria_id INT,
    foreign key (categoria_id) references categorias(id)
);

CREATE TABLE Entregas (
	id INT auto_increment primary key not null,
    tipo VARCHAR(45),
    status VARCHAR(45)
);

CREATE TABLE Ordens (
	id INT auto_increment primary key not null,
    ordem_data DATETIME,
    cliente_id INT,
    entrega_id INT,
    foreign key (cliente_id) references Clientes(id),
    foreign key (entrega_id) references Entregas(id)
);

CREATE TABLE OrdemDetalhes (
	quantidade INT,
    precoUnitario DECIMAL(10, 2),
    ordem_id INT,
    produto_id INT,
    foreign key (ordem_id) references Ordens(id),
    foreign key (produto_id) references Produtos(id)
);

-- 3 - Inserção de todas as informações das tabelas criadas
INSERT INTO Clientes(nome, email, endereco) VALUES 
('João Silva', 'joao@email.com', 'Rua A, 123'),
('Maria Lima', 'maria@email.com', 'Rua Goiás, 555'),
('Pedro Souza', 'pedro@email.com', 'Av. Central, 456'),
('Ana Costa', 'ana.costa@email.com', 'Rua B, 789'),
('Carlos Mendes', 'carlos.mendes@email.com', 'Rua das Flores, 321'),
('Fernanda Alves', 'fernanda@email.com', 'Av. Paulista. 1000');

INSERT INTO Categorias(categoria_nome, categoria_tipo) VALUES
('Eletrônicos', 'Tecnologia'),
('Vestuário', 'Moda'),
('Alimentos', 'Mercado'),
('Móveis', 'Casa'),
('Brinquedos', 'Infantil');

INSERT INTO Produtos(produto_nome, categoria_id) VALUES
('Smartphone', 1),
('Notebook', 1),
('Fone de Ouvido', 1),
('Camiseta', 2),
('Calça Jeans', 2),
('Carrinho de Controle Remoto', 5);

INSERT INTO Entregas (tipo, status) VALUES
('Motoby', 'Entregue'), 
('Correios', 'Em Trânsito'), 
('Retirada Loja', 'Pendente'), 
('Transportadora', 'Cancelado'), 
('Correios', 'Entregue');

INSERT INTO Ordens(ordem_data, entrega_id, cliente_id) VALUES
('2024-07-01', 1 , 1),
('2024-07-02', 2 , 2),
('2024-07-03', 3 , 3),
('2024-07-05', 4 , 4),
('2024-07-07', 5 , 5),
('2024-07-08', 1 , 5);

INSERT INTO OrdemDetalhes (ordem_id, produto_id, quantidade, precoUnitario) VALUES
(1, 1, 2, 1500.00),
(1, 3, 1, 200.00),
(2, 4, 3, 50.00),
(5, 5, 2, 120.00);

-- 4 - Seleção dos dados da tabela clientes
SELECT * FROM Clientes;

-- 5 - Seleção dos clientes que moram na rua alter
SELECT endereco FROM Clientes WHERE endereco LIKE 'Rua A%';

-- 6 - Quantidade de clientes que estão cadastrados
SELECT COUNT(id) FROM Clientes;

-- 7 - Contagem de quantos pedidos de cada cliente realizou
SELECT c.nome, COUNT(o.id) contagem
FROM Clientes c
LEFT JOIN Ordens o ON o.cliente_id = c.id
GROUP BY c.nome;

-- 8 -  somaria o número total de pedidos realizados por cada cliente
SELECT c.nome, SUM(o.id) contagem
FROM Clientes c
LEFT JOIN Ordens o ON o.cliente_id = c.id
GROUP BY c.nome;

-- 9 - Como você listaria todos os pedidos junto com o nome do cliente e o status da entrega em ordem alfabética
SELECT o.id, c.nome, e.status
FROM Ordens o
INNER JOIN Clientes c ON o.cliente_id = c.id
INNER JOIN Entregas e ON o.entrega_id = e.id
ORDER BY c.nome;

-- 10 - Liste os pedidos ordenados do mais antigo para o mais recente.
SELECT * FROM Ordens ORDER BY ordem_data;  

-- 11 - Quantos produtos estão cadastrados para cada categoria?
SELECT COUNT(p.id), ct.categoria_nome
FROM Produtos p
INNER JOIN Categorias ct ON p.categoria_id = ct.id
group by ct.categoria_nome;

-- 12 - Como você selecionaria todos os clientes que ainda não realizaram pedidos?
SELECT c.nome
FROM Clientes c
LEFT JOIN Ordens o ON c.id = o.cliente_id
WHERE o.id IS NULL;

-- 13 - Qual foi o produto mais vendido (maior quantidade total)?
SELECT p.produto_nome, SUM(od.quantidade) total
FROM OrdemDetalhes od 
INNER JOIN Produtos p ON od.produto_id = p.id
group by p.produto_nome
order by total DESC
LIMIT 1;

-- 14 - Qual foi o cliente que mais gastou no e-commerce?
SELECT c.nome, SUM(quantidade * precoUnitario) total
FROM OrdemDetalhes od
INNER JOIN Ordens o ON od.ordem_id = o.id
INNER JOIN Clientes c ON o.cliente_id = c.id
group by c.nome
order by total DESC
LIMIT 1;

-- 15 - Qual a média de valor por pedido no sistema?


-- 16 -  Qual foi o valor total do pedido com Order_ID = 1?
SELECT SUM(quantidade * precoUnitario) total
FROM OrdemDetalhes
WHERE ordem_id = 1;

-- 17 - Quais são as contagens de pedidos junto com o nome do cliente e o status da entrega
SELECT COUNT(o.id) total_pedidos, c.nome, e.status
FROM Ordens o
INNER JOIN Clientes c ON o.cliente_id = c.id
INNER JOIN Entregas e ON o.entrega_id = e.id
GROUP BY c.nome, e.status;

-- 18 -  Liste os pedidos ordenados do mais antigo para o mais recente
SELECT o.ordem_data, p.produto_nome
FROM OrdemDetalhes od
INNER JOIN Ordens o ON od.ordem_id = o.id
INNER JOIN Produtos p ON od.produto_id = p.id
ORDER BY o.ordem_data;

-- 19 - Liste os clientes que realizaram mais de 2 pedidos
SELECT nome, total_pedidos
FROM (
	SELECT c.nome, COUNT(o.id) total_pedidos
	FROM Ordens o
	INNER JOIN Clientes c ON o.cliente_id = c.id
	GROUP BY c.nome
    ) a
WHERE total_pedidos >= 2;

-- 20 - Qual é o status mais frequente nas entregas?
SELECT status, COUNT(*) AS quantidade
FROM Entregas
GROUP BY status
ORDER BY quantidade DESC
LIMIT 1;

-- 21 - Liste todos os pedidos que possuem mais de 1 produto.
SELECT ordem_id, quantidade_de_produtos
FROM (
  SELECT ordem_id, COUNT(*) AS quantidade_de_produtos
  FROM OrdemDetalhes
  GROUP BY ordem_id
) AS sub
WHERE quantidade_de_produtos > 1;