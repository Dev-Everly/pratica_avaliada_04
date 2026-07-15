 
CREATE DATABASE  db_empresa;
USE db_empresa;

 
CREATE TABLE tb_departamento (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE tb_funcionario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    salario DECIMAL(8, 2) NOT NULL,
    id_departamento BIGINT,
    
    CONSTRAINT fk_tb_funcionario_tb_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES tb_departamento(id) ON DELETE SET NULL -- Evita perder o funcionário se o setor for deletado
);

 -- Inserindo Departamentos  
INSERT INTO tb_departamento (nome) VALUES
('Tecnologia da Informação'),
('Recursos Humanos'),
('Financeiro'),
('Vendas'),
('Marketing'),
('Jurídico'),
('Operações'),
('Atendimento ao Cliente'),
('Pesquisa e Desenvolvimento'),
('Logística');

--   Inserindo Funcionários  
INSERT INTO tb_funcionario (nome, salario, id_departamento) VALUES
('Carlos Oliveira', 3500.00, 1),    
('Ana Julia', 4200.50, 1),          
('Mariana Santos', 2800.00, 2),    
('Bruno Souza', 6500.00, 3),        
('Beatriz Costa', 3100.00, 4),      
('Juliana Lima', 2900.00, 5),       
('Ricardo Alves', 8200.00, 6),      
('Felipe Rocha', 2400.00, 7),      
('Amanda Melo', 4900.00, 9),        
('Rodrigo Silva', 2100.00, NULL);   

 

-- Listando todos os funcionários mostrando o departamento correspondente
SELECT 
    f.id AS id_funcionario,
    f.nome AS nome_funcionario,
    f.salario,
    COALESCE(d.nome, 'Sem departamento alocado') AS nome_departamento
FROM tb_funcionario f
LEFT JOIN tb_departamento d ON f.id_departamento = d.id;

-- Filtrar por salário
SELECT * FROM tb_funcionario
WHERE salario > 3000.00
ORDER BY salario DESC;

 
UPDATE tb_funcionario 
SET salario = 3850.00 
WHERE id = 1;

-- Deletar funcionário  
DELETE FROM tb_funcionario 
WHERE id = 8;

-- Relatório formatado com JOIN  
SELECT 
    CONCAT(
        'Funcionário: ', f.nome, 
        ' | Salário: R$ ', REPLACE(REPLACE(REPLACE(FORMAT(f.salario, 2), '.', '@'), ',', '.'), '@', ','), 
        ' | Departamento: ', COALESCE(d.nome, 'Sem departamento alocado')
    ) AS resultado_formatado
FROM tb_funcionario f
INNER JOIN tb_departamento d ON f.id_departamento = d.id;