-- 1. Liste todos os alunos matriculados no curso de "Banco de Dados".
SELECT a.nome, a.email, a.aluno_id
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id
JOIN curso c ON m.curso_id = c.curso_id
where c.titulo = 'Banco de Dados';

-- 2. Liste todos os cursos com carga horária maior que 40 horas.
SELECT a.titulo, a.curso_id
FROM curso a
WHERE a.carga_horaria > 40;

-- 3. Liste os alunos que ainda não receberam nota.
SELECT a.aluno_id, a.nome, a.email
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id
WHERE m.nota is null;

-- 4. Liste as matrículas realizadas depois do dia 01/01/2024.
SELECT *
FROM matricula m
WHERE m.data_matricula > '01-01-2024';

-- 5. Mostre os cursos com carga horária entre 30 e 60 horas.
SELECT a.titulo, a.curso_id
FROM curso a
WHERE a.carga_horaria BETWEEN 30 and 60

-- 6. Liste os alunos com e-mails do domínio @gmail.com
SELECT a.email
FROM aluno a
WHERE a.email like '%@gmail.com%'

-- 7.Liste o nome do aluno, título do curso e data da matrícula.
