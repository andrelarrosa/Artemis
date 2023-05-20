final criarBanco = [
  '''
    CREATE TABLE DEPARTAMENTO(
      nome VARCHAR(255) NOT NULL,
    );
    
    CREATE TABLE FUNCIONARIO (
      nome VARCHAR(255) NOT NULL,
      hora_extra TIMESTAMP,
      data_de_entrada DATE NOT NULL,
      departamento DEPARTAMENTO NOT NULL,
    );

    CREATE TABLE REGISTRO_PONTO (
      funcionario FUNCIONARIO,
    );
  ''',
  '''

  ''',
];
