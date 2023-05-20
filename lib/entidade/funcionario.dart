import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/dto/funcionario_dto_saida.dart';

import 'interfaces/dao/idao_funcionario.dart';

// Segue princípio de Uma responsabilidade(S)
class Funcionario {
  final String nome;
  final DateTime? horaExtra;
  final DateTime dataDeEntrada;
  final Departamento departamento;

  Funcionario({required this.nome, this.horaExtra, required this.dataDeEntrada, required this.departamento});

  void salvarFuncionario(IDAOFuncionario dao){
    // validação
    FuncionarioDTOSaida funcionarioDTOSaida;
    // dao.salvarFuncionario(funcionarioDtoSaida);
  }
}
