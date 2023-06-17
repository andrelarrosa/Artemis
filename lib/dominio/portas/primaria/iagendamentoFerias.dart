import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';

abstract class IAgendamentoFerias {
  bool solicitouComQuinzeDias(SolicitacaoFeriasDTO solicitacaoFerias);
  bool aprovarSolicitacao(SolicitacaoFeriasDTO solicitacaoFerias);
  bool funcionarioPodeSolicitarFerias(DateTime dataEntradaFuncionario);
  DateTime agendarFerias(SolicitacaoFeriasDTO solicitacaoFerias);
}
