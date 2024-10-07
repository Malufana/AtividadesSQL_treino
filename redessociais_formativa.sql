-- CREATE DATABASE RedeSocialAtividades;
USE RedeSocialAtividades;

CREATE TABLE usuarios(
	usuarioId INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    idade INT,
    cidade VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    nomeUsuario VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipoUsuario ENUM("Estudante", "Administrador")
);

CREATE TABLE categoria(
	categoriaId INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE
);

CREATE TABLE atividade(
	atividadeId INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descricao TEXT,
    dataAtividade DATE,
    localAtividade VARCHAR(100),
    categoriaId INT,
    FOREIGN KEY (categoriaId) REFERENCES categoria(categoriaId),
    criadorId INT, 
    FOREIGN KEY (criadorId) REFERENCES usuarios(usuarioId)
);

CREATE TABLE participantes(
	participacaoId INT PRIMARY KEY AUTO_INCREMENT,
    atividadeId INT,
    FOREIGN KEY (atividadeId) REFERENCES atividade(atividadeId),
    usuarioId INT, 
    FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId)
);

CREATE TABLE conexoes(
	conexaoId INT PRIMARY KEY AUTO_INCREMENT,
    usuarioId1 INT UNIQUE,
    FOREIGN KEY (usuarioId1) REFERENCES usuarios(usuarioId),
    usuarioId2 INT UNIQUE,
    FOREIGN KEY (usuarioId2) REFERENCES usuarios(usuarioId)
);

CREATE TABLE comentarios(
	comentarioId INT PRIMARY KEY AUTO_INCREMENT,
    atividadeId INT,
    FOREIGN KEY (atividadeId) REFERENCES atividade(atividadeId),
    usuarioId INT,
    FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId),
    comentario TEXT,
    dataComentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE participantes RENAME TO Participacoes;

INSERT INTO Usuarios (Nome, Idade, Cidade, Email, NomeUsuario, Senha, TipoUsuario) 
VALUES
('João', 20, 'São Paulo', 'joao@example.com', 'joao123', 'senha123', 'Estudante'),
('Maria', 22, 'Rio de Janeiro', 'maria@example.com', 'maria456', 'senha456', 'Administrador'),
('Pedro', 19, 'Belo Horizonte', 'pedro@example.com', 'pedro789', 'senha789', 'Estudante'),
('Ana', 21, 'São Paulo', 'ana@example.com', 'ana101', 'senha101', 'Estudante'),
('Carlos', 18, 'Brasília', 'carlos@example.com', 'carlos2022', 'senha2022', 'Estudante'),
('Lucas', 25, 'Porto Alegre', 'lucas@example.com', 'lucas123', 'senha123', 'Estudante'),
('Juliana', 23, 'Curitiba', 'juliana@example.com', 'juliana456', 'senha456', 'Administrador'),
('Mateus', 24, 'São Paulo', 'mateus@example.com', 'mateus789', 'senha789', 'Estudante'),
('Isabela', 26, 'Fortaleza', 'isabela@example.com', 'isabela101', 'senha101', 'Estudante'),
('Gabriel', 22, 'Manaus', 'gabriel@example.com', 'gabriel2022', 'senha2022', 'Estudante');

INSERT INTO Categoria (Nome) VALUES
('Esportes'),
('Artes'),
('Tecnologia'),
('Culinária'),
('Música');

INSERT INTO Atividade (Titulo, Descricao, DataAtividade, LocalAtividade, CategoriaID, CriadorID) VALUES
('Partida de Futebol', 'Venha jogar futebol conosco!', '2023-05-10', 'Campo do Bairro', 1, 1),
('Oficina de Pintura', 'Aprenda técnicas de pintura em tela.', '2023-03-15', 'Ateliê das Artes', 2, 
2),
('Workshop de Programação', 'Introdução à programação em Python.', '2023-12-20', 
'Laboratório de Informática', 3, 3),
('Aula de Culinária', 'Aprenda a fazer pratos deliciosos.', '2024-05-25', 'Cozinha Gourmet', 4, 4),
('Concerto de Piano', 'Apresentação de obras clássicas.', '2024-06-01', 'Teatro Municipal', 5, 5),
('Exposição de Fotografia', 'Venha apreciar belas imagens capturadas.', '2024-06-05', 'Galeria 
de Arte', 2, 2),
('Curso de Desenvolvimento Web', 'Aprenda a criar sites profissionais.', '2024-06-10', 'Sala de 
Aula 3', 3, 3),
('Sessão de Cinema ao Ar Livre', 'Desfrute de filmes sob o céu estrelado.', '2024-06-15', 'Praça 
Central', 4, 4);

INSERT INTO Participacoes (AtividadeID, UsuarioID) VALUES
(1, 2),
(1, 3),
(3, 1),
(4, 5),
(5, 4),
(5, 1),
(1, 6);

INSERT INTO Conexoes (UsuarioID1, UsuarioID2) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

INSERT INTO Comentarios (AtividadeID, UsuarioID, Comentario) VALUES
(1, 2, 'Estarei lá!'),
(1, 3, 'Mal posso esperar para jogar!'),
(3, 1, 'Excelente workshop!'),
(5, 4, 'Que emocionante!'),
(5, 1, 'Adorei o concerto!');

INSERT INTO Comentarios (AtividadeID, UsuarioID, Comentario) VALUES
(2, 2, NULL),
(4, 3, NULL);

-- atividade 9
SELECT atividade.titulo, atividade.descricao FROM atividade
INNER JOIN comentarios ON comentarios.atividadeId = atividade.atividadeId
WHERE comentarios.comentario is null;

-- atividade 10
SELECT usuarios.nome, usuarios.email FROM usuarios
WHERE usuarios.usuarioId in (select criadorId from atividade);

-- atividade 11
SELECT atividade.titulo, atividade.descricao, atividade.dataAtividade FROM atividade
WHERE dataAtividade BETWEEN '2024/10/01' and '2024/10/31';

-- atividade 12
SELECT atividade.atividadeId, usuarios.nome, usuarios.email FROM usuarios, atividade
WHERE usuarios.usuarioId not in (select criadorId from atividade);

-- atividade 13
SELECT COUNT(DISTINCT nome) AS nome, cidade 
FROM usuarios GROUP BY cidade;

-- atividade 14
SELECT categoria.nome, COUNT(atividade.atividadeId) AS qtdAtts FROM categoria 
INNER JOIN Atividade ON categoria.categoriaId = Atividade.categoriaId
GROUP BY categoria.nome;

-- atividade 15
SELECT Atividade.titulo, COUNT(Participacoes.participacaoId) AS QtdParticipantes FROM Atividade
INNER JOIN Participacoes ON Atividade.AtividadeId = Participacoes.AtividadeId
GROUP BY Atividade.atividadeId, Atividade.titulo
ORDER BY QtdParticipantes DESC LIMIT 3;

-- atividade 16
SELECT COUNT(participacoes.usuarioId) AS participacao, usuarios.nome FROM usuarios, participacoes
GROUP BY usuarios.nome HAVING participacao >= 2;

-- atividade 17
SELECT usuarios.nome, atividade.titulo, atividade.dataAtividade FROM atividade
INNER JOIN usuarios ON usuarios.usuarioId = atividade.criadorId
ORDER BY usuarios.nome ASC, atividade.dataAtividade DESC
LIMIT 5;

-- atividade 18
SELECT MIN(atividade.categoriaId) AS menor, categoria.nome FROM categoria
INNER JOIN atividade ON atividade.categoriaId = categoria.categoriaId
GROUP BY categoria.nome HAVING menor;

-- atividade 19
SELECT atividade.titulo, usuarios.nome, comentarios.comentario FROM comentarios
INNER JOIN atividade ON atividade.atividadeId = comentarios.atividadeId
INNER JOIN usuarios ON usuarios.usuarioId = comentarios.usuarioId
ORDER BY atividade.titulo;

-- atividade 20
SELECT atividade.titulo, atividade.descricao, usuarios.nome FROM atividade
INNER JOIN usuarios ON atividade.criadorId = usuarios.usuarioId
WHERE usuarios.tipoUsuario = 'Administrador';