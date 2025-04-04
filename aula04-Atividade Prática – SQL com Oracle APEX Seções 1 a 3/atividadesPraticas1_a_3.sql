-- Atividade Prática – SQL com Oracle APEX
-- Seções 1 a 3 – Oracle Academy: Database Programming with SQL
-- Tema: Consulta e manipulação de dados em bancos de dados relacionais.
-- Ferramenta: Oracle APEX – SQL Workshop
-- Base de dados utilizada: Sistema bancário com tabelas agencia, cliente, conta, emprestimo.

-- Parte 1 – Recuperando Dados (Seção 1)
-- Objetivo: Utilizar comandos SELECT para exibir dados completos ou parciais de uma tabela.
-- 1. Exiba todos os dados cadastrados na tabela de clientes.
-- R: 
Select * from cliente

-- 2. Exiba apenas os nomes e as cidades dos clientes.
-- R: 
Select c.cliente_nome , c.cidade  
From cliente c

-- 3. Liste todas as contas registradas, exibindo o número da conta e o saldo.
-- R:
SELECT c.conta_numero, c.saldo
From conta c

-- Parte 2 – Filtros, Projeções e Concatenação (Seção 2)
-- Objetivo: Trabalhar com cláusula WHERE, operadores BETWEEN, LIKE, IN, operadores de
-- concatenação (||) e alias.
-- 4. Liste os nomes dos clientes da cidade de Macaé.
-- R:
Select c.cliente_nome
From cliente c
WHERE c.cidade LIKE 'Macaé'

-- 5. Exiba o código e o nome de todos os clientes com código entre 5 e 15.
-- R:
SELECT c.cliente_nome
From cliente c 
WHERE c.cliente_cod BETWEEN 5 and 15

-- 6. Exiba os clientes que moram em Niterói, Volta Redonda ou Itaboraí.
-- R:
SELECT * 
From cliente c
WHERE c.cidade IN ('Niterói', 'Volta Redonda', 'Itaboraí')

-- 7. Exiba os nomes dos clientes que começam com a letra "F".
-- R:
SELECT c.cliente_nome
From cliente c
WHERE c.cliente_nome LIKE 'F%'

-- 8. Exiba uma frase com a seguinte estrutura para todos os clientes:
-- Exemplo: João Santos mora em Nova Iguaçu.
-- Utilize concatenação e alias para nomear a coluna como "Frase".
-- R:
SELECT c.cliente_nome || 'mora em ' || c.cidade ||'.'   AS "Frase"
From cliente c 

-- Parte 3 – Ordenações, Operadores Lógicos e Funções (Seção 3)
-- Objetivo: Utilizar ORDER BY, operadores lógicos (AND, OR, NOT) e funções de linha única (ROUND,
-- UPPER, etc.).
-- 9. Exiba os dados de todas as contas com saldo superior a R$ 9.000, ordenados do maior para o
-- menor saldo.
-- R:
SELECT * 
FROM contas 
WHERE saldo > 9000 
ORDER BY saldo DESC;

-- 10. Liste os clientes que moram em Nova Iguaçu ou que tenham "Silva" no nome.
-- R:
SELECT * 
FROM clientes 
WHERE cidade = 'Nova Iguaçu' OR nome LIKE '%Silva%';

-- 11. Exiba o saldo das contas com arredondamento para o inteiro mais próximo.
-- R:
SELECT ROUND(saldo) AS saldo_arredondado 
FROM contas;

-- 12. Exiba o nome de todos os clientes em letras maiúsculas.
-- R:
SELECT UPPER(nome) AS nome_maiusculo 
FROM clientes;

-- 13. Exiba os nomes dos clientes que não são das cidades de Teresópolis nem Campos dos
-- Goytacazes.
-- R:
SELECT nome 
FROM clientes 
WHERE cidade NOT IN ('Teresópolis', 'Campos dos Goytacazes');