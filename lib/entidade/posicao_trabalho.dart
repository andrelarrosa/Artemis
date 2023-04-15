import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/funcionario.dart';

// Responsabilidade Única
class PosicaoTrabalho {
  final String nome;
  final List<Funcionario> funcionarios;
  final Departamento departamento;

  PosicaoTrabalho({required this.nome, required this.funcionarios, required this.departamento});
}