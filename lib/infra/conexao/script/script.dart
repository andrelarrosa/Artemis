final criarBanco = [
  '''
    CREATE TABLE DEPARTAMENTO (
      id INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL
    )
  ''',
  '''    
    CREATE TABLE FUNCIONARIO (
      id INTEGER NOT NULL PRIMARY KEY,
      nome VARCHAR NOT NULL,
      email VARCHAR NOT NULL,
      hora_extra TIMESTAMP,
      data_de_entrada TIMESTAMP NOT NULL,
      departamento INTEGER NOT NULL,
      FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(id)
    )
  ''',
  '''    
    CREATE TABLE GERENTE (
      id INTEGER NOT NULL PRIMARY KEY,
      data_ultima_bonificacao TIMESTAMP,
      data_de_entrada TIMESTAMP NOT NULL,
      departamento TIMESTAMP NOT NULL,
      FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(id)
    )
  ''',
  '''    
    CREATE TABLE AGENDAMENTO_FERIAS (
      id INTEGER NOT NULL PRIMARY KEY,
      descricao VARCHAR NOT NULL,
      data_solicitacao TIMESTAMP NOT NULL,
      data_saida TIMESTAMP NOT NULL,
      aprovado BOOLEAN NOT NULL,
      funcionario INTEGER NOT NULL,
      FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(id)
    )
  ''',
  '''
    INSERT INTO DEPARTAMENTO (nome) VALUES ('RH')
  ''',
  '''
    INSERT INTO GERENTE (data_ultima_bonificacao, data_de_entrada, departamento) VALUES ('2005-04-15', '2005-04-15', '1')
  ''',
  '''
    INSERT INTO FUNCIONARIO (nome, email, hora_extra, data_de_entrada, departamento) VALUES ('André', 'andre.larrosa@outlook.com', null, '2021-04-15', '1')
  '''
];
