import 'package:artemis/dominio/core/departamento.dart';
import 'package:artemis/dominio/core/dto/funcionario_dto_saida.dart';
import 'package:artemis/dominio/portas/secundaria/idao_funcionario.dart';

// Segue princípio de Uma responsabilidade(S)
class Funcionario {
  final String nome;
  final DateTime? horaExtra;
  final DateTime dataDeEntrada;
  final Departamento departamento;

  Funcionario(
      {required this.nome,
      this.horaExtra,
      required this.dataDeEntrada,
      required this.departamento});

}
