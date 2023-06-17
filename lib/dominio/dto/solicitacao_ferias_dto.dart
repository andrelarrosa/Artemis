import 'package:artemis/dominio/core/funcionario.dart';
import 'package:artemis/dominio/core/gerente.dart';
import 'package:artemis/dominio/dto/departamento_dto.dart';

class SolicitacaoFeriasDTO {
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;
  final Gerente gerente;
  
  SolicitacaoFeriasDTO({required this.funcionario, required this.dataSolicitacao, required this.dataSaida, required this.gerente});
}
