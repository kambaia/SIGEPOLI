--CalcularMediaPonderadaAluno

DELIMITER //
CREATE FUNCTION CalcularMediaPonderadaAluno (
    p_ID_Aluno INT,
    p_ID_Turma INT
)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE v_PP1 DECIMAL(4,2) DEFAULT 0;
    DECLARE v_PP2 DECIMAL(4,2) DEFAULT 0;
    DECLARE v_Media DECIMAL(4,2);
    DECLARE v_ID_Matricula INT;

    -- Buscar matrícula do aluno
    SELECT ID_Matricula INTO v_ID_Matricula
    FROM Matriculas
    WHERE ID_Aluno = p_ID_Aluno AND ID_Turma = p_ID_Turma
    LIMIT 1;

    -- Buscar nota da PP1
    SELECT Nota INTO v_PP1
    FROM Avaliacoes
    WHERE ID_Matricula = v_ID_Matricula AND TipoAvaliacao = 'PP1'
    LIMIT 1;

    -- Buscar nota da PP2
    SELECT Nota INTO v_PP2
    FROM Avaliacoes
    WHERE ID_Matricula = v_ID_Matricula AND TipoAvaliacao = 'PP2'
    LIMIT 1;

    -- Calcular média ponderada
    SET v_Media = (v_PP1 * 0.4) + (v_PP2 * 0.6);

    RETURN v_Media;
END;
//
DELIMITER ;

SELECT CalcularMediaPonderadaAluno(1, 1) AS MediaFinal;

---CalcularPercentualSLAMensal

DELIMITER //

CREATE FUNCTION CalcularPercentualSLAMensal (
    p_MesReferencia DATE
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_MediaSLA DECIMAL(5,2);

    SELECT AVG(PercentualAtingido) INTO v_MediaSLA
    FROM SLAs
    WHERE MesReferencia = p_MesReferencia;

    RETURN v_MediaSLA;
END;
//

DELIMITER ;


SELECT CalcularPercentualSLAMensal('2025-06-01') AS MediaPercentualSLA;


