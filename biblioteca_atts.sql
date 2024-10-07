-- CREATE DATABASE biblioteca_exercicio;
USE biblioteca_exercicio;

-- Tabela para Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(100),
    data_de_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivel_associacao ENUM('basico', 'premium') DEFAULT 'basico'
);

-- Tabela para Categorias de Livros
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela para Autores
CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    data_nascimento DATE,
    biografia TEXT
);

-- Tabela para Livros
CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_autor INT,
    id_categoria INT,
    ano_publicacao YEAR,
    isbn VARCHAR(20) UNIQUE,
    quantidade INT DEFAULT 1,
    descricao TEXT,
    FOREIGN KEY (id_autor) REFERENCES autores(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

-- Tabela para Empréstimos
CREATE TABLE emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_livro INT,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_devolucao DATETIME,
    status ENUM('pendente', 'concluído') DEFAULT 'pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_livro) REFERENCES livros(id)
);

-- Inserir dados na tabela de clientes
INSERT INTO clientes (nome, email, cidade, data_de_cadastro, nivel_associacao) VALUES
('Maria Silva', 'maria.silva@example.com', 'São Paulo', '2023-09-10', 'premium'),
('João Souza', 'joao.souza@example.com', 'Rio de Janeiro', '2023-08-15', 'basico'),
('Ana Oliveira', 'ana.oliveira@example.com', 'Belo Horizonte', '2023-06-20', 'premium'),
('Carlos Pereira', 'carlos.pereira@example.com', 'Curitiba', '2023-07-25', 'basico'),
('Fernando Costa', 'fer.costa@example.com', 'Fortaleza', '2023-01-05', 'premium'),
('Juliana Santos', 'juli.santos@example.com', 'Recife', '2023-03-30', 'basico'),
('George Orwell', 'george.orwell@example.com', 'Londres', '2023-04-15', 'premium');

-- Inserir dados na tabela de categorias
INSERT INTO categorias (nome) VALUES
('Ficção'),
('Não-Ficção'),
('Biografia'),
('Ciência'),
('Fantasia');

-- Inserir dados na tabela de autores
INSERT INTO autores (nome, data_nascimento, biografia) VALUES
('George Orwell', '1903-06-25', 'Autor britânico, conhecido por obras como "1984" e "A Revolução dos Bichos".'),
('J.K. Rowling', '1965-07-31', 'Autora da famosa série "Harry Potter".'),
('Isaac Asimov', '1920-01-02', 'Famoso autor de ficção científica e divulgador científico.'),
('Gabriel García Márquez', '1927-03-06', 'Escritor colombiano, vencedor do Prêmio Nobel de Literatura.'),
('Stephen King', '1947-09-21', 'Autor americano de terror, ficção, fantasia e suspense.');

-- Inserir dados na tabela de livros
INSERT INTO livros (titulo, id_autor, id_categoria, ano_publicacao, isbn, quantidade, descricao) VALUES
('1984', 1, 1, 1949, '9780451524935', 5, 'Um romance distópico que apresenta um futuro totalitário.'),
('Harry Potter e a Pedra Filosofal', 2, 5, 1997, '9780545010221', 10, 'O primeiro livro da série Harry Potter.'),
('Fundação', 3, 1, 1951, '9780553293357', 3, 'Um épico da ficção científica que explora a psicohistória.'),
('Cem Anos de Solidão', 4, 1, 1967, '9780307474728', 2, 'Um marco da literatura latino-americana.'),
('O Iluminado', 5, 1, 1977, '9788501032954', 4, 'Uma história de terror psicológico.');

-- Inserir dados na tabela de empréstimos
INSERT INTO emprestimos (id_cliente, id_livro, data_emprestimo, status) VALUES
(1, 1, '2023-09-15', 'pendente'),
(2, 2, '2023-08-20', 'concluído'),
(3, 3, '2023-06-25', 'concluído'),
(4, 1, '2023-07-30', 'pendente'),
(5, 4, '2023-01-10', 'concluído'),
(6, 5, '2023-02-15', 'pendente');


-- Inserir mais dados na tabela de clientes
INSERT INTO clientes (nome, email, cidade, data_de_cadastro, nivel_associacao) VALUES
('Lucas Lima', 'lucas.lima@example.com', 'São Paulo', '2023-08-01', 'basico'),
('Mariana Ferreira', 'mariana.ferreira@example.com', 'Rio de Janeiro', '2023-07-10', 'premium'),
('Roberto Almeida', 'roberto.almeida@example.com', 'Belo Horizonte', '2023-06-15', 'basico'),
('Fernanda Santos', 'fernanda.santos@example.com', 'Curitiba', '2023-05-20', 'premium'),
('Pedro Costa', 'pedro.costa@example.com', 'Fortaleza', '2023-04-10', 'basico'),
('Tatiane Rocha', 'tatiane.rocha@example.com', 'Recife', '2023-03-05', 'premium'),
('Julio César', 'julio.cesar@example.com', 'Brasília', '2023-02-25', 'basico'),
('Luciana Martins', 'luciana.martins@example.com', 'Salvador', '2023-01-30', 'premium');

-- Inserir mais dados na tabela de categorias
INSERT INTO categorias (nome) VALUES
('Mistério'),
('Romance'),
('Aventura'),
('Terror'),
('História');

-- Inserir mais dados na tabela de autores
INSERT INTO autores (nome, data_nascimento, biografia) VALUES
('Agatha Christie', '1890-09-15', 'Famosa por seus romances de mistério e detetives.'),
('J.R.R. Tolkien', '1892-09-02', 'Criador do universo de "O Senhor dos Anéis".'),
('Dan Brown', '1964-06-22', 'Autor de thrillers como "O Código Da Vinci".'),
('Chico Buarque', '1944-06-19', 'Renomado autor e músico brasileiro.'),
('Clarice Lispector', '1920-12-10', 'Uma das maiores escritoras brasileiras do século XX.');

-- Inserir mais dados na tabela de livros
INSERT INTO livros (titulo, id_autor, id_categoria, ano_publicacao, isbn, quantidade, descricao) VALUES
('E o Vento Levou', 6, 2, 1936, '9788545200569', 4, 'Uma épica história de amor no contexto da Guerra Civil Americana.'),
('O Senhor dos Anéis: A Sociedade do Anel', 7, 5, 1954, '9788545200583', 5, 'A primeira parte da trilogia que explora a luta contra o mal.'),
('O Código Da Vinci', 8, 1, 2003, '9788576804903', 6, 'Um thriller que explora segredos ocultos da história.'),
('A Menina que Roubava Livros', 9, 2, 2005, '9788550700557', 3, 'A história de uma menina na Alemanha nazista.'),
('A Hora da Estrela', 10, 2, 1977, '9788573023782', 2, 'Um romance sobre a vida de uma nordestina no Rio de Janeiro.');

-- Inserir mais dados na tabela de empréstimos
INSERT INTO emprestimos (id_cliente, id_livro, data_emprestimo, status) VALUES
(7, 6, '2023-09-01', 'pendente'),
(8, 7, '2023-08-05', 'concluído'),
(1, 8, '2023-09-12', 'pendente'),
(4, 9, '2023-07-15', 'concluído'),
(5, 10, '2023-06-25', 'pendente'),
(2, 6, '2023-07-10', 'concluído'),
(3, 7, '2023-06-20', 'pendente'),
(6, 8, '2023-05-30', 'concluído');

-- SELECTS
-- Att1
SELECT * FROM emprestimos;

-- Att2
SELECT * FROM Livros WHERE ISBN = 9780451524935;

-- Att3
SELECT Autores.nome FROM Autores WHERE data_nascimento > '1965-01-01';

-- Att4
SELECT Autores.nome, Autores.biografia FROM Autores 
WHERE Autores.nome = 'George Orwell';

-- Att5
SELECT Clientes.nome, Clientes.nivel_associacao FROM Clientes
WHERE Clientes.nivel_associacao = 'premium';

-- Att6
SELECT Livros.titulo FROM Livros
WHERE id = 6;

-- Att7
SELECT Autores.nome FROM Autores
WHERE Autores.nome LIKE 'J%';

-- Att8
SELECT Clientes.nome, Clientes.email FROM Clientes
WHERE id = 5;

-- Att9
SELECT Livros.titulo FROM Livros
WHERE Livros.titulo LIKE '%Guerra%';

-- Att10
SELECT Clientes.nome, Clientes.data_de_cadastro FROM Clientes
WHERE Clientes.nome LIKE 'Maria %';

-- Att11
SELECT Emprestimos.id_livro, Livros.titulo, Emprestimos.status FROM Livros
INNER JOIN Emprestimos ON Emprestimos.id_livro = Livros.id
WHERE Emprestimos.status = 'pendente';

-- Att12
SELECT Clientes.id, Clientes.nome, Clientes.email FROM Clientes
WHERE Clientes.email = 'joao@example.com';

-- Att13
SELECT Clientes.nome FROM Clientes
WHERE Clientes.data_de_cadastro > '2023-09-01';

-- Att14
SELECT Autores.nome FROM Autores
WHERE Autores.data_nascimento < '1900-01-01' OR Autores.data_nascimento > '2001-01-01';

-- Att15
SELECT Clientes.nome FROM Clientes
WHERE Clientes.data_de_cadastro >= '2023-10-01' OR Clientes.data_de_cadastro >= '2023-12-31';

-- Att16
SELECT Clientes.nome FROM Clientes
WHERE Clientes.email = null;

-- Att17
SELECT * FROM Livros
WHERE LENGTH(Livros.descricao) > 50; 

-- Clientes que nunca emprestaram um livro
SELECT Clientes.nome FROM Clientes
WHERE id NOT IN (SELECT Emprestimos.id_cliente FROM Emprestimos);

-- Categorias com livros emprestados
SELECT Categorias.nome FROM Categorias
WHERE id IN (SELECT Livros.id_categoria FROM Livros 
WHERE id IN (SELECT Emprestimos.id_livro FROM Emprestimos));

