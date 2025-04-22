-- Tabela de Engenheiros
CREATE TABLE Engenheiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    especialidade TEXT,
    telefone TEXT,
    email TEXT
);

-- Tabela de Pedreiros
CREATE TABLE Pedreiros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    experiencia INTEGER,
    telefone TEXT,
    email TEXT
);

-- Tabela de Materiais
CREATE TABLE Materiais (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    tipo TEXT,
    quantidade_disponivel INTEGER,
    custo_unidade REAL
);

-- Tabela de Horas de Trabalho
CREATE TABLE HorasDeTrabalho (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcionario INTEGER NOT NULL,
    data DATE NOT NULL,
    horas_trabalhadas INTEGER NOT NULL,
    projeto_id INTEGER,
    FOREIGN KEY (id_funcionario) REFERENCES Engenheiros(id),
    FOREIGN KEY (projeto_id) REFERENCES Projetos(id)
);

-- Tabela de Impostos
CREATE TABLE Impostos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo TEXT NOT NULL,
    percentual REAL NOT NULL,
    descricao TEXT
);

-- Tabela de Fluxo de Caixa
CREATE TABLE FluxoDeCaixa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data DATE NOT NULL,
    descricao TEXT,
    valor REAL NOT NULL,
    tipo_transacao TEXT NOT NULL, -- Receita ou Despesa
    projeto_id INTEGER,
    FOREIGN KEY (projeto_id) REFERENCES Projetos(id)
);

-- Tabela de Projetos
CREATE TABLE Projetos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    data_inicio DATE,
    data_fim_estimada DATE,
    id_engenheiro_responsavel INTEGER NOT NULL,
    prolabore_5_percent REAL DEFAULT 0,
    FOREIGN KEY (id_engenheiro_responsavel) REFERENCES Engenheiros(id)
);

-- Atualizar Fluxo de Caixa com Prolabore
INSERT INTO FluxoDeCaixa (data, descricao, valor, tipo_transacao) 
VALUES (DATE('now'), 'Prolabore CEO', (SELECT SUM(valor) * 0.05 FROM FluxoDeCaixa WHERE tipo_transacao = 'Receita'), 'Despesa');
