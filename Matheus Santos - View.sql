CREATE DATABASE imovelNet;
USE imovelNet;

-- Criação da tabela


CREATE TABLE faixa_imovel (
    cd_faixa INTEGER,
    nm_faixa VARCHAR(30),
    vl_minimo DECIMAL(14,2),
    vl_maximo DECIMAL(14,2)
);

CREATE TABLE vendedor (
    cd_vendedor INTEGER PRIMARY KEY,
    nm_vendedor VARCHAR(40),
    nm_endereco VARCHAR(40),
    nr_cpf DECIMAL(11) UNIQUE,
    nm_cidade VARCHAR(20),
    nm_bairro VARCHAR(20),
    sg_estado CHAR(2),
    ds_telefone VARCHAR(20),
    ds_email VARCHAR(80)
);

CREATE TABLE estado (
    cd_estado INTEGER PRIMARY KEY,
    sg_estado CHAR(2),
    nm_estado VARCHAR(20)
);

CREATE TABLE cidade (
    cd_cidade INTEGER PRIMARY KEY,
    sg_estado VARCHAR(2),
    nm_cidade VARCHAR(20),
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(cd_estado)
);

CREATE TABLE bairro (
    cd_bairro INTEGER,
    nm_bairro VARCHAR(20),
    cd_cidade INTEGER,
    sg_estado CHAR(2),
    PRIMARY KEY (cd_bairro, sg_estado)
);

CREATE TABLE comprador (
    cd_comprador INTEGER PRIMARY KEY,
    nm_comprador VARCHAR(40),
    nm_endereco VARCHAR(40),
    nr_cpf DECIMAL(11) UNIQUE,
    nm_cidade VARCHAR(20),
    nm_bairro VARCHAR(20),
    sg_estado CHAR(2),
    ds_telefone VARCHAR(20),
    ds_email VARCHAR(80)
);

CREATE TABLE imovel (
    cd_imovel INTEGER PRIMARY KEY,
    id_bairro INTEGER,
    id_cidade INTEGER,
    sg_estado CHAR(2),
    nm_endereco VARCHAR(40),
    nr_areautil DECIMAL(10,2),
    nr_areatotal DECIMAL(10,2),
    ds_imovel VARCHAR(300),
    vl_preco DECIMAL(16,2),
    nr_ofertas INTEGER,
    st_vendido CHAR(1),
    dt_lancto DATE,
    imovel_vendido INTEGER,
    id_vendedor INTEGER NOT NULL,
    FOREIGN KEY (id_bairro, sg_estado) REFERENCES bairro(cd_bairro, sg_estado),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(cd_vendedor)
);

CREATE TABLE oferta (
    cd_oferta INTEGER PRIMARY KEY,       
    id_comprador INTEGER NOT NULL,       
    id_imovel INTEGER NOT NULL,          
    vl_oferta DECIMAL(16,2) NOT NULL,   
    dt_oferta DATE NOT NULL,              
    FOREIGN KEY (id_comprador) REFERENCES comprador(cd_comprador),
    FOREIGN KEY (id_imovel) REFERENCES imovel(cd_imovel)
);


-- Isenrção de dados


INSERT INTO estado (cd_estado, sg_estado, nm_estado) VALUES (1, 'SP', 'São Paulo');
INSERT INTO estado (cd_estado, sg_estado, nm_estado) VALUES (2, 'RJ', 'Rio De Janeiro');

INSERT INTO cidade (cd_cidade, nm_cidade, sg_estado, id_estado) VALUES (1, 'São Paulo', 'SP', 1);
INSERT INTO cidade (cd_cidade, nm_cidade, sg_estado, id_estado) VALUES (2, 'Santo André', 'SP', 1);
INSERT INTO cidade (cd_cidade, nm_cidade, sg_estado, id_estado) VALUES (3, 'Campinas', 'SP', 1);
INSERT INTO cidade (cd_cidade, nm_cidade, sg_estado, id_estado) VALUES (4, 'Rio de Janeiro', 'RJ', 2);
INSERT INTO cidade (cd_cidade, nm_cidade, sg_estado, id_estado) VALUES (5, 'Niterói', 'RJ', 2);

INSERT INTO bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado) VALUES (1, 'JARDINS', 1, 'SP');
INSERT INTO bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado) VALUES (2, 'MORUMBI', 1, 'SP');
INSERT INTO bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado) VALUES (3, 'AEROPORTO', 1, 'SP');
INSERT INTO bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado) VALUES (1, 'AEROPORTO', 1, 'RJ');
INSERT INTO bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado) VALUES (2, 'FLAMENGO', 1, 'RJ');

INSERT INTO vendedor (cd_vendedor, nm_vendedor, nm_endereco, ds_email) VALUES (1, 'Maria da Silva', 'Rua do Grito, 45', 'msilva@novatec.com.br');
INSERT INTO vendedor (cd_vendedor, nm_vendedor, nm_endereco, ds_email) VALUES (2, 'Marcos Andrade', 'AV. Da Saudade, 325', 'mandrade@novatec.com.br');
INSERT INTO vendedor (cd_vendedor, nm_vendedor, nm_endereco, ds_email) VALUES (3, 'Andre Cardoso', 'AV Brasil, 401', 'acardoso@novatec.com.br');
INSERT INTO vendedor (cd_vendedor, nm_vendedor, nm_endereco, ds_email) VALUES (4, 'Tatiana Souza', 'Rua do Imperador, 778', 'tsouza@novatec.com.br');

INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (1, 1, 1, 1, 'SP', 'AL Tiete, 3304 AP 101', 250, 400, 180000); 
INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (2, 1, 2, 1, 'SP', 'AV Morumbi, 2230', 150, 250, 135000);
INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (3, 2, 1, 1, 'RJ', 'R Gal Osorio, 445 AP 34', 250, 400, 185000);
INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (4, 2, 2, 1, 'RJ', 'R D Pedro I, 882', 120, 200, 110000);
INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (5, 3, 3, 1, 'SP', 'AV Rubem Berta, 2355', 110, 200, 95000);
INSERT INTO imovel (cd_imovel, id_vendedor, id_bairro, id_cidade, sg_estado, nm_endereco, nr_areautil, nr_areatotal, vl_preco) 
VALUES (6, 4, 1, 1, 'RJ', 'R Getulio Vargas, 552', 200, 300, 99000);
 
INSERT INTO comprador (cd_comprador, nm_comprador, nm_endereco, ds_email) VALUES (1, 'Emmanuel Antunes', 'R Saraiva, 452', 'eantunes@novatec.com.br');
INSERT INTO comprador (cd_comprador, nm_comprador, nm_endereco, ds_email) VALUES (2, 'Joana Pereira', 'AV Portugal, 52', 'jpereira@novatec.com.br');
INSERT INTO comprador (cd_comprador, nm_comprador, nm_endereco, ds_email) VALUES (3, 'Ronaldo Campelo', 'R Estados Unidos, 790', 'rcampelo@novatec.com.br');
INSERT INTO comprador (cd_comprador, nm_comprador, nm_endereco, ds_email) VALUES (4, 'Manfred Augusto', 'AV Brasil, 351', 'maugusto@novatec.com.br');

INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (1, 1, 1, 170000, '2002-01-10');
INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (2, 1, 3, 180000, '2002-01-10');
INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (3, 2, 2, 135000, '2002-02-15');
INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (4, 2, 4, 100000, '2002-01-05');
INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (5, 3, 1, 160000, '2002-01-10');
INSERT INTO oferta (cd_oferta, id_comprador, id_imovel, vl_oferta, dt_oferta) VALUES (6, 3, 2, 140000, '2002-02-20');


-- ATUALIZAÇÕES


UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 1;
UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 2;
UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 3;
UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 4;
UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 5;
UPDATE imovel SET vl_preco = vl_preco * 1.10 WHERE cd_imovel = 6;

UPDATE imovel SET vl_preco = ROUND(vl_preco * 0.95, 2) WHERE id_vendedor = 1;

UPDATE oferta SET vl_oferta = vl_oferta * 1.05 WHERE id_comprador = 2;


-- CONSULTAS E EXERCÍCIOS


-- atividade 1 até o 20.
-- select * from bairro;
-- select cd_comprador, nm_comprador, ds_email from comprador;
-- select cd_vendedor, nm_vendedor, ds_email from vendedor order by nm_vendedor;
-- select cd_vendedor, nm_vendedor, ds_email from vendedor order by nm_vendedor desc;
-- select cd_bairro, nm_bairro, sg_estado from bairro where sg_estado like 'SP%';
-- select cd_imovel, id_vendedor, vl_preco from imovel where id_vendedor like '2%';
-- select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 and sg_estado like 'RJ%';
-- select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 or id_vendedor like '1%';
-- select cd_imovel, id_vendedor, vl_preco, sg_estado from imovel where vl_preco <= 150000 and not id_vendedor like '2%';
-- select cd_comprador, nm_comprador, nm_endereco, sg_estado from comprador where sg_estado like 'null%';
-- select cd_comprador, nm_comprador, nm_endereco, sg_estado from comprador where sg_estado is not null;
-- select * from oferta where vl_oferta between 100000 and 150000;
-- select * from oferta where dt_oferta between '2002/02/01' and '2002/03/01';
-- select * from vendedor where nm_vendedor like 'M%';
-- select * from vendedor where nm_vendedor like '_a%';
-- select * from comprador where nm_endereco like '%U%';
-- select * from oferta where id_imovel = 1 or id_imovel = 2;
-- select * from imovel where cd_imovel = 2 or cd_imovel = 3 order by nm_endereco;
-- select * from oferta where id_imovel = 2 or id_imovel = 3 and vl_oferta >= 140000 order by dt_oferta desc;
-- select * from imovel where vl_preco between 110000 and 200000;

-- 10 atividades de date
-- select current_date() from dual;
-- select cd_imovel, vl_preco, vl_preco * 1.10 as vl_preco_com_aumento from imovel;
-- select cd_imovel, vl_preco, (vl_preco * 1.10) - vl_preco as diferenca from imovel where cd_imovel in (1,2);
-- select upper(nm_vendedor) as nm_vendedor, lower(ds_email) as ds_email from vendedor;
-- select concat(nm_comprador, ' - ', nm_cidade) AS comprador_cidade from comprador;
-- select * from comprador where nm_comprador like '%A%';
-- select left(nm_comprador, 1) as Primeira_Letra, nm_bairro from comprador;
-- select id_imovel as cd_imovel, datediff(curdate(), dt_oferta) as dias from oferta;
-- select cd_imovel, dt_lancto, datediff(curdate(), dt_lancto) as dias from imovel;
-- select cd_imovel, dt_lancto, DATEDIFF(CURDATE(), dt_lancto) AS dias, DATE_ADD(dt_lancto, INTERVAL 15 DAY) AS mais_15_dias from imovel;

-- atividade de JOIN 1 - 10
-- SELECT i.cd_imovel, v.cd_vendedor, v.nm_vendedor, v.sg_estado from imovel i INNER JOIN vendedor v ON i.id_vendedor = v.cd_vendedor;
-- select a.cd_comprador, a.nm_comprador, b.cd_imovel, c.vl_oferta from comprador a inner join oferta c on a.cd_comprador = c.id_comprador inner join imovel b on c.id_imovel = b.cd_imovel;
-- SELECT i.cd_imovel, i.vl_preco, b.nm_bairro FROM imovel i INNER JOIN bairro b ON i.id_bairro = b.cd_bairro WHERE i.id_vendedor = 3;
-- SELECT DISTINCT i.* FROM imovel i INNER JOIN oferta o ON i.cd_imovel = o.id_imovel;
-- SELECT i.*, o.vl_oferta FROM imovel i LEFT JOIN oferta o ON i.cd_imovel = o.id_imovel;
-- SELECT c.cd_comprador, c.nm_comprador, o.id_imovel, o.vl_oferta FROM comprador c INNER JOIN oferta o ON c.cd_comprador = o.id_comprador;
-- SELECT c.cd_comprador, c.nm_comprador, o.id_imovel, o.vl_oferta FROM comprador c LEFT JOIN oferta o ON c.cd_comprador = o.id_comprador;
-- SELECT i.nm_endereco AS endereco_imovel, indicado.nm_endereco AS endereco_imovel_indicado FROM imovel i INNER JOIN imovel indicado ON i.imovel_vendido = indicado.cd_imovel;
-- SELECT i.nm_endereco AS endereco_imovel, v1.nm_vendedor AS vendedor_imovel, indicado.nm_endereco AS endereco_imovel_indicado, v2.nm_vendedor AS vendedor_imovel_indicado FROM imovel i INNER JOIN imovel indicado ON i.imovel_vendido = indicado.cd_imovel INNER JOIN vendedor v1 ON i.id_vendedor = v1.cd_vendedor INNER JOIN vendedor v2 ON indicado.id_vendedor = v2.cd_vendedor;
-- SELECT i.nm_endereco, b.nm_bairro, f.nm_faixa FROM imovel i INNER JOIN bairro b ON i.id_bairro = b.cd_bairro INNER JOIN faixa_imovel f ON i.vl_preco BETWEEN f.vl_minimo AND f.vl_maximo;

-- exercicios de agrupamento Capitulo 9
-- select max(vl_oferta), min(vl_oferta), avg(vl_oferta) from oferta;
-- select stddev(vl_preco), variance(vl_preco) from imovel;
-- select round(stddev(vl_preco), 2) as desvio_padrao, round(variance(vl_preco), 2) as variancia from imovel;
-- select max(vl_preco), min(vl_preco), avg(vl_preco), sum(vl_preco) from imovel;
-- select b.nm_bairro, max(vl_preco), min(vl_preco), avg(vl_preco), sum(vl_preco) from imovel i inner join bairro b on i.id_bairro = b.cd_bairro group by b.nm_bairro;
-- select v.cd_vendedor, v.nm_vendedor, count(i.cd_imovel) from vendedor v inner join imovel i on v.cd_vendedor = i.id_vendedor group by v.cd_vendedor, v.nm_vendedor;
-- select max(vl_preco) - min(vl_preco) as diferenca from imovel;
-- select id_vendedor, min(vl_preco) from imovel where vl_preco >= 10000 group by id_vendedor;
-- select c.cd_comprador, c.nm_comprador, avg(o.vl_oferta), count(o.cd_oferta) from comprador c inner join oferta o on c.cd_comprador = o.id_comprador group by c.cd_comprador, c.nm_comprador;
-- select count(cd_oferta) as total_ofertas from oferta where dt_oferta between '2000-01-01' and '2002-12-31';

-- exercicios de subqueries de 1 a 12
-- 1 de 12
SELECT * FROM imovel WHERE id_bairro = (SELECT id_bairro FROM imovel WHERE cd_imovel = 2) AND cd_imovel <> 2;

-- 2 de 12
SELECT * FROM imovel WHERE vl_preco > (SELECT AVG(vl_preco) FROM imovel);

-- 3 de 12
SELECT * FROM comprador WHERE cd_comprador IN (SELECT id_comprador FROM oferta WHERE vl_oferta > 70000);

-- 4 de 12
SELECT * FROM imovel WHERE cd_imovel IN (SELECT id_imovel FROM oferta WHERE vl_oferta > (SELECT AVG(vl_oferta) FROM oferta));

-- 5 de 12
SELECT * FROM imovel i WHERE vl_preco > (SELECT AVG(i2.vl_preco) FROM imovel i2 WHERE i2.id_bairro = i.id_bairro);

-- 6 de 12
SELECT id_bairro, MAX(vl_preco) AS maior_preco FROM imovel GROUP BY id_bairro HAVING MAX(vl_preco) > (SELECT AVG(vl_preco) FROM imovel);

-- 7 de 12
SELECT * FROM imovel i WHERE vl_preco = (SELECT MIN(i2.vl_preco) FROM imovel i2 WHERE i2.id_vendedor = i.id_vendedor);

-- 8 de 12
SELECT o.* FROM oferta o WHERE o.id_imovel IN (SELECT cd_imovel FROM imovel WHERE id_vendedor = 2 AND (DATEDIFF(CURDATE(), dt_lancto) < 30 OR DATEDIFF(CURDATE(), dt_lancto) > 180));

-- 9 de 12
SELECT * FROM imovel i WHERE vl_preco = (SELECT MIN(vl_preco) FROM imovel i2 WHERE i2.id_vendedor = i.id_vendedor);

-- 10 de 12
SELECT * FROM oferta WHERE vl_oferta < ALL (SELECT vl_oferta FROM oferta WHERE id_comprador = 2) AND id_comprador <> 2;

-- 11 de 12
SELECT * FROM imovel WHERE sg_estado = (SELECT sg_estado FROM vendedor WHERE cd_vendedor = 3) AND id_cidade = (SELECT id_cidade FROM imovel WHERE id_vendedor = 3 LIMIT 1) AND id_vendedor <> 3;

-- 12 de 12
SELECT DISTINCT b.nm_bairro FROM bairro b WHERE b.cd_bairro = (SELECT id_bairro FROM imovel WHERE cd_imovel = 5) AND b.sg_estado = (SELECT sg_estado FROM imovel WHERE cd_imovel = 5);

-- atividade pesquisa ETEC

-- 1 de 10
SELECT cd_comprador AS codigo, nm_comprador AS nome FROM comprador
UNION ALL
SELECT cd_vendedor AS codigo, nm_vendedor AS nome FROM vendedor;

-- 2 de 10
SELECT cd_comprador AS codigo, nm_comprador AS nome FROM comprador
UNION
SELECT cd_vendedor AS codigo, nm_vendedor AS nome FROM vendedor;

-- 3 de 10
SELECT v.nm_vendedor, i.nm_endereco 
FROM vendedor v 
INNER JOIN imovel i ON v.cd_vendedor = i.id_vendedor 
INNER JOIN oferta o ON i.cd_imovel = o.id_imovel 
WHERE o.id_comprador = 2 OR i.id_bairro = 1;

-- 4 de 10
SELECT c.cd_comprador, c.nm_comprador 
FROM comprador c 
LEFT JOIN oferta o ON c.cd_comprador = o.id_comprador 
WHERE o.id_comprador IS NULL;

-- 5 de 10
SELECT v.cd_vendedor, v.nm_vendedor 
FROM vendedor v 
LEFT JOIN imovel i ON v.cd_vendedor = i.id_vendedor 
WHERE i.id_vendedor IS NULL;

-- 6 de 10
SELECT DISTINCT v.cd_vendedor, v.nm_vendedor 
FROM vendedor v 
INNER JOIN imovel i ON v.cd_vendedor = i.id_vendedor;

-- 7 de 10
SELECT DISTINCT c.cd_comprador, c.nm_comprador 
FROM comprador c 
INNER JOIN oferta o ON c.cd_comprador = o.id_comprador;

-- 8 de 10
SELECT cd_imovel, nm_endereco, vl_preco AS preco_original,
   CASE
       WHEN vl_preco > 100000 THEN vl_preco * 0.90
       WHEN vl_preco > 50000 AND vl_preco <= 100000 THEN vl_preco * 0.95
       WHEN vl_preco > 30000 AND vl_preco <= 50000 THEN vl_preco * 0.97
       ELSE vl_preco
   END AS preco_com_desconto
FROM imovel;

-- 9 de 10
SELECT nm_endereco, id_vendedor,
   CASE
       WHEN st_vendido = 'S' THEN 'VENDIDO'
       ELSE 'DISPONIVEL'
   END AS situacao
FROM imovel;

-- 10 de 10
SELECT id_comprador,
   CASE
       WHEN dt_oferta < CURDATE() - INTERVAL 30 DAY THEN 'ANTIGA'
       ELSE 'NOVA'
   END AS classificacao
FROM oferta;


-- Criação de view


-- 4 de 9
CREATE VIEW vVENDEDOR AS
SELECT
    cd_vendedor,
    nm_vendedor,
    nm_endereco
FROM vendedor;

-- 5 de 9
-- SELECT * FROM vVENDEDOR;

-- 6 de 9
CREATE VIEW vIMOVEL_BAIRRO1 AS
SELECT
    cd_imovel,
    nm_endereco,
    vl_preco
FROM imovel
WHERE id_bairro = 1;

-- 7 de 9
CREATE VIEW vIMOVEL AS
SELECT
    v.nm_vendedor,
    i.nm_endereco,
    b.nm_bairro,
    c.nm_cidade,
    e.nm_estado
FROM imovel i
INNER JOIN vendedor v ON i.id_vendedor = v.cd_vendedor
INNER JOIN bairro b ON i.id_bairro = b.cd_bairro AND i.sg_estado = b.sg_estado
INNER JOIN cidade c ON i.id_cidade = c.cd_cidade AND i.sg_estado = c.sg_estado
INNER JOIN estado e ON c.id_estado = e.cd_estado;

-- 8 de 9
CREATE VIEW vIMOVEL_CIDADE AS
SELECT
    c.nm_cidade,
    AVG(i.vl_preco) AS preco_medio
FROM imovel i
INNER JOIN cidade c ON i.id_cidade = c.cd_cidade AND i.sg_estado = c.sg_estado
GROUP BY c.nm_cidade;

-- 9 de 9
CREATE VIEW vOFERTA AS
SELECT
    c.nm_comprador,
    o.vl_oferta,
    i.nm_endereco
FROM oferta o
INNER JOIN comprador c ON o.id_comprador = c.cd_comprador
INNER JOIN imovel i ON o.id_imovel = i.cd_imovel;