
---Regra para bloquear inserção a Matricula sem propina pagar 
DELIMITER //

CREATE TRIGGER trg_check_propina_paga
BEFORE INSERT ON Matriculas
FOR EACH ROW
BEGIN
    IF NEW.PropinaPaga = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido matricular sem propina paga.';
    END IF;
END;
//
DELIMITER ;

----Regra para bloquear inserção
DELIMITER $$

CREATE TRIGGER trg_BloqueioPagamentoSemGarantia
BEFORE INSERT ON Pagamentos
FOR EACH ROW
BEGIN
    DECLARE garantia BOOLEAN;

    -- Buscar se o contrato associado ao SLA tem garantia válida
    SELECT c.GarantiaValida INTO garantia
    FROM SLAs s
    JOIN Contratos c ON s.ID_Contrato = c.ID_Contrato
    WHERE s.ID_SLA = NEW.ID_SLA;

    IF garantia = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento bloqueado: garantia do contrato nao valida.';
    END IF;
END$$

DELIMITER ;

---Regra para UPDATE----

DELIMITER $$

CREATE TRIGGER trg_BloqueioPagamentoSemGarantia_Update
BEFORE UPDATE ON Pagamentos
FOR EACH ROW
BEGIN
    DECLARE garantia BOOLEAN;

    SELECT c.GarantiaValida INTO garantia
    FROM SLAs s
    JOIN Contratos c ON s.ID_Contrato = c.ID_Contrato
    WHERE s.ID_SLA = NEW.ID_SLA;

    IF garantia = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Atualizacao de pagamento bloqueada: garantia do contrato nao valida.';
    END IF;
END$$

DELIMITER ;
SELECT * FROM Contratos WHERE GarantiaValida = FALSE LIMIT 1;

-- 2. Pegue um SLA desse contrato
SELECT * FROM SLAs WHERE ID_Contrato = 3 LIMIT 1;
INSERT INTO Pagamentos
(DataPagamento, ValorBase, ValorMulta, ValorFinalPago, ID_SLA)
VALUES
('2025-07-15', 1000.00, 0.00, 1000.00, 5);