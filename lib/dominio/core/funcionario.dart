import 'package:artemis/dominio/core/departamento.dart';

// Segue princípio de Uma responsabilidade(S)
class Funcionario {
  final String nome;
  final DateTime? horaExtra;
  final DateTime dataDeEntrada;
  final String email;
  final Departamento departamento;

  Funcionario(
      {required this.nome,
      this.horaExtra,
      required this.dataDeEntrada,
      required this.departamento,
      required this.email
      });

}
