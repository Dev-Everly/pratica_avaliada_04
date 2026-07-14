CREATE DATABASE db_gestao_cursos;

USE db_gestao_cursos;

CREATE TABLE tb_curso(
id BIGINT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
carga_horaria INT NOT NULL
);

CREATE TABLE tb_aluno(
id BIGINT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
idade INT NOT NULL,
curso_id BIGINT,

 CONSTRAINT fk_tb_aluno_tb_curso
	FOREIGN KEY (curso_id)
    REFERENCES tb_curso(id) ON DELETE SET NULL #Curso for deletado não perco dados do aluno

);
 
INSERT INTO tb_curso (nome, carga_horaria) VALUES
('Desenvolvimento Web Full Stack', 360),
('Introdução à Inteligência Artificial', 80),
('Banco de Dados e SQL Avançado', 120),
('Desenvolvimento Mobile com Flutter', 200),
('Lógica de Programação e Algoritmos', 40),
('UI/UX Design para Iniciantes', 60),
('Segurança da Informação e Redes', 180),
('Metodologias Ágeis e Scrum', 32),
('Análise de Dados com Python', 150),
('DevOps e Infraestrutura em Nuvem', 240);

 
INSERT INTO tb_aluno (nome, idade, curso_id) VALUES
('Lucas Silva', 21, 1),        
('Beatriz Souza', 24, 1),     
('Carlos Eduardo', 19, 5),    
('Mariana Costa', 30, 3),     
('Rafael Oliveira', 28, 9),    
('Juliana Lima', 22, 6),      
('Felipe Alencar', 35, 10),   
('Amanda Rocha', 26, 4),       
('Rodrigo Santos', 31, 2),   
('Gabriela Mendes', 23, NULL); -- aluna ativa, mas atualmente sem curso

-- Listando todos os alunos com ou sem curso
 
-- Listando alunos com ou sem curso
SELECT 
    a.id AS id_aluno, 
    a.nome AS nome_aluno,
    a.idade,
    COALESCE(c.nome, 'Sem curso cadastrado') AS nome_curso,
    COALESCE(c.carga_horaria, 0) AS carga_horaria
FROM tb_aluno a
LEFT JOIN tb_curso c ON a.curso_id = c.id; 

SELECT * FROM tb_aluno WHERE idade >= 18;

UPDATE tb_aluno SET idade = 14 WHERE id = 1;

DELETE FROM tb_curso 
WHERE id = 8;

-- Verificando se foi excluido o id 8
SELECT * FROM tb_curso WHERE id = 8;

SELECT 
    CONCAT('Aluno: ', tb_aluno.nome, 
           ' | Idade: ', tb_aluno.idade, 
           ' | Curso: ', COALESCE(tb_curso.nome, 'Sem Curso'), 
           ' | Carga Horária: ', COALESCE(tb_curso.carga_horaria, 0)) AS resultado_formatado
FROM tb_aluno
INNER JOIN tb_curso ON tb_aluno.curso_id = tb_curso.id;