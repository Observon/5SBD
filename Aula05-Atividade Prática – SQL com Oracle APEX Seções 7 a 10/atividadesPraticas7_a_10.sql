-- Atividade Prática – SQL com Oracle APEX
-- Seções 7 a 9 – Oracle Academy: Database Programming with SQL
-- Tema: Junções, funções de agregação, agrupamentos e operadores de conjunto.
-- Ferramenta: Oracle APEX – SQL Workshop
-- Base de dados utilizada: Sistema bancário com tabelas agencia, cliente, conta, emprestimo.

-- Parte 1 – Junções e Produto Cartesiano (Seção 7)
-- 1. Usando a sintaxe proprietária da Oracle, exiba o nome de cada cliente junto com o número de sua conta.
--R:
SELECT c.cliente_nome, cc.conta_numero
FROM cliente c, conta cc
WHERE c.cliente_cod = cc.cliente_cliente_cod;

-- 2. Mostre todas as combinações possíveis de clientes e agências (produto cartesiano).
--R:
SELECT c.cliente_nome, a.agencia_nome
FROM cliente c, agencia a;

-- 3. Usando aliases de tabela, exiba o nome dos clientes e a cidade da agência onde mantêm conta.
--R:
SELECT c.cliente_nome, a.agencia_cidade
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
JOIN agencia a ON cc.agencia_agencia_cod = a.agencia_cod;

-- Parte 2 – Funções de Grupo, COUNT, DISTINCT e NVL (Seção 8)
-- 4. Exiba o saldo total de todas as contas cadastradas.
--R:
SELECT SUM(c.saldo) AS "SALDO TOTAL"
FROM conta c;

-- 5. Mostre o maior saldo e a média de saldo entre todas as contas.
--R:
SELECT MAX(c.saldo) AS "MAIOR SALDO", AVG(c.saldo) AS "MÉDIA SALDO"
FROM conta c;

-- 6. Apresente a quantidade total de contas cadastradas.
--R:
SELECT COUNT(c.conta_numero) AS "QUANTIDADE DE CONTAS"
FROM conta c;

-- 7. Liste o número de cidades distintas onde os clientes residem.
--R:
SELECT COUNT(DISTINCT c.cidade) AS "QUANTIDADE DE CIDADES"
FROM cliente c;

-- 8. Exiba o número da conta e o saldo, substituindo valores nulos por zero.
--R:
SELECT c.conta_numero, NVL(c.saldo, 0) AS "SALDO"
FROM conta c;

-- Parte 3 – GROUP BY, HAVING, ROLLUP e Operadores de Conjunto (Seção 9)
-- 9. Exiba a média de saldo por cidade dos clientes.
--R:
SELECT c.cidade, AVG(cc.saldo) AS "MÉDIA SALDO"
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
GROUP BY c.cidade;

-- 10. Liste apenas as cidades com mais de 3 contas associadas a seus moradores.
--R:
SELECT c.cidade, COUNT(cc.conta_numero) AS "QUANTIDADE DE CONTAS"
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
GROUP BY c.cidade
HAVING COUNT(cc.conta_numero) > 3;

-- 11.Utilize a cláusula ROLLUP para exibir o total de saldos por cidade da agência e o total geral.
--R:
SELECT a.agencia_cidade, SUM(cc.saldo) AS "TOTAL SALDO"
FROM agencia a
JOIN conta cc ON a.agencia_cod = cc.agencia_agencia_cod
GROUP BY a.agencia_cidade WITH ROLLUP;

-- 12. Faça uma consulta com UNION que combine os nomes de cidades dos clientes e das agências, sem repetições.
--R:
SELECT c.cidade AS "CIDADE"
FROM cliente c
UNION
SELECT a.agencia_cidade AS "CIDADE"
FROM agencia a;

-- Atividade Prática – SQL com Oracle APEX
-- Seção 10 – Subconsultas
-- Tema: Subconsultas de linha única, multilinha, correlacionadas, com EXISTS, NOT EXISTS e a cláusula WITH.
-- Ferramenta: Oracle APEX – SQL Workshop
-- Base de dados utilizada: Sistema bancário (agencia, cliente, conta, emprestimo)

-- Parte 1 – Subconsultas de Linha Única
-- 1. Liste os nomes dos clientes cujas contas possuem saldo acima da média geral de todas as contas registradas.
--R:
SELECT c.cliente_nome
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo > (SELECT AVG(saldo) FROM conta);

-- 2. Exiba os nomes dos clientes cujos saldos são iguais ao maior saldo encontrado no banco.
--R:
SELECT c.cliente_nome
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo = (SELECT MAX(saldo) FROM conta);

-- 3. Liste as cidades onde a quantidade de clientes é maior que a quantidade média de clientes por cidade.
--R:
SELECT c.cidade
FROM cliente c
GROUP BY c.cidade
HAVING COUNT(c.cliente_cod) > (SELECT AVG(quantidade) FROM (SELECT COUNT(cliente_cod) AS quantidade FROM cliente GROUP BY cidade));

-- Parte 2 – Subconsultas Multilinha
-- 4. Liste os nomes dos clientes com saldo igual a qualquer um dos dez maiores saldos registrados.
--R:
SELECT c.cliente_nome
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo IN (SELECT saldo FROM (SELECT saldo FROM conta ORDER BY saldo DESC) WHERE ROWNUM <= 10);
-- 5. Liste os clientes que possuem saldo menor que todos os saldos dos clientes da cidade de Niterói.
--R:
SELECT c.cliente_nome
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo < ALL (SELECT saldo FROM conta WHERE cliente_cliente_cod IN (SELECT cliente_cod FROM cliente WHERE cidade = 'Niterói'));

-- 6. Liste os clientes cujos saldos estão entre os saldos de clientes de Volta Redonda.
--R:
SELECT c.cliente_nome
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo BETWEEN (SELECT MIN(saldo) FROM conta WHERE cliente_cliente_cod IN (SELECT cliente_cod FROM cliente WHERE cidade = 'Volta Redonda'))
AND (SELECT MAX(saldo) FROM conta WHERE cliente_cliente_cod IN (SELECT cliente_cod FROM cliente WHERE cidade = 'Volta Redonda'));

-- Parte 3 – Subconsultas Correlacionadas
-- 7. Exiba os nomes dos clientes cujos saldos são maiores que a média de saldo das contas da mesma agência.
--R:
SELECT c.cliente_nome                                                               
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo > (SELECT AVG(saldo) FROM conta WHERE agencia_agencia_cod = cc.agencia_agencia_cod);

-- 8. Liste os nomes e cidades dos clientes que têm saldo inferior à média de sua própria cidade.
--R:
SELECT c.cliente_nome, c.cidade
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
WHERE cc.saldo < (SELECT AVG(saldo) FROM conta WHERE cliente_cliente_cod IN (SELECT cliente_cod FROM cliente WHERE cidade = c.cidade));

-- Parte 4 – Subconsultas com EXISTS e NOT EXISTS
-- 9. Liste os nomes dos clientes que possuem pelo menos uma conta registrada no banco.
--R:
SELECT c.cliente_nome
FROM cliente c
WHERE EXISTS (SELECT 1 FROM conta cc WHERE c.cliente_cod = cc.cliente_cliente_cod);

-- 10. Liste os nomes dos clientes que ainda não possuem conta registrada no banco.
--R:
SELECT c.cliente_nome
FROM cliente c
WHERE NOT EXISTS (SELECT 1 FROM conta cc WHERE c.cliente_cod = cc.cliente_cliente_cod);

-- Parte 5 – Subconsulta Nomeada com WITH
-- 11.Usando a cláusula WITH, calcule a média de saldo por cidade e exiba os clientes que possuem saldo acima da média de sua cidade.
--R:
WITH media_saldo AS (
    SELECT c.cidade, AVG(cc.saldo) AS media
    FROM cliente c
    JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
    GROUP BY c.cidade
)
SELECT c.cliente_nome, c.cidade, cc.saldo
FROM cliente c
JOIN conta cc ON c.cliente_cod = cc.cliente_cliente_cod
JOIN media_saldo ms ON c.cidade = ms.cidade
WHERE cc.saldo > ms.media;