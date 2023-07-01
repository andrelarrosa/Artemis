import 'package:url_launcher/url_launcher.dart';
import 'package:artemis/dominio/dto/agendamentoSaida_dto.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';
import 'package:artemis/dominio/portas/secundaria/ienviar_email.dart';

class EnviarEmailFake implements IEnviarEmail {
  @override
  Future<bool> enviarEmail({SolicitacaoFeriasDTO? solicitacaoFerias, AgendamentoSaidaDTO? agendamentoSaidaDTO}) async {
    return Future.value(true);
  }
}
