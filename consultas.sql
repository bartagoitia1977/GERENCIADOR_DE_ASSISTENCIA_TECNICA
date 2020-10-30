/* Consultas por demanda do banco de dados Assistencia Tecnica */

/* 1) Listar peças requisitadas por técnico */

select t.id as id_tecnico,t.nome as nome_do_tecnico,p.cod_peca as codigo_da_peça,p.descricao
from tecnico t inner join requisita r on t.id = r.id_fk inner join peca p on r.cod_peca_fk = p.cod_peca
order by t.nome;

/* 2) Calcular tempo de reparo médio por OS */

select (sum(data_ter - data_ini)/count(*)) as tempo_medio_de_reparo_em_dias
from os;

/* 3) Calcular media de OS’s por técnico */

select round(avg(count(*)),2) as media_os_por_tecnico
from tecnico t inner join os o on t.id = o.id_tec_os_fk
group by t.id;

/* 4) Listar os fabricantes de equipamentos com mais reparos */

select e.fabricante,count(*) as quantidade_reparos
from reparo r inner join equipamento e on r.ns_fk = e.ns
group by e.fabricante
order by count(*) desc;

/* 5) Listar OS por cliente */

select o.numero_os,c.id as id_do_cliente,c.nome_fantasia,o.tipo,o.desc_serv,o.data_ini,o.data_ter,o.data_ger
from os o inner join cliente c on o.id_cli_os_fk = c.id;

/* 6) Listar contratos por cliente */

select d.numero_con as numero_do_contrato,c.id as id_do_cliente,c.nome_fantasia,d.data_ini,d.data_ter
from cliente c inner join contrato_desconto d on c.id = d.id_cli_con_fk
order by c.id;

/* 7) Listar os clientes que possuam equipamentos da marca ‘Fujitsu’ */

select c.id as id_do_cliente,c.nome_fantasia
from cliente c
where c.id in (select d.id_cli_con_fk from contrato_desconto d
    where d.id_cli_con_fk in (select e.numero_con_fk from equipamento e
        where e.fabricante = 'Fujitsu'));

/* 8) Listar clientes por filial */

select m.id as id_filial,m.nome_fantasia as nome_fantasia_filial,m.id_matriz_fk as id_matriz,c.nome_fantasia as nome_fantasia_matriz
from cliente m inner join cliente c on m.id_matriz_fk = c.id;

/* 9) Listar equipamentos por fabricante */

SELECT modelo, fabricante
FROM equipamento
ORDER BY fabricante, modelo ASC;

/* 10) Listar equipamentos de um fabricante específico */

SELECT modelo, fabricante
FROM equipamento
WHERE fabricante = 'Epson'
ORDER BY fabricante, modelo ASC;

/* 11) Listar quantidade de equipamentos agrupados por fabricante */

SELECT fabricante, COUNT(*) AS quantidade
FROM equipamento
GROUP BY fabricante
ORDER BY quantidade DESC;

/* 12) Listar quantidade de OS por técnico em ordem descrescente */

SELECT tecnico.nome, count(*) AS quantidade
FROM tecnico
INNER JOIN os
ON tecnico.id = os.ID_TEC_OS_FK
GROUP BY tecnico.nome
ORDER BY quantidade DESC;

/* 13) Listar quais técnicos tem mais os realizadas */

SELECT nome, quantidade
FROM (
 SELECT tecnico.nome, COUNT(*) AS quantidade
 FROM tecnico
 INNER JOIN os
 ON tecnico.id = os.ID_TEC_OS_FK
 GROUP BY tecnico.nome
)
WHERE quantidade = (
 SELECT MAX(COUNT(*)) AS quantidade
 FROM tecnico
 INNER JOIN os
 ON tecnico.id = os.ID_TEC_OS_FK
 GROUP BY tecnico.nome
);

/* 14) Listar quais técnicos tem menos os realizadas */

SELECT nome, quantidade
FROM (
 SELECT tecnico.nome, COUNT(*) AS quantidade
 FROM tecnico
 INNER JOIN os
 ON tecnico.id = os.ID_TEC_OS_FK
 GROUP BY tecnico.nome
)
WHERE quantidade = (
 SELECT MIN(COUNT(*)) AS quantidade
 FROM tecnico
 INNER JOIN os
 ON tecnico.id = os.ID_TEC_OS_FK
 GROUP BY tecnico.nome
);

/* 15) Listar OS por técnico */

SELECT tecnico.nome, os.numero_os, os.tipo, os.desc_serv AS "DESCRICAO
DO SERVIÇO"
FROM tecnico
INNER JOIN os ON tecnico.id=os.id_tec_os_FK
ORDER BY tecnico.nome;

/* 16) Listar OS por equipamento */

SELECT equipamento.modelo AS "MODELO DO EQUIPAMENTO", equipamento.ns as
"NUMERO DE SERIE", os.numero_os, os.tipo, os.desc_serv AS "DESCRICAO DO
SERVIÇO"
FROM equipamento
INNER JOIN os ON equipamento.ns=os.ns_FK
ORDER BY equipamento.modelo;

/* 17) Listar Média total dos valores de contratos */

select round(avg(valor),2) as media_valor_contratos
from contrato_desconto;

/* 18) Listar contratos ordenados por descontos */

select *
from contrato_desconto
order by porc_desc;

/* 19) Listar OS a partir de uma data X */

select *
from OS
where data_ini > date '2019-01-15'
order by data_ini;

/* 20) Projetar número de contrato de um cliente, nome fantasia do cliente,
data de ínicio e fim do contrato. Dados esses projetados a partir de um 
intervalo X de clientes ordenados pelo número do contrato. */

select con.numero_con, cli.nome_fantasia, con.data_ini, con.data_ter
from cliente cli, contrato_desconto con
where cli.id > 00001 and cli.id < 00005
order by con.numero_con;

/* 21) Listar quantos técnicos são do estado de Pernambuco e moram no Recife */

select count(id) as tecnicos_recife_pe
from tecnico tec
where end_estado = 'PE' and end_cidade = 'Recife';

/* 22) Listar os modelos de equipamentos que não sofreram reparos */

select eq.modelo,eq.fabricante
from equipamento eq left join reparo r
on eq.ns = r.ns_FK
where r.id_reparo is null;

/* 23) Listar a quantidade de peças que não foram requisitadas pelo técnico */

select count(pe.cod_peca) as pecas_nao_requisitadas
from tecnico tec right join requisita req 
on tec.id = req.id_FK right join
peca pe on pe.cod_peca = req.cod_peca_FK
where req.cod_peca_FK is null;

/* 24) Listar todas as ordens de serviço realizadas por um técnico específico (id numero 7) */

select tec.nome, o.numero_os, o.data_ini
from tecnico tec full outer join os o
on tec.id = o.id_tec_os_FK
where tec.id = 7
order by o.data_ini;

/* 25) Listar contratos com descontos entre 5% e 10% */

select numero_con as contrato, porc_desc as desconto
from contrato_desconto
where porc_desc between 5 and 10;

/* 26) Listar todos os clientes cujo o nome comece com a letra ‘A’ */

select id as numero, nome_fantasia as nome
from cliente
where nome_fantasia like 'A%';

/* 27) Listar contratos que possuem descontos maiores que 5% */

select numero_con as contrato, sum(porc_desc) as desconto
from contrato_desconto
group by numero_con 
having sum(porc_desc) > 5;

/* 28) Listar todos os clientes com todas as informações */

SELECT * FROM cliente;

/* 29) Listar todos os tecnicos */

SELECT * FROM tecnico;

/* 30) Listar todos os equipamentos */

SELECT equipamento.ns AS "Numero de Serie", equipamento.modelo, equipamento.fabricante FROM equipamento;

/* 31) Listar equipamentos por Cliente */

SELECT equipamento.ns AS "Numero de Serie", equipamento.modelo, equipamento.fabricante, cliente.cnpj, cliente.nome_fantasia AS "Nome Fantasia" FROM equipamento
INNER JOIN contrato_desconto ON equipamento.numero_con_FK = contrato_desconto.id_cli_con_FK
INNER JOIN cliente ON contrato_desconto.id_cli_con_FK = cliente.id;

/* 32) Listar a quantidade de reparos  por equipamento*/

SELECT reparo.numero_reparos AS "numero de reparos", equipamento.ns AS "numero de serie", equipamento.modelo, equipamento.fabricante  FROM reparo
INNER JOIN equipamento ON equipamento.ns = reparo.ns_FK
ORDER BY reparo.numero_reparos DESC;