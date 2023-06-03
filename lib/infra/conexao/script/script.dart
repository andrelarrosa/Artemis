final criarBanco = [
  '''
    CREATE TABLE DEPARTAMENTO (
      id INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL
    )
  ''',
  '''    
    CREATE TABLE FUNCIONARIO (
      nome TEXT NOT NULL,
      hora_extra TIMESTAMP,
      data_de_entrada TIMESTAMP NOT NULL,
      departamento INTEGER NOT NULL,
      FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(id)
    )
  ''',
  '''
    INSERT INTO DEPARTAMENTO (nome) VALUES ('departamento')
  '''
];
