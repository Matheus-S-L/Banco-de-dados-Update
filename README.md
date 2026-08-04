 -- atividade de PESQUISA ETEC - TRABALHO
-- 1 de 10
 
SELECT cd_comprador AS codigo,
       nm_comprador AS nome
FROM comprador
 
UNION ALL
 
SELECT cd_vendedor AS codigo,
       nm_vendedor AS nome
FROM vendedor;
 
-- 2 de 10
 
SELECT cd_comprador AS codigo,
       nm_comprador AS nome
FROM comprador
 
UNION
 
SELECT cd_vendedor AS codigo,
       nm_vendedor AS nome
FROM vendedor;
 
-- 3 de 10
 
SELECT v.nm_vendedor,
       i.nm_endereco
FROM vendedor v
INNER JOIN imovel i
    ON v.cd_vendedor = i.id_vendedor
INNER JOIN oferta o
    ON i.cd_imovel = o.id_imovel
WHERE o.id_comprador = 2
   OR i.id_bairro = 1;
-- 4 de 10
 
SELECT c.cd_comprador,
       c.nm_comprador
FROM comprador c
LEFT JOIN oferta o
    ON c.cd_comprador = o.id_comprador
WHERE o.id_comprador IS NULL;
 
-- 5 de 10
 
SELECT v.cd_vendedor,
       v.nm_vendedor
FROM vendedor v
LEFT JOIN imovel i
    ON v.cd_vendedor = i.id_vendedor
WHERE i.id_vendedor IS NULL;
 
-- 6 de 10
 
SELECT DISTINCT v.cd_vendedor,
       v.nm_vendedor
FROM vendedor v
INNER JOIN imovel i
    ON v.cd_vendedor = i.id_vendedor;
-- 7 de 10
 
SELECT DISTINCT c.cd_comprador,
       c.nm_comprador
FROM comprador c
INNER JOIN oferta o
    ON c.cd_comprador = o.id_comprador;
-- 8 de 10
 
SELECT cd_imovel,
       nm_endereco,
       vl_preco AS preco_original,
 
       CASE
           WHEN vl_preco > 100000
               THEN vl_preco * 0.90
 
           WHEN vl_preco > 50000
               AND vl_preco <= 100000
               THEN vl_preco * 0.95
 
           WHEN vl_preco > 30000
               AND vl_preco <= 50000
               THEN vl_preco * 0.97
 
           ELSE vl_preco
       END AS preco_com_desconto
 
FROM imovel;
 
-- 9 de 10
 
SELECT nm_endereco,
       id_vendedor,
 
       CASE
           WHEN st_vendido = 'S'
               THEN 'VENDIDO'
 
           ELSE 'DISPONIVEL'
       END AS situacao
 
FROM imovel;
 
-- 10 de 10
 
SELECT id_comprador,
 
       CASE
           WHEN dt_oferta < CURDATE() - INTERVAL 30 DAY
               THEN 'ANTIGA'
 
           ELSE 'NOVA'
       END AS classificacao
 
FROM oferta;
