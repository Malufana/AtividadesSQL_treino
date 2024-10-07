-- CREATE DATABASE estrutura_biblioteca;
-- DROP DATABASE estrutura_biblioteca;
USE estrutura_biblioteca;

CREATE TABLE autores (
	autorID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dataNascimento DATE
);

CREATE TABLE livros (
	livroID INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    autorID INT,
    dataPublicacao DATE,
    categoria VARCHAR(100),
    totalEmprestimo INT,
    FOREIGN KEY (autorID) REFERENCES autores(autorID)
);

CREATE TABLE usuarios (
	usuarioID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dataRegistro DATE,
    tipoUsuario  ENUM('premium', 'comum')
);

CREATE TABLE emprestimos (
	emprestimoID INT PRIMARY KEY AUTO_INCREMENT,
    livroID INT,
    usuarioID INT,
    dataEmprestimo DATE,
    dataDevolucao DATE,
    duracao INT,
    FOREIGN KEY (livroID) REFERENCES livros(livroID),
    FOREIGN KEY (usuarioID) REFERENCES usuarios(usuarioID)
);

INSERT INTO Autores (autorID, nome, dataNascimento) VALUES
(1, 'Dan Brown', '1964-06-22'),
(2, 'George R.R. Martin', '1948-09-20'),
(3, 'J.K. Rowling', '1965-07-31'),
(4, 'Chimamanda Ngozi Adichie', '1977-09-15'),
(5, 'Min Jin Lee', '1968-11-11'),
(6, 'Jeferson Tenório', '1977-01-01'),
(7, 'Aline Bei', '1987-10-09'),
(8, 'Ana Maria Gonçalves', '1970-01-01'),
(9, 'Sylvia Plath', '1932-10-27'),
(10, 'Sally Rooney', '1991-02-20');

INSERT INTO Livros (livroID, titulo, autorID, dataPublicacao, categoria, totalEmprestimo) VALUES
(1, 'O Código Da Vinci', 1, '2003-03-18', 'Ficção', 10),
(2, 'A Guerra dos Tronos', 2, '1996-08-06', 'Ficção', 15),
(3, 'A Muralha de Gelo', 2, '2011-03-08', 'Ficção', 8),
(4, 'Harry Potter e a Pedra Filosofal', 3, '1997-06-26', 'Ficção', 20),
(5, 'Hibisco Roxo', 4, '2003-10-01', 'Romance', 20),
(6, 'Pachinko', 5, '2017-02-07', 'Romance', 15),
(7, 'O Avesso da Pele', 6, '2020-08-10', 'Ficção Urbana', 20),
(8, 'O Peso do Pássaro Morto', 7, '2017-01-01', 'Poesia', 12),
(9, 'Um Defeito de Cor', 8, '2006-01-01', 'Ficção Histórica', 20),
(10, 'A Redoma de Vidro', 9, '1963-01-14', 'Romance', 15),
(11, 'Pessoas Normais', 10, '2018-08-28', 'Romance', 12),
(12, 'Conversas Entre Amigos', 10, '2017-05-25', 'Romance', 10);

INSERT INTO Usuarios (usuarioID, nome, dataRegistro, tipoUsuario) VALUES
(1, 'Alice', '2023-01-15', 'premium'),
(2, 'Bob', '2023-02-10', 'comum'),
(3, 'Charlie', '2023-03-05', 'premium'),
(4, 'Debora', '2023-04-20', 'comum'),
(5, 'Elisa', '2022-05-25', 'premium'),
(6, 'Felicia', '2023-06-12', 'comum'),
(7, 'Gustavo', '2022-07-02', 'premium'),
(8, 'Helena', '2024-08-09', 'comum'),
(9, 'Iris', '2020-09-08', 'premium'),
(10, 'Julia', '2024-08-10', 'comum');

INSERT INTO Emprestimos (emprestimoID, livroID, usuarioID, dataEmprestimo, dataDevolucao,
duracao) VALUES
(1, 1, 1, '2023-01-20', '2023-02-03', 14),
(2, 2, 1, '2023-01-25', '2023-02-10', 16),
(3, 4, 2, '2023-02-15', '2023-03-01', 14),
(4, 3, 3, '2023-03-10', '2023-03-15', 5),
(5, 10, 8, '2023-05-23', '2023-06-23', 31),
(6, 9, 5, '2023-04-21', '2023-05-10', 19), 
(7, 11, 4, '2023-05-15', '2023-06-02', 18),
(8, 8, 6, '2023-06-03', '2023-06-05', 2),
(9, 6, 9, '2023-07-10', '2023-07-20', 10),
(10, 12, 7, '2023-08-12', '2023-08-22', 10);

-- SELECT	

-- ATT1
SELECT Livros.titulo, Autores.autorID FROM Autores
INNER JOIN Livros ON Autores.autorID = Livros.autorID
WHERE Livros.titulo LIKE 'O Código Da Vinci';

-- ATT2
SELECT Autores.nome, Livros.titulo FROM livros
INNER JOIN Autores ON Autores.autorID = Livros.autorID
WHERE Autores.nome = 'George R.R. Martin';

-- ATT3
SELECT Livros.categoria, COUNT(*) AS qtdPorCategoria FROM Livros
GROUP BY Livros.categoria;

-- ATT4
SELECT Livros.autorID, Autores.nome, COUNT(*) AS livrosPublicados FROM Livros
INNER JOIN Autores ON Autores.autorID = Livros.autorID
GROUP BY Livros.autorID;

-- ATT5
SELECT Usuarios.nome, AVG(Total) as Media 
FROM (SELECT Emprestimos.usuarioID, COUNT(*) AS Total FROM Emprestimos GROUP BY Emprestimos.usuarioID) AS sub, Usuarios 
GROUP BY Usuarios.nome;

-- ATT6
SELECT Livros.categoria, COUNT(*) AS qtdLivros FROM Livros
GROUP BY Livros.categoria HAVING qtdLivros > 5;

-- ATT7
SELECT Livros.titulo FROM Livros
WHERE livros.dataPublicacao = (SELECT MIN(Livros.dataPublicacao) AS antigo FROM Livros) 
GROUP BY Livros.titulo;

-- ATT8
SELECT Usuarios.dataRegistro, COUNT(*) AS Total FROM usuarios
GROUP BY Usuarios.dataRegistro HAVING Usuarios.dataRegistro LIKE '2023%';

-- ATT9
SELECT Livros.titulo, COUNT(Emprestimos.livroID) AS maisEmprestado
FROM Emprestimos
INNER JOIN Livros ON Livros.livroID = Emprestimos.livroID
GROUP BY Livros.livroID
ORDER BY maisEmprestado ASC LIMIT 1;

SELECT Livros.titulo, COUNT(Emprestimos.livroID) AS menosEmprestado
FROM Emprestimos
INNER JOIN Livros ON Livros.livroID = Emprestimos.livroID
GROUP BY Livros.livroID
ORDER BY menosEmprestado DESC LIMIT 1;

-- ATT10
SELECT CAST(AVG(year(CURDATE())- year(dataNascimento))AS UNSIGNED) AS MediaIdade FROM Autores;

-- ATT 11
SELECT Livros.titulo, Livros.dataPublicacao FROM Livros ORDER BY Livros.dataPublicacao DESC LIMIT 3;

-- ATT 12
SELECT Usuarios.nome, Usuarios.tipoUsuario FROM Usuarios WHERE tipoUsuario = 'premium';
SELECT Usuarios.nome, COUNT(Emprestimos.usuarioID) AS total FROM Emprestimos 
INNER JOIN Usuarios ON Usuarios.usuarioID = Emprestimos.usuarioID
WHERE Usuarios.nome IN (SELECT Usuarios.nome FROM Usuarios WHERE tipoUsuario = 'premium')
GROUP BY Emprestimos.usuarioID;

-- ATT 13
SELECT Autores.nome FROM Autores;
SELECT COUNT(Livros.AutorID) AS qtdLivros, Autores.nome FROM Livros
INNER JOIN Autores ON Livros.AutorID = Autores.AutorID
GROUP BY Livros.AutorID;

-- ATT 14
SELECT Livros.categoria, COUNT(Emprestimos.LivroID) AS Livros FROM Emprestimos
INNER JOIN Livros ON Livros.LivroID = Emprestimos.LivroID
GROUP BY Livros.categoria;

-- ATT 15
SELECT Usuarios.nome, COUNT(Emprestimos.usuarioID) AS LivrosEmprestados FROM Emprestimos
INNER JOIN Usuarios ON Usuarios.usuarioID = Emprestimos.usuarioID
GROUP BY Usuarios.nome LIMIT 1;

-- ATT 16
SELECT ROUND(AVG(Emprestimos.duracao), 1) AS mediaDuracao FROM Emprestimos;

-- ATT 17
SELECT Livros.titulo FROM Livros
LEFT JOIN Emprestimos ON Livros.livroID = Emprestimos.livroID
WHERE Emprestimos.livroID IS NULL;

-- ATT 18
SELECT Livros.categoria, COUNT(*) AS qtdLivros FROM Livros
GROUP BY Livros.categoria ORDER BY qtdLivros DESC LIMIT 1;

-- ATT 19
SELECT Autores.nome, ROUND(AVG(LivrosPorAutor.qtdLivros), 1) AS mediaLivros
FROM (
    SELECT Livros.AutorID, COUNT(Livros.AutorID) AS qtdLivros
    FROM Livros
    GROUP BY Livros.AutorID
) AS LivrosPorAutor
INNER JOIN Autores ON LivrosPorAutor.AutorID = Autores.AutorID
GROUP BY Autores.nome;

-- ATT 20
SELECT MONTH(dataEmprestimo) AS mes, COUNT(*) as TotalEmprestimos FROM Emprestimos
GROUP BY MONTH(dataEmprestimo) ORDER BY TotalEmprestimos DESC LIMIT 10;

-- ATT 21
SELECT Autores.nome, Autores.dataNascimento FROM Autores 
ORDER BY Autores.dataNascimento DESC LIMIT 1;

-- ATT 22
SELECT Usuarios.nome, Usuarios.dataRegistro, Emprestimos.dataEmprestimo FROM Usuarios
INNER JOIN Emprestimos  ON Usuarios.usuarioID = Emprestimos.usuarioID 
WHERE MONTH(Usuarios.dataRegistro) = MONTH(Emprestimos.dataEmprestimo) AND
YEAR(Usuarios.dataRegistro) = YEAR(Emprestimos.dataEmprestimo);
