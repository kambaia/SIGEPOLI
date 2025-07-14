-- ========= TABELAS DE PESSOAS E DEPARTAMENTOS =========
 CREATE DATABASE Sigepoli;
-- Tabela para os Departamentos do Instituto
-- Requisito: RF01
USER Sigepoli;
CREATE TABLE Departamentos (
    ID_Departamento INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL UNIQUE,
    OrcamentoAnual DECIMAL(15, 2) NOT NULL CHECK (OrcamentoAnual >= 0),
    ID_Chefe INT UNIQUE, -- Um chefe só pode chefiar um departamento
    FOREIGN KEY (ID_Chefe) REFERENCES ColaboradoresAdministrativos(ID_Colaborador) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela para os Colaboradores Administrativos
-- Requisito: RF02
CREATE TABLE ColaboradoresAdministrativos (
    ID_Colaborador INT PRIMARY KEY AUTO_INCREMENT,
    NomeCompleto VARCHAR(255) NOT NULL,
    BI VARCHAR(20) NOT NULL UNIQUE,
    NIF VARCHAR(20) UNIQUE,
    DataNascimento DATE NOT NULL,
    Cargo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamentos(ID_Departamento) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela para os Professores
-- Requisito: RF03
CREATE TABLE Professores (
    ID_Professor INT PRIMARY KEY AUTO_INCREMENT,
    NomeCompleto VARCHAR(255) NOT NULL,
    BI VARCHAR(20) NOT NULL UNIQUE,
    NIF VARCHAR(20) UNIQUE,
    Titulacao VARCHAR(100) NOT NULL, -- Ex: Licenciado, Mestre, Doutor
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela para os Alunos
CREATE TABLE Alunos (
    ID_Aluno INT PRIMARY KEY AUTO_INCREMENT,
    NomeCompleto VARCHAR(255) NOT NULL,
    BI VARCHAR(20) NOT NULL UNIQUE,
    NIF VARCHAR(20) UNIQUE,
    DataNascimento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);
-- ========= TABELAS DA ESTRUTURA ACADÉMICA =========
-- Tabela de Cursos
-- Requisito: RF04, RF05
CREATE TABLE Cursos (
    ID_Curso INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL UNIQUE,
    Descricao TEXT,
    ID_Coordenador INT UNIQUE, -- Um coordenador só pode coordenar um curso
    FOREIGN KEY (ID_Coordenador) REFERENCES Professores(ID_Professor) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela de Disciplinas
-- Requisito: RF05
CREATE TABLE Disciplinas (
    ID_Disciplina INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL UNIQUE,
    ECTS INT NOT NULL CHECK (ECTS > 0)
);

-- Tabela associativa para a Grade Curricular (N:M entre Curso e Disciplina)
CREATE TABLE GradeCurricular (
    ID_Curso INT,
    ID_Disciplina INT,
    AnoCurricular INT NOT NULL, -- 1º Ano, 2º Ano, etc.
    Semestre INT NOT NULL,      -- 1º ou 2º
    PRIMARY KEY (ID_Curso, ID_Disciplina),
    FOREIGN KEY (ID_Curso) REFERENCES Cursos(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Disciplina) REFERENCES Disciplinas(ID_Disciplina) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela de Turmas
-- Requisito: RF05
CREATE TABLE Turmas (
    ID_Turma INT PRIMARY KEY AUTO_INCREMENT,
    AnoLetivo VARCHAR(9) NOT NULL, -- Ex: '2024/2025'
    Semestre INT NOT NULL CHECK (Semestre IN (1, 2)),
    NumeroVagas INT NOT NULL CHECK (NumeroVagas > 0),
    Sala VARCHAR(20),
    DiaSemana VARCHAR(20) NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFim TIME NOT NULL,
    ID_Disciplina INT NOT NULL,
    ID_Professor INT NOT NULL,
    FOREIGN KEY (ID_Disciplina) REFERENCES Disciplinas(ID_Disciplina) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Professor) REFERENCES Professores(ID_Professor) ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE (AnoLetivo, Semestre, ID_Disciplina, ID_Professor, DiaSemana, HoraInicio) -- Garante que um professor não tem sobreposição no mesmo horário
);

-- Tabela de Matrículas (N:M entre Aluno e Turma)
-- Requisito: RF06
CREATE TABLE Matriculas (
    ID_Matricula INT PRIMARY KEY AUTO_INCREMENT,
    DataMatricula DATE NOT NULL,
    PropinaPaga BOOLEAN NOT NULL DEFAULT FALSE, -- RN02: Só pode matricular com propina paga
    ID_Aluno INT NOT NULL,
    ID_Turma INT NOT NULL,
    FOREIGN KEY (ID_Aluno) REFERENCES Alunos(ID_Aluno) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Turma) REFERENCES Turmas(ID_Turma) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (ID_Aluno, ID_Turma) -- Um aluno não pode se matricular duas vezes na mesma turma
);

-- Tabela de Avaliações
-- Requisito: RF07
CREATE TABLE Avaliacoes (
    ID_Avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    TipoAvaliacao VARCHAR(50) NOT NULL, -- Ex: 'Frequência 1', 'Exame Final'
    Nota DECIMAL(4, 2) NOT NULL CHECK (Nota BETWEEN 0 AND 20), -- RN03: Notas entre 0-20
    ID_Matricula INT NOT NULL,
    FOREIGN KEY (ID_Matricula) REFERENCES Matriculas(ID_Matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ========= TABELAS DA ÁREA OPERACIONAL para o projecto =========

-- Tabela de Empresas Terceirizadas
-- Requisito: RF08
CREATE TABLE EmpresasTerceirizadas (
    ID_Empresa INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    NIF VARCHAR(20) NOT NULL UNIQUE,
    TipoServico ENUM('Limpeza', 'Segurança', 'Cafetaria') NOT NULL
);

-- Tabela de Contratos
-- Requisito: RF08
CREATE TABLE Contratos (
    ID_Contrato INT PRIMARY KEY AUTO_INCREMENT,
    DataInicio DATE NOT NULL,
    DataFim DATE NOT NULL,
    ValorMensal DECIMAL(15, 2) NOT NULL,
    GarantiaValida BOOLEAN NOT NULL DEFAULT FALSE, -- RN04: Precisa de garantia válida
    ID_Empresa INT NOT NULL,
    FOREIGN KEY (ID_Empresa) REFERENCES EmpresasTerceirizadas(ID_Empresa) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela para registo mensal do SLA
-- Requisito: RF09
CREATE TABLE SLAs (
    ID_SLA INT PRIMARY KEY AUTO_INCREMENT,
    MesReferencia DATE NOT NULL, -- Primeiro dia do mês de referência
    PercentualAtingido DECIMAL(5, 2) NOT NULL CHECK (PercentualAtingido BETWEEN 0 AND 100),
    ID_Contrato INT NOT NULL,
    FOREIGN KEY (ID_Contrato) REFERENCES Contratos(ID_Contrato) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (MesReferencia, ID_Contrato)
);

-- Tabela de Pagamentos Mensais
-- Requisito: RF09
CREATE TABLE Pagamentos (
    ID_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    DataPagamento DATE NOT NULL,
    ValorBase DECIMAL(15, 2) NOT NULL,
    ValorMulta DECIMAL(15, 2) NOT NULL DEFAULT 0, -- RN05: Multa se SLA < 90%
    ValorFinalPago DECIMAL(15, 2) NOT NULL,
    ID_SLA INT NOT NULL UNIQUE, -- Cada SLA resulta em um único pagamento
    FOREIGN KEY (ID_SLA) REFERENCES SLAs(ID_SLA) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ========= TABELA DE AUDITORIA =========

-- Tabela para registar alterações sensíveis
-- Requisito: RF11
CREATE TABLE Auditoria (
    ID_Auditoria INT PRIMARY KEY AUTO_INCREMENT,
    TabelaAfetada VARCHAR(100) NOT NULL,
    ID_RegistroAfetado INT,
    Acao VARCHAR(10) NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
    DadosAntigos TEXT,
    DadosNovos TEXT,
    Usuario VARCHAR(100),
    DataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



