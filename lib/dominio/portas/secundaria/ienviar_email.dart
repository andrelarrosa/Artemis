import 'package:artemis/dominio/dto/agendamentoSaida_dto.dart';
import 'package:artemis/dominio/dto/email_solicitacao_ferias_dto.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';

abstract class IEnviarEmail {
  Future<bool> enviarEmail({SolicitacaoFeriasDTO solicitacaoFerias, AgendamentoSaidaDTO agendamentoSaidaDTO});
}