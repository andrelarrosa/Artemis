import 'package:artemis/dominio/core/departamento.dart';
import 'package:artemis/dominio/core/funcionario.dart';

// Responsabilidade Única
class PosicaoTrabalho {
  final String nome;
  final List<Funcionario> funcionarios;
  final Departamento departamento;

  PosicaoTrabalho({required this.nome, required this.funcionarios, required this.departamento});
}