import 'package:artemis/dominio/core/funcionario.dart';

class AgendamentoFeriasEntradaDTO {
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;

  AgendamentoFeriasEntradaDTO({
      required this.funcionario,
      required this.dataSolicitacao,
      required this.dataSaida});
}