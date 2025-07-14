
--- RN02 — Procedure: Matricular Aluno (só se Propina paga)
DELIMITER //

CREATE PROCEDURE MatricularAlunoComValidacao (
    IN p_DataMatricula DATE,
    IN p_ID_Aluno INT,
    IN p_ID_Turma INT
)
BEGIN
    DECLARE v_vagas INT;
    DECLARE v_ocupadas INT;
    DECLARE v_restantes INT;
    DECLARE v_jaMatriculado INT;

    -- Verifica se já está matriculado
    SELECT COUNT(*) INTO v_jaMatriculado
    FROM Matriculas
    WHERE ID_Aluno = p_ID_Aluno AND ID_Turma = p_ID_Turma;

    IF v_jaMatriculado > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Este aluno já está matriculado nesta turma.';
    ELSE
        -- Verifica vagas
        SELECT NumeroVagas INTO v_vagas
        FROM Turmas
        WHERE ID_Turma = p_ID_Turma;

        SELECT COUNT(*) INTO v_ocupadas
        FROM Matriculas
        WHERE ID_Turma = p_ID_Turma;

        SET v_restantes = v_vagas - v_ocupadas;

        IF v_restantes <= 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: Não há vagas disponíveis nesta turma.';
        ELSE
            INSERT INTO Matriculas (DataMatricula, PropinaPaga, ID_Aluno, ID_Turma)
            VALUES (p_DataMatricula, TRUE, p_ID_Aluno, p_ID_Turma);
        END IF;
    END IF;
END //

DELIMITER ;

CALL MatricularAlunoComValidacao('2025-07-14', 1, 1);
CALL MatricularAlunoComValidacao('2025-07-14', 5, 1);
 ---2. RN01 — Procedure: Alocar Professor a Turma
DELIMITER //
CREATE PROCEDURE AlocarProfessorATurma(
    IN p_ID_Professor INT,
    IN p_ID_Turma INT
)
BEGIN
    -- Verificar se o professor já está alocado àquela turma
    DECLARE v_ID_Atual INT;
    SELECT ID_Professor INTO v_ID_Atual FROM Turmas WHERE ID_Turma = p_ID_Turma;

    IF v_ID_Atual = p_ID_Professor THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este professor já está alocado à turma.';
    ELSE
        UPDATE Turmas
        SET ID_Professor = p_ID_Professor
        WHERE ID_Turma = p_ID_Turma;
    END IF;
END;
//

DELIMITER ;

CALL AlocarProfessorATurma(2, 3); -- exemplo: alocar professor 2 na turma 3

---3. RN05 — Procedure: Processar Pagamento com Cálculo de Multa (SLA < 90%)
DELIMITER //
CREATE PROCEDURE ProcessarPagamento(
    IN p_ID_SLA INT,
    IN p_DataPagamento DATE,
    IN p_ValorBase DECIMAL(15,2)
)
BEGIN
    DECLARE v_Percentual DECIMAL(5,2);
    DECLARE v_Multa DECIMAL(15,2);
    DECLARE v_ValorFinal DECIMAL(15,2);

    -- Obter percentual atingido
    SELECT PercentualAtingido INTO v_Percentual FROM SLAs WHERE ID_SLA = p_ID_SLA;

    -- Calcular multa
    IF v_Percentual < 90 THEN
        SET v_Multa = p_ValorBase * 0.10;
    ELSE
        SET v_Multa = 0;
    END IF;

    -- Calcular valor final
    SET v_ValorFinal = p_ValorBase + v_Multa;

    -- Inserir pagamento
    INSERT INTO Pagamentos (
        DataPagamento, ValorBase, ValorMulta, ValorFinalPago, ID_SLA
    ) VALUES (
        p_DataPagamento, p_ValorBase, v_Multa, v_ValorFinal, p_ID_SLA
    );
END;
//

DELIMITER ;

SELECT * FROM Pagamentos;
CALL ProcessarPagamento(5, '2025-07-19', 1000.00);



---Validar a nota 

DELIMITER //

CREATE PROCEDURE InserirAvaliacaoComValidacao (
    IN p_TipoAvaliacao VARCHAR(50),
    IN p_Nota DECIMAL(4,2),
    IN p_ID_Matricula INT
)
BEGIN
    IF p_Nota < 0 OR p_Nota > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nota inválida! Deve estar entre 0 e 20.';
    ELSE
        INSERT INTO Avaliacoes (TipoAvaliacao, Nota, ID_Matricula)
        VALUES (p_TipoAvaliacao, p_Nota, p_ID_Matricula);
    END IF;
END //

DELIMITER ;


CALL InserirAvaliacaoComValidacao('pp1', 22.5, 1);

