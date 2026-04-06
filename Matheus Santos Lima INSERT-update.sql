CREATE DATABASE imovelnet;

USE imovelnet;

-- 1. FAIXAS DE IMÓVEIS
CREATE TABLE tb_faixa_imoveis (
    cd_faixa_imovel INT AUTO_INCREMENT PRIMARY KEY,
    nm_faixa VARCHAR(30) NOT NULL,
    vl_minimo DECIMAL(14,2) NOT NULL,
    vl_maximo DECIMAL(14,2) NOT NULL
);

-- 2. ESTADOS
CREATE TABLE tb_estados (
    cd_estado INT AUTO_INCREMENT PRIMARY KEY,
    nm_estado VARCHAR(50) NOT NULL,
    sg_estado CHAR(2) NOT NULL UNIQUE -- Adicionado Unique para garantir integridade
);

-- 3. CIDADES
CREATE TABLE tb_cidades (
    cd_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nm_cidade VARCHAR(40) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    id_estado INT,
    FOREIGN KEY (id_estado) REFERENCES tb_estados(cd_estado)
);

-- 4. BAIRROS
-- Removido sg_estado da PK composta para simplificar, ou mantido conforme sua lógica original
CREATE TABLE tb_bairros (
    cd_bairro INT AUTO_INCREMENT,
    nm_bairro VARCHAR(30) NOT NULL,
    id_cidade INT NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    PRIMARY KEY (cd_bairro), 
    FOREIGN KEY (id_cidade) REFERENCES tb_cidades(cd_cidade)
);

-- 5. COMPRADORES
CREATE TABLE tb_compradores (
    cd_comprador INT AUTO_INCREMENT PRIMARY KEY,
    nm_comprador VARCHAR(100) NOT NULL,
    ds_endereco VARCHAR(100) NOT NULL, -- Aumentado tamanho
    ds_cpf CHAR(11) DEFAULT NULL UNIQUE,
    nm_cidade VARCHAR(30),
    nm_bairro VARCHAR(30),
    sg_estado CHAR(2),
    ds_telefone VARCHAR(20), -- Alterado de INT para VARCHAR (telefones começam com 0 ou tem caracteres)
    ds_email VARCHAR(100) NOT NULL UNIQUE
);

-- 6. VENDEDORES
CREATE TABLE tb_vendedores (
    cd_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nm_vendedor VARCHAR(100) NOT NULL,
    nm_endereco VARCHAR(100) NOT NULL,
    ds_cpf CHAR(11) UNIQUE,
    nm_cidade VARCHAR(20),
    nm_bairro VARCHAR(20),
    sg_estado CHAR(2),
    ds_telefone VARCHAR(20),
    ds_email VARCHAR(100) NOT NULL UNIQUE
);

-- 7. OFERTAS (Criada antes de imóveis para evitar erro de FK circular se necessário, 
-- mas aqui ajustaremos a ordem de inserção)
CREATE TABLE tb_ofertas (
    cd_oferta INT AUTO_INCREMENT PRIMARY KEY,
    id_comprador INT NOT NULL,
    id_imovel INT, -- Referência ao imóvel
    vl_oferta DECIMAL(16,2),
    dt_oferta DATETIME NOT NULL,
    FOREIGN KEY (id_comprador) REFERENCES tb_compradores(cd_comprador)
);

-- 8. IMÓVEIS
CREATE TABLE tb_imoveis (
    cd_imovel INT AUTO_INCREMENT PRIMARY KEY,
    id_bairro INT,
    id_vendedor INT NOT NULL,
    id_cidade INT, -- Adicionado pois estava no INSERT mas não no CREATE
    sg_estado CHAR(2) NOT NULL,
    nm_endereco VARCHAR(100) NOT NULL,
    nr_area_util DECIMAL(10,2), -- Corrigido nome ns_area_util -> nr_area_util
    nr_area_total DECIMAL(10,2),
    ds_imovel VARCHAR(300),
    vl_preco DECIMAL(16,2),
    st_imovel ENUM('vendido','nao vendido') DEFAULT 'nao vendido',
    dt_lanca DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_imovel_indicado INT,
    FOREIGN KEY (id_bairro) REFERENCES tb_bairros(cd_bairro),
    FOREIGN KEY (id_vendedor) REFERENCES tb_vendedores(cd_vendedor),
    FOREIGN KEY (id_imovel_indicado) REFERENCES tb_imoveis(cd_imovel)
);

-- Índices
CREATE INDEX IDX_vendedor ON tb_vendedores (nm_vendedor);
CREATE INDEX IDX_comprador ON tb_compradores (nm_comprador);

-- 1. Estados
INSERT INTO tb_estados (sg_estado, nm_estado) VALUES ('SP', 'SÃO PAULO');
INSERT INTO tb_estados (sg_estado, nm_estado) VALUES ('RJ', 'RIO DE JANEIRO');

-- 2. Cidades (id_estado deve corresponder aos IDs gerados: 1 e 2)
INSERT INTO tb_cidades (nm_cidade, sg_estado, id_estado) VALUES ('SÃO PAULO', 'SP', 1);
INSERT INTO tb_cidades (nm_cidade, sg_estado, id_estado) VALUES ('SANTO ANDRÉ', 'SP', 1);
INSERT INTO tb_cidades (nm_cidade, sg_estado, id_estado) VALUES ('CAMPINAS', 'SP', 1);
INSERT INTO tb_cidades (nm_cidade, sg_estado, id_estado) VALUES ('RIO DE JANEIRO', 'RJ', 2);
INSERT INTO tb_cidades (nm_cidade, sg_estado, id_estado) VALUES ('NITERÓI', 'RJ', 2);

-- 3. Bairros
INSERT INTO tb_bairros (nm_bairro, id_cidade, sg_estado) VALUES ('JARDINS', 1, 'SP');
INSERT INTO tb_bairros (nm_bairro, id_cidade, sg_estado) VALUES ('MORUMBI', 1, 'SP');
INSERT INTO tb_bairros (nm_bairro, id_cidade, sg_estado) VALUES ('AEROPORTO', 1, 'SP');
INSERT INTO tb_bairros (nm_bairro, id_cidade, sg_estado) VALUES ('AEROPORTO', 4, 'RJ'); -- Cidade 4 é RJ
INSERT INTO tb_bairros (nm_bairro, id_cidade, sg_estado) VALUES ('FLAMENGO', 4, 'RJ');

-- 4. Vendedores
INSERT INTO tb_vendedores (nm_vendedor, nm_endereco, ds_email) VALUES ('MARIA DA SILVA', 'RUA DO GRITO 45', 'MSILVA@NOVATEC.COM.BR');
INSERT INTO tb_vendedores (nm_vendedor, nm_endereco, ds_email) VALUES ('MARCOS ANDRADE' , 'AV. DA SAUDADE 325', 'MANDRADE@NOVATEC.COM.BR');
INSERT INTO tb_vendedores (nm_vendedor, nm_endereco, ds_email) VALUES ('ANDRE CARDOSO', 'AV BRASI 401', 'TSOUZA@NOVATEC.COM.BR');
INSERT INTO tb_vendedores (nm_vendedor, nm_endereco, ds_email) VALUES ('OUTRO VENDEDOR', 'RUA TESTE 123', 'VENDEDOR4@TESTE.COM'); -- Criado para evitar erro no Imovel 6

-- 5. Imóveis (Ajustado colunas e valores)
-- Note: Removi o campo 'AP' que estava sobrando e ajustei a ordem das áreas.
INSERT INTO tb_imoveis (id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_area_util, nr_area_total, vl_preco, st_imovel) 
VALUES (1, 1, 1, 'SP', 'AL TIETE 3304', 101, 250, 180000, 'nao vendido');

INSERT INTO tb_imoveis (id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_area_util, nr_area_total, vl_preco, st_imovel) 
VALUES (1, 2, 1, 'SP', 'AV MORUMBI 150', 200, 250, 135000, 'nao vendido');

-- 6. Compradores
INSERT INTO tb_compradores (nm_comprador, ds_endereco, ds_email) VALUES ('EMMANUEL ANTUNES', 'R SARAIVA 452', 'EANTUNES@NOVATEC.COM.BR');
INSERT INTO tb_compradores (nm_comprador, ds_endereco, ds_email) VALUES ('JOANA PEREIRA', 'AV PORTUGAL 52', 'JPEREIRA@NOVATEC.COM.BR');
INSERT INTO tb_compradores (nm_comprador, ds_endereco, ds_email) VALUES ('RONALDO CAMPELO', 'R ESTADO UNIDOS 790', 'RCAMPELO@NOVATEC.COM.BR');
INSERT INTO tb_compradores (nm_comprador, ds_endereco, ds_email) VALUES ('MANFRED AUGUSTO', 'AV BRASIL 351', 'MAUGUSTO@NOVATEC.COM.BR');

update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 1;
update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 2;
update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 3;
update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 4;
update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 5;
update imovel set vl_preco = vl_preco * 1.10 where cd_imovel = 6;

update imovel set vl_preco = vl_preco * 0.95 where id_vendedor = 1;

update oferta set vl_oferta = vl_oferta * 1.05 where id_comprador = 2;

-- atividade 1 de 20.
 select * from bairro;

-- atividade 2 de 20.
 select cd_comprador, nm_comprador, ds_email from comprador;

-- atividade 3 de 20.
 select cd_vendedor, nm_vendedor, ds_email from vendedor order by nm_vendedor;

-- atividade 4 de 20.
 select cd_vendedor, nm_vendedor, ds_email from vendedor order by nm_vendedor desc;

-- atividade 5 de 20.
 select cd_bairro, nm_bairro, sg_estado from bairro where sg_estado like 'SP%';

-- atividade 6 de 20.
 select cd_imovel, id_vendedor, vl_preco from imovel where id_vendedor like '2%';

-- atividade 7 de 20.
 select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 and sg_estado like 'RJ%';

-- atividade 8 de 20.
 select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 or id_vendedor like '1%';

-- atividade 9 de 20.
select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 and not id_vendedor like '2%';

-- atividade 10 de 20.
 select cd_comprador, nm_comprador, nm_endereco, sg_estado from comprador where sg_estado like'null%';

-- atividade 11 de 20.
 select cd_comprador, nm_comprador, nm_endereco, sg_estado from comprador where sg_estado is not null;

-- atividade 12 de 20.
  select * from oferta where vl_oferta between 100000 and 150000;

-- atividade 13 de 20.
 select * from oferta where dt_oferta between '2002/02/01' and '2002/03/01';

-- atividade 14 de 20.
 select * from vendedor where nm_vendedor like 'M%';

-- atividade 15 de 20.
 select * from vendedor where nm_vendedor like '_a%';

-- atividade 16 de 20.
 select * from comprador where nm_endereco like '%U%';

-- atividade 17 de 20.
 select * from oferta where id_imovel = 1 or id_imovel = 2;

-- atividade 18 de 20.
select * from imovel where cd_imovel = 2 or cd_imovel = 3 order by nm_endereco;

-- atividade 19 de 20.
select * from oferta where id_imovel = 2 or id_imovel = 3 and vl_oferta >= 140000 order by dt_oferta desc;

-- atividade 20 de 20.
select * from imovel where vl_preco between 110000 and 200000;
