import 'package:artemis/dominio/dto/agendamentoSaida_dto.dart';
import 'package:artemis/dominio/dto/email_solicitacao_ferias_dto.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';

abstract class IDAOAgendamentoFerias {
  Future<bool> salvar({AgendamentoSaidaDTO agendamentoSaidaDTO});
}
