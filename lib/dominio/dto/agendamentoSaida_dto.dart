import 'package:artemis/dominio/core/funcionario.dart';

class AgendamentoSaidaDTO {
  final String descricao;
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;
  final bool aprovado;

  AgendamentoSaidaDTO({
    required this.descricao,
    required this.funcionario,
    required this.dataSolicitacao,
    required this.dataSaida,
    required this.aprovado});
}