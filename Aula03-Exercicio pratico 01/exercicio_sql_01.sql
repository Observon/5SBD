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

-- 8. Liste os alunos e as notas que receberam em cada curso.
SELECT a.nome, a.nota, c.titulo
FROM matricula m
JOIN aluno a ON m.aluno_id = a.aluno_id
JOIN curso c ON m.curso_id = c.curso_id
WHERE m.nota is not null; 

--9. Mostre os cursos que o aluno chamado "João Silva" está matriculado.
SELECT c.titulo, c.curso_id
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id
JOIN curso c ON m.curso_id = c.curso_id
WHERE a.nome = 'João Silva';

--10. Liste os títulos dos cursos que possuem mais de um aluno matriculado.
SELECT c.titulo, c.curso_id
FROM curso c
JOIN matricula m ON c.curso_id = m.curso_id
GROUP BY c.titulo, c.curso_id
HAVING COUNT(m.aluno_id) > 1;

--11.Mostre todos os alunos sem matrícula em nenhum curso
SELECT a.nome
FROM aluno a
LEFT JOIN matricula m ON a.aluno_id = m.aluno_id
WHERE m.curso_id IS NULL;

--12. Mostre os cursos sem nenhum aluno matriculado.
SELECT c.titulo
FROM curso c
LEFT JOIN matricula m ON c.curso_id = m.curso_id
WHERE m.aluno_id IS NULL;

--13. Liste os nomes dos alunos e a quantidade de cursos em que estão matriculados.
SELECT a.nome, COUNT(m.curso_id) as quantidade_cursos
FROM aluno a   
JOIN matricula m ON a.aluno_id = m.aluno_id
GROUP BY a.nome
HAVING COUNT(m.curso_id) > 0;

--14. Calcule a nota média de todos os alunos.
SELECT AVG(m.nota) as media_nota
FROM matricula m
WHERE m.nota is not null;

--15. Calcule a média da nota por curso.
SELECT c.titulo, AVG(m.nota) as media_nota
FROM curso c
JOIN matricula m ON c.curso_id = m.curso_id
WHERE m.nota is not null
GROUP BY c.titulo, c.curso_id
HAVING AVG(m.nota) > 0; 

--16. Encontre a maior nota registrada.
SELECT MAX(m.nota) as maior_nota
FROM matricula m
WHERE m.nota is not null;  

-- 17. Mostre o aluno com a menor nota.
SELECT a.nome, m.nota
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id
WHERE m.nota = (SELECT MIN(nota) FROM matricula WHERE nota IS NOT NULL);

--18. Mostre a quantidade total de matrículas por curso.
SELECT c.titulo, COUNT(m.aluno_id) AS total_matriculas
FROM curso c
LEFT JOIN matricula m ON c.curso_id = m.curso_id
GROUP BY c.titulo;

--19. Liste os alunos com média de nota maior ou igual a 8.0.
SELECT a.nome, AVG(m.nota) as media_nota
FROM aluno a   
JOIN matricula m ON a.aluno_id = m.aluno_id
WHERE m.nota is not null
GROUP BY a.nome
HAVING AVG(m.nota) >= 8.0;

--20. Mostre a média, menor e maior nota por curso
SELECT c.titulo, AVG(m.nota) as media_nota, MIN(m.nota) as menor_nota, MAX(m.nota) as maior_nota
FROM curso c
JOIN matricula m ON c.curso_id = m.curso_id
WHERE m.nota is not null
GROUP BY c.titulo, c.curso_id
HAVING AVG(m.nota) > 0;