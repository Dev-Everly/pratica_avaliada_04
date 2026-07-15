 
CREATE DATABASE  db_loja;
USE db_loja;

CREATE TABLE tb_categoria (
    id_categoria BIGINT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    
    CONSTRAINT pk_tb_categoria PRIMARY KEY (id_categoria)
);

 
CREATE TABLE tb_produto (
    id_produto BIGINT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(8, 2) NOT NULL,  
    id_categoria BIGINT,
    
    -- Chave Primária
    CONSTRAINT pk_tb_produto PRIMARY KEY (id_produto),
    
    -- Chave Estrangeira
    CONSTRAINT fk_tb_produto_tb_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES tb_categoria(id_categoria) 
        ON DELETE SET NULL -- Se a categoria for removida, o produto não é deletado
);

-- Inserindo Categorias  
INSERT INTO tb_categoria (nome) VALUES
('Informática'),
('Eletrodomésticos'),
('Móveis'),
('Celulares e Smartphones'),
('Áudio e Vídeo'),
('Games'),
('Beleza e Perfumaria'),
('Esporte e Lazer'),
('Ferramentas'),
('Papelaria');

-- Inserindo Produtos
INSERT INTO tb_produto (nome, preco, id_categoria) VALUES
('Teclado Mecânico RGB', 120.00, 1),        
('Mouse Gamer Optico', 85.50, 1),           
('Geladeira Frost Free 400L', 2899.90, 2),   
('Cadeira Gamer Ergonômica', 850.00, 3),     
('Smartphone 5G 128GB', 1599.00, 4),        
('Fone de Ouvido Bluetooth', 150.00, 5),     
('Console PlayStation 5', 3800.00, 6),     
('Kit de Chaves de Fenda', 69.90, 9),       
('Caderno Universitário 10m', 22.00, 10),    
('Produto de Teste Sem Categoria', 15.00, NULL); -- Produto temporário sem categoria

-- listando com  LEFT JOIN para garantir que o "Produto de Teste Sem Categoria" também apareça na listagem!
SELECT 
    p.id_produto,
    p.nome AS nome_produto,
    p.preco,
    COALESCE(c.nome, 'Sem categoria vinculada') AS nome_categoria
FROM tb_produto p
LEFT JOIN tb_categoria c ON p.id_categoria = c.id_categoria;

-- Filtrando por produtos que custam acima de R$ 100,00 e ordenando do mais caro para o mais barato
SELECT id_produto, nome, preco 
FROM tb_produto
WHERE preco > 100.00
ORDER BY preco DESC;

-- Atualizando o preço do Teclado Mecânico (id_produto = 1) 
UPDATE tb_produto 
SET preco = 115.00 
WHERE id_produto = 1;

-- Excluindo o produto de teste (id_produto = 10)
DELETE FROM tb_produto 
WHERE id_produto = 10;

-- Usamos o INNER JOIN para trazer somente correspondências exatas conforme o enunciado.
SELECT 
    CONCAT(
        'Produto: ', p.nome, 
        ' | Preço: ', p.preco, 
        ' | Categoria: ', COALESCE(c.nome, 'Sem Categoria')
    ) AS resultado_formatado
FROM tb_produto p
INNER JOIN tb_categoria c ON p.id_categoria = c.id_categoria;