import 'package:artemis/dominio/core/funcionario.dart';
import 'package:artemis/dominio/core/gerente.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';
import 'package:artemis/dominio/portas/primaria/iagendamentoFerias.dart';

import '../dto/email_solicitacao_ferias_dto.dart';
import '../portas/secundaria/idao_agendamentoFerias.dart';
import '../portas/secundaria/ienviar_email.dart';

// SRP (Single Responsibility Principle)
class AgendamentoFerias {
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;

  AgendamentoFerias(
      {required this.funcionario,
      required this.dataSolicitacao,
      required this.dataSaida});

  bool solicitouComQuinzeDias(SolicitacaoFeriasDTO solicitacaoFerias) {
    var diferencaDias = dataSaida.difference(dataSolicitacao);
    if (funcionarioPodeSolicitarFerias(
            solicitacaoFerias.funcionario.dataDeEntrada) &&
        diferencaDias.inDays >= 15) {
      return true;
    }
    return false;
  }

  bool aprovarSolicitacao(SolicitacaoFeriasDTO solicitacaoFerias) {
    if (solicitacaoFerias.gerente.departamento.nome ==
            this.funcionario.departamento.nome &&
        solicitouComQuinzeDias(solicitacaoFerias)) {
      return true;
    }
    return false;
  }

  bool funcionarioPodeSolicitarFerias(DateTime dataEntradaFuncionario) {
    var diferencaDias = DateTime.now().difference(dataEntradaFuncionario);
    if (diferencaDias.inDays >= 365) {
      return true;
    }
    return false;
  }

  DateTime agendarFerias(SolicitacaoFeriasDTO solicitacaoFerias) {
    if (!aprovarSolicitacao(solicitacaoFerias)) {
      throw Exception(
          "Não foi possível agendar suas férias, por favor, verifique com o seu gerente");
    }
    return this.dataSaida;
  }

  Future<bool> EnviarEmail(SolicitacaoFeriasDTO solicitacaoFerias, 
  EmailSolicitacaoFeriasDTO emailSolicitacao, 
  {required IDAOAgendamentoFerias dao, required IEnviarEmail email}) async {
    bool envio, salvar;
    envio = await email.enviarEmail(email: emailSolicitacao, solicitacaoFerias: solicitacaoFerias);
    salvar = await dao.salvar(
            solicitacaoFerias: SolicitacaoFeriasDTO(
            funcionario: solicitacaoFerias.funcionario,
            dataSolicitacao: solicitacaoFerias.dataSolicitacao,
            dataSaida: solicitacaoFerias.dataSaida,
            gerente: solicitacaoFerias.gerente));
    return (envio && salvar);
  }
}
