import 'package:artemis/dominio/dto/departamento_dto.dart';

class FuncionarioDTO {
  final String nome;
  final DateTime? horaExtra;
  final DateTime dataDeEntrada;
  final DepartamentoDTO departamento;

  FuncionarioDTO(
      {required this.nome,
      this.horaExtra,
      required this.dataDeEntrada,
      required this.departamento});
}
