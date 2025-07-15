-- 1. Grade horária por curso
CREATE OR REPLACE VIEW vw_grade_horaria_por_curso AS
SELECT
    t.DiaSemana,
    c.Nome AS Curso,
    d.Nome AS Disciplina,
    t.AnoLetivo,
    t.Semestre,
    t.HoraInicio,
    t.HoraFim,
    p.NomeCompleto AS Professor
FROM
    Cursos c
    JOIN GradeCurricular gc ON c.ID_Curso = gc.ID_Curso
    JOIN Disciplinas d ON gc.ID_Disciplina = d.ID_Disciplina
    JOIN Turmas t ON t.ID_Disciplina = d.ID_Disciplina
    JOIN Professores p ON t.ID_Professor = p.ID_Professor
ORDER BY
    c.Nome, t.AnoLetivo, t.Semestre, t.DiaSemana, t.HoraInicio;

---Caregar a caraga horaria dos cursos---
select * from vw_grade_horaria_por_curso;
-- 2. Carga horária por professor
CREATE OR REPLACE VIEW vw_carga_horaria_por_professor AS
SELECT
    p.ID_Professor,
    p.NomeCompleto AS Professor,
    COUNT(t.ID_Turma) AS Numero_Turmas,
    SUM(TIMESTAMPDIFF(MINUTE, t.HoraInicio, t.HoraFim))/60 AS Carga_Horaria_Semanal
FROM
    Professores p
    JOIN Turmas t ON p.ID_Professor = t.ID_Professor
GROUP BY
    p.ID_Professor, p.NomeCompleto
ORDER BY
    Carga_Horaria_Semanal DESC;

---Teste para a view  Carga horia 
    SELECT * FROM vw_carga_horaria_por_professor;
-- 3. Resumo de custos de serviços por mês
CREATE OR REPLACE VIEW vw_resumo_custos_servicos_mes AS
SELECT
    DATE_FORMAT(s.MesReferencia, '%Y-%m') AS Mes,
    e.TipoServico,
    SUM(pg.ValorFinalPago) AS TotalGasto
FROM
    Pagamentos pg
    JOIN SLAs s ON pg.ID_SLA = s.ID_SLA
    JOIN Contratos c ON s.ID_Contrato = c.ID_Contrato
    JOIN EmpresasTerceirizadas e ON c.ID_Empresa = e.ID_Empresa
GROUP BY
    Mes, e.TipoServico
ORDER BY
    Mes DESC, e.TipoServico;
---Teste para 
SELECT * FROM vw_resumo_custos_servicos_mes;



