-- Atividade Prática – SQL com Oracle APEX
-- Seções 4 a 6 – Oracle Academy: Database Programming with SQL
-- Tema: Funções de linha única, manipulação de nulos, conversões e junções.
-- Ferramenta: Oracle APEX – SQL Workshop
-- Base de dados utilizada: Sistema bancário com tabelas agencia, cliente, conta, emprestimo.
-- CREATE TABLE agencia (
--     agencia_cod    INTEGER NOT NULL,
--     agencia_nome   VARCHAR2(40 CHAR),
--     agencia_cidade VARCHAR2(40 CHAR),
--     fundos         NUMBER(7, 2));

-- ALTER TABLE agencia ADD CONSTRAINT agencia_pk PRIMARY KEY ( agencia_cod ); CREATE TABLE cliente (
--     cliente_cod  INTEGER NOT NULL,
--     cliente_nome VARCHAR2(30 CHAR),
--     rua          VARCHAR2(30 CHAR),
--     cidade       VARCHAR2(40 CHAR));

-- ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cliente_cod );CREATE TABLE conta (
--     conta_numero        INTEGER NOT NULL,
--     saldo               NUMBER(7, 2) NOT NULL,
--     cliente_cliente_cod INTEGER NOT NULL,
--     agencia_agencia_cod INTEGER NOT NULL);

-- ALTER TABLE conta ADD CONSTRAINT conta_pk PRIMARY KEY ( conta_numero );
-- CREATE TABLE emprestimo (
--     emprestimo_numero   INTEGER NOT NULL,
--     quantia             NUMBER(7, 2) NOT NULL,
--     cliente_cliente_cod INTEGER NOT NULL,
--     agencia_agencia_cod INTEGER NOT NULL);

-- ALTER TABLE emprestimo ADD CONSTRAINT emprestimo_pk PRIMARY KEY ( emprestimo_numero );ALTER TABLE conta
--     ADD CONSTRAINT conta_agencia_fk FOREIGN KEY ( agencia_agencia_cod )
--         REFERENCES agencia ( agencia_cod );

-- ALTER TABLE conta
--     ADD CONSTRAINT conta_cliente_fk FOREIGN KEY ( cliente_cliente_cod )
--         REFERENCES cliente ( cliente_cod );

-- ALTER TABLE emprestimo
--     ADD CONSTRAINT emprestimo_agencia_fk FOREIGN KEY ( agencia_agencia_cod )
--         REFERENCES agencia ( agencia_cod );

-- ALTER TABLE emprestimo
--     ADD CONSTRAINT emprestimo_cliente_fk FOREIGN KEY ( cliente_cliente_cod )
--         REFERENCES cliente ( cliente_cod );

--Parte 1 – Funções de Caracteres, Números e Datas (Seção 4)

-- 1. Exiba os nomes dos clientes com todas as letras em maiúsculas.
-- R:
SELECT UPPER(c.cliente_nome) AS "NOME MAIÚSCULO"
FROM cliente c;

-- 2. Exiba os nomes dos clientes formatados com apenas a primeira letra maiúscula.
--R:
SELECT INITCAP(c.cliente_nome) AS "NOME FORMATADO"
FROM cliente c;

-- 3. Mostre as três primeiras letras do nome de cada cliente.
-- R:
SELECT SUBSTR(c.cliente_nome, 1, 3) AS "TRÊS PRIMEIRAS LETRAS"
FROM cliente c;

-- 4. Exiba o número de caracteres do nome de cada cliente.
-- R:
SELECT LENGTH(c.cliente_nome) AS "NÚMERO DE CARACTERES"
FROM cliente c;

-- 5. Apresente o saldo de todas as contas, arredondado para o inteiro mais próximo.
-- R:
SELECT ROUND(c.saldo) AS "SALDO ARREDONDADO"
FROM conta c;

-- 6. Exiba o saldo truncado, sem casas decimais.
-- R:
SELECT TRUNC(c.saldo) AS "SALDO TRUNCADO"
FROM conta c;

-- 7. Mostre o resto da divisão do saldo da conta por 1000.
-- R:
SELECT MOD(c.saldo, 1000) AS "RESTO DA DIVISÃO"
FROM conta c;  

-- 8. Exiba a data atual do servidor do banco.
-- R:
SELECT SYSDATE AS "DATA ATUAL"
FROM DUAL;

-- 9. Adicione 30 dias à data atual e exiba como "Data de vencimento simulada".
-- R:
SELECT SYSDATE + 30 AS "DATA DE VENCIMENTO SIMULADA"
FROM DUAL;

-- 10.Exiba o número de dias entre a data de abertura da conta e a data atual.
-- R: dados insuficientes para realizar a consulta.
-- SELECT SYSDATE - c.data_abertura AS "DIAS DESDE A ABERTURA"
-- FROM conta c;

-- Parte 2 – Conversão de Dados e Tratamento de Nulos (Seção 5)

-- 11.Apresente o saldo de cada conta formatado como moeda local.
-- R:
SELECT TO_CHAR(c.saldo, 'FM$999,999.00') AS "SALDO FORMATADO"
FROM conta c;

-- 12. Converta a data de abertura da conta para o formato 'dd/mm/yyyy'.
-- R:
SELECT TO_CHAR(c.data_abertura, 'DD/MM/YYYY') AS "DATA FORMATADA"
FROM conta c;

-- 13.Exiba o saldo da conta e substitua valores nulos por 0.
-- R:
SELECT NVL(c.saldo, 0) AS "SALDO SUBSTITUÍDO"
From conta c;

-- 14.Exiba os nomes dos clientes e substitua valores nulos na cidade por 'Sem cidade'.
-- R:
SELECT NVL(c.cidade, 'Sem cidade') AS "CIDADE SUBSTITUÍDA"
FROM cliente c;

-- 15. Classifique os clientes em grupos com base em sua cidade:
-- o 'Região Metropolitana' se forem de Niterói
-- o 'Interior' se forem de Resende
-- o 'Outra Região' para as demais cidades
--R:
SELECT c.cliente_nome, c.cidade,
       CASE
           WHEN c.cidade = 'Niterói' THEN 'Região Metropolitana'
           WHEN c.cidade = 'Resende' THEN 'Interior'
           ELSE 'Outra Região'
       END AS "REGIÃO" 
FROM cliente c;

-- Parte 3 – Junções entre Tabelas (Seção 6)

-- 16.Exiba o nome de cada cliente, o número da conta e o saldo correspondente.
-- R:
SELECT c.cliente_nome, c.conta_numero, c.saldo
FROM cliente c
JOIN conta c ON c.cliente_cliente_cod = c.cliente_cod

-- 17. Liste os nomes dos clientes e os nomes das agências onde mantêm conta.
-- R:
SELECT cl.cliente_nome, ag.agencia_nome
FROM cliente cl
JOIN conta co ON cl.cliente_cod = co.cliente_cliente_cod
JOIN agencia ag ON co.agencia_agencia_cod = ag.agencia_cod;

-- 18. Mostre todas as agências, mesmo aquelas que não possuem clientes vinculados (junção
-- externa esquerda).
-- R:
SELECT a.agencia_nome, c.cliente_nome
FROM agencia ag
LEFT JOIN conta co ON ag.agencia_cod = co.agencia_agencia_cod
LEFT JOIN cliente cl ON co.cliente_cliente_cod = cl.cliente_cod;