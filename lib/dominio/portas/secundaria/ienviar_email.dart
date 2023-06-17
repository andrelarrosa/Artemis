import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';

abstract class IEnviarEmail {
  bool EnviarEmail(SolicitacaoFeriasDTO solicitacaoFerias);
}