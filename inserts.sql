use Sigepoli;
INSERT INTO departamentos (nome, OrcamentoAnual) VALUES ('Recursos Humanos', 150000.00);
INSERT INTO departamentos (nome, OrcamentoAnual) VALUES ('Financeiro', 250000.00);
INSERT INTO Departamentos (nome, OrcamentoAnual) VALUES('Secretaria', 80000.00),
('Coordenação Pedagógica', 120000.00);

-- Colaboradores administrativos

-- Inserção dos colaboradores administrativos (5 exemplos)
INSERT INTO ColaboradoresAdministrativos
(NomeCompleto, BI, NIF, DataNascimento, Cargo, Email, ID_Departamento) VALUES
('Paula Ribeiro', '123456789', '987654321', '1980-05-15', 'Secretária', 'paula.ribeiro@escola.com', 1),
('Marcelo Santos', '223344556', '998877665', '1975-09-20', 'Coordenador Pedagógico', 'marcelo.santos@escola.com', 2)



INSERT INTO ColaboradoresAdministrativos
(NomeCompleto, BI, NIF, DataNascimento, Cargo, Email, ID_Departamento) VALUES
-- Recursos Humanos (ID_Departamento = 1)
('Joana Mendes', '987654321LA034', '1234567890', '1982-03-10', 'Gestora de RH', 'joana.mendes@escola.com', 1),
('Carlos Almeida', '876543210LB067', '1098765432', '1985-06-25', 'Assistente de RH', 'carlos.almeida@escola.com', 1),
('Sofia Ramos', '765432109LC098', '1122334455', '1990-12-12', 'Tesoureira', 'sofia.ramos@escola.com', 2),
('Tiago Ferreira', '654321098LD023', '5566778899', '1987-08-19', 'Contabilista', 'tiago.ferreira@escola.com', 2),
('Beatriz Costa', '543210987LE011', '6677889900', '1993-04-02', 'Recepcionista', 'beatriz.costa@escola.com', 3),
('Henrique Pires', '432109876LF056', '9988776655', '1989-09-30', 'Digitador', 'henrique.pires@escola.com', 3),
('Luciana Silva', '321098765LG045', '3344556677', '1978-01-17', 'Assessora Pedagógica', 'luciana.silva@escola.com', 4),
('Rui Gomes', '210987654LH078', '7788990011', '1983-11-05', 'Analista Acadêmico', 'rui.gomes@escola.com', 4);


-- Atualizar chefe do departamento (exemplo)
UPDATE Departamentos 
SET ChefeDepartamento = (SELECT ID_Colaborador FROM ColaboradoresAdministrativos WHERE NomeCompleto = 'Marcelo Santos')
WHERE nome = 'Coordenação Pedagógica';


--adicionar 10 professores--
INSERT INTO Professores
(NomeCompleto, BI, NIF, Titulacao, Email) VALUES
('Ana Carvalho', 'AB1234567', '500100200', 'Mestre', 'ana.carvalho@escola.com'),
('Bruno Silva', 'CD2345678', '500100201', 'Doutor', 'bruno.silva@escola.com'),
('Carla Mendes', 'EF3456789', '500100202', 'Licenciado', 'carla.mendes@escola.com'),
('Daniel Costa', 'GH4567890', '500100203', 'Mestre', 'daniel.costa@escola.com'),
('Eduarda Rocha', 'IJ5678901', '500100204', 'Doutor', 'eduarda.rocha@escola.com'),
('Fábio Nascimento', 'KL6789012', '500100205', 'Licenciado', 'fabio.nascimento@escola.com'),
('Gabriela Lopes', 'MN7890123', '500100206', 'Mestre', 'gabriela.lopes@escola.com'),
('Henrique Sousa', 'OP8901234', '500100207', 'Doutor', 'henrique.sousa@escola.com'),
('Isabel Duarte', 'QR9012345', '500100208', 'Licenciado', 'isabel.duarte@escola.com'),
('João Pires', 'ST0123456', '500100209', 'Mestre', 'joao.pires@escola.com');

--adicionar 10 alunos

INSERT INTO Alunos
(NomeCompleto, BI, NIF, DataNascimento, Email) VALUES
('Carlos Andrade', 'BI1001001', '800100200', '2003-02-15', 'carlos.andrade@aluno.com'),
('Mariana Lopes', 'BI1001002', '800100201', '2002-08-22', 'mariana.lopes@aluno.com'),
('Tiago Ramos', 'BI1001003', '800100202', '2001-11-10', 'tiago.ramos@aluno.com'),
('Jéssica Silva', 'BI1001004', '800100203', '2004-06-05', 'jessica.silva@aluno.com'),
('Bruno Castro', 'BI1001005', '800100204', '2003-01-18', 'bruno.castro@aluno.com'),
('Larissa Gomes', 'BI1001006', '800100205', '2002-09-30', 'larissa.gomes@aluno.com'),
('Ricardo Dias', 'BI1001007', '800100206', '2001-03-27', 'ricardo.dias@aluno.com'),
('Tatiane Morais', 'BI1001008', '800100207', '2003-05-14', 'tatiane.morais@aluno.com'),
('Fábio Teixeira', 'BI1001009', '800100208', '2002-10-03', 'fabio.teixeira@aluno.com'),
('Beatriz Fernandes', 'BI1001010', '800100209', '2004-12-21', 'beatriz.fernandes@aluno.com');

--adicionar 10 Cursos

INSERT INTO Cursos (Nome, Descricao, ID_Coordenador) VALUES
('Engenharia Informática', 'Curso focado em desenvolvimento de software, redes e sistemas computacionais.', 1),
('Gestão de Empresas', 'Curso voltado para formação em administração, finanças e recursos humanos.', 2),
('Contabilidade e Auditoria', 'Curso que prepara profissionais para análise financeira e controle contábil.', 3),
('Educação Básica', 'Formação de professores para o ensino fundamental e médio.', 4),
('Engenharia Civil', 'Curso técnico e prático sobre construção, estruturas e projetos civis.', 5);

--adicionar 10 Disciplinas
INSERT INTO Disciplinas (Nome, ECTS) VALUES
('Matemática Discreta', 6),
('Programação I', 6),
('Arquitetura de Computadores', 5),
('Contabilidade Financeira', 5),
('Introdução à Gestão', 4),
('Bases de Dados', 6),
('Engenharia de Software', 6),
('Análise Financeira', 5),
('Psicologia da Educação', 4),
('Materiais de Construção', 5);


-- Engenharia Informática (ID_Curso = 1)
INSERT INTO GradeCurricular (ID_Curso, ID_Disciplina, AnoCurricular, Semestre) VALUES
(1, 1, 1, 1), -- Matemática Discreta
(1, 2, 1, 1), -- Programação I
(1, 3, 1, 2), -- Arquitetura de Computadores
(1, 6, 2, 1), -- Bases de Dados
(1, 7, 2, 2); -- Engenharia de Software

-- Gestão de Empresas (ID_Curso = 2)
INSERT INTO GradeCurricular (ID_Curso, ID_Disciplina, AnoCurricular, Semestre) VALUES
(2, 4, 1, 1), -- Contabilidade Financeira
(2, 5, 1, 1), -- Introdução à Gestão
(2, 8, 2, 1); -- Análise Financeira

-- Contabilidade e Auditoria (ID_Curso = 3)
INSERT INTO GradeCurricular (ID_Curso, ID_Disciplina, AnoCurricular, Semestre) VALUES
(3, 4, 1, 1),
(3, 8, 1, 2),
(3, 6, 2, 1); -- Bases de Dados (para relatórios e sistemas de gestão)

-- Educação Básica (ID_Curso = 4)
INSERT INTO GradeCurricular (ID_Curso, ID_Disciplina, AnoCurricular, Semestre) VALUES
(4, 5, 1, 1),
(4, 9, 1, 2); -- Psicologia da Educação

-- Engenharia Civil (ID_Curso = 5)
INSERT INTO GradeCurricular (ID_Curso, ID_Disciplina, AnoCurricular, Semestre) VALUES
(5, 1, 1, 1),
(5, 10, 1, 2); -- Materiais de Construção



INSERT INTO Turmas (AnoLetivo, Semestre, NumeroVagas, Sala, DiaSemana, HoraInicio, HoraFim, ID_Disciplina, ID_Professor) VALUES
('2024/2025', 1, 30, 'Sala 101', 'Segunda-feira', '08:00:00', '10:00:00', 1, 1), -- Matemática Discreta - Prof 1
('2024/2025', 1, 25, 'Sala 102', 'Terça-feira', '10:00:00', '12:00:00', 2, 2),    -- Programação I - Prof 2
('2024/2025', 1, 20, 'Sala 103', 'Quarta-feira', '14:00:00', '16:00:00', 3, 3),   -- Arquitetura - Prof 3
('2024/2025', 1, 40, 'Sala 104', 'Quinta-feira', '09:00:00', '11:00:00', 4, 4),   -- Contabilidade - Prof 4
('2024/2025', 1, 35, 'Sala 105', 'Sexta-feira', '11:00:00', '13:00:00', 5, 5);    -- Gestão - Prof 5 

INSERT INTO Matriculas (DataMatricula, PropinaPaga, ID_Aluno, ID_Turma) VALUES
('2025-07-01', TRUE, 1, 1),
('2025-07-02', TRUE, 1, 2),
('2025-07-03', True, 1, 3),  -- propina não paga
('2025-07-04', TRUE, 1, 4),
('2025-07-05', TRUE, 1, 5),

('2025-07-01', TRUE, 2, 1),
('2025-07-02', True, 2, 2),  -- propina não paga
('2025-07-03', TRUE, 2, 3),
('2025-07-04', TRUE, 2, 4),
('2025-07-05', TRUE, 2, 5);


INSERT INTO Avaliacoes (TipoAvaliacao, Nota, ID_Matricula) VALUES
('PP1', 15.5, 1),
('PP2', 16.0, 1),
('Exame Final', 18.0, 1),
('PP1', 12.0, 2),
('PP2', 14.0, 2),
('Exame Final', 17.5, 2),
('PP1', 13.5, 3),
('PP2', 15.0, 3),
('Exame Final', 16.0, 3);


INSERT INTO Avaliacoes (TipoAvaliacao, Nota, ID_Matricula) VALUES
('PP2', 21.0, 1);


INSERT INTO EmpresasTerceirizadas (Nome, NIF, TipoServico) VALUES
('Limpezas Angola', '123456789', 'Limpeza'),
('Segurança Total', '987654321', 'Segurança'),
('Cafés e Cia', '456789123', 'Cafetaria');


INSERT INTO Contratos (DataInicio, DataFim, ValorMensal, GarantiaValida, ID_Empresa) VALUES
('2024-01-01', '2024-12-31', 5000.00, TRUE, 1),
('2024-03-15', '2025-03-14', 7000.00, FALSE, 2),
('2024-05-01', '2025-04-30', 3000.00, TRUE, 3),
('2024-06-10', '2025-06-09', 4500.00, TRUE, 1),
('2024-07-01', '2025-06-30', 6000.00, FALSE, 2);

SELECT * from contratos;

INSERT INTO SLAs (MesReferencia, PercentualAtingido, ID_Contrato) VALUES
('2025-01-01', 95.00, 1),
('2025-01-01', 88.50, 2),
('2025-01-01', 92.75, 3),
('2025-01-01', 85.00, 4),
('2025-01-01', 97.00, 5);


INSERT INTO Pagamentos (DataPagamento, ValorBase, ValorMulta, ValorFinalPago, ID_SLA) VALUES
('2025-01-05', 5500000.00, 0.00, 5500000.00, 1), -- SLA 95% (sem multa)
('2025-01-05', 775000.00, 5000.00, 7700.00, 2), -- SLA 88.5% (com multa)
('2025-01-05', 300000.00, 0.00, 300000.00, 3), -- SLA 92.75% (sem multa)
('2025-01-05', 4500000.00, 4050.00, 45004050.00, 4), -- SLA 85% (com multa)
('2025-01-05', 6000000.00, 0.00, 6000000.00, 5); -- SLA 97% (sem multa)

SELECT * from Pagamentos;

INSERT INTO Auditoria (TabelaAfetada, ID_RegistroAfetado, Acao, DadosAntigos, DadosNovos, Usuario) VALUES
('Contratos', 1, 'INSERT', NULL, '{"DataInicio":"2024-01-01","DataFim":"2024-12-31","ValorMensal":5000.00}', 'admin'),
('SLAs', 2, 'UPDATE', '{"PercentualAtingido":85}', '{"PercentualAtingido":88.5}', 'user1'),
('Pagamentos', 3, 'INSERT', NULL, '{"ValorBase":3000.00,"ValorFinalPago":3000.00}', 'admin'),
('Contratos', 4, 'DELETE', '{"ID_Contrato":4,"ValorMensal":4500.00}', NULL, 'user2'),
('Auditoria', 5, 'INSERT', NULL, '{"Acao":"INSERT","Tabela":"SLAs"}', 'system');







INSERT INTO Turmas (AnoLetivo, Semestre, NumeroVagas, Sala, DiaSemana, HoraInicio, HoraFim, ID_Disciplina, ID_Professor)
VALUES 
('2024/2025', 1, 30, 'A1', 'Segunda-feira', '08:00:00', '10:00:00', 1, 1),
('2024/2025', 1, 25, 'B4', 'Terça-feira', '10:15:00', '12:15:00', 2, 2),
('2024/2025', 1, 40, 'C2', 'Quarta-feira', '13:00:00', '15:00:00', 3, 3),
('2024/2025', 1, 20, 'D6', 'Quinta-feira', '15:15:00', '17:15:00', 4, 4),
('2024/2025', 2, 35, 'A3', 'Sexta-feira', '08:00:00', '10:00:00', 5, 5),
('2024/2025', 2, 28, 'B1', 'Segunda-feira', '10:15:00', '12:15:00', 6, 6),
('2024/2025', 2, 32, 'C5', 'Terça-feira', '13:00:00', '15:00:00', 7, 7),
('2024/2025', 2, 26, 'D2', 'Quarta-feira', '15:15:00', '17:15:00', 8, 8),
('2024/2025', 1, 30, 'A4', 'Quinta-feira', '08:00:00', '10:00:00', 9, 9),
('2024/2025', 2, 30, 'C1', 'Sexta-feira', '10:15:00', '12:15:00', 10, 10);


select * from turmas;




