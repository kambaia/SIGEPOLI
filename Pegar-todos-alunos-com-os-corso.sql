----Logica para pegar os dados---(Alunos → Matriculas → Turmas → Disciplinas → GradeCurricular → Cursos)
CREATE OR REPLACE VIEW view_alunos_cursos AS
SELECT DISTINCT
    a.ID_Aluno,
    a.NomeCompleto AS Nome_Aluno,
    c.ID_Curso,
    c.Nome AS Nome_Curso
FROM 
    Alunos a
JOIN 
    Matriculas m ON a.ID_Aluno = m.ID_Aluno
JOIN 
    Turmas t ON m.ID_Turma = t.ID_Turma
JOIN 
    Disciplinas d ON t.ID_Disciplina = d.ID_Disciplina
JOIN 
    GradeCurricular gc ON d.ID_Disciplina = gc.ID_Disciplina
JOIN 
    Cursos c ON gc.ID_Curso = c.ID_Curso;
SELECT * from view_alunos_cursos;




