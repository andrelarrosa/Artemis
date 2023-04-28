import 'package:artemis/entidade/departamento.dart';

// Segue princípio de Uma responsabilidade(S)
class Funcionario {
  final DateTime dataDeEntrada;
  final Departamento departamento;

  Funcionario({required this.dataDeEntrada, required this.departamento});
}
