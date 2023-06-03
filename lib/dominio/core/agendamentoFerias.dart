import 'package:artemis/dominio/core/funcionario.dart';
import 'package:artemis/dominio/core/gerente.dart';

// SRP (Single Responsibility Principle)
class AgendamentoFerias {
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;

  AgendamentoFerias(
      {required this.funcionario,
      required this.dataSolicitacao,
      required this.dataSaida});

  bool solicitouComQuinzeDias() {
    var diferencaDias = dataSaida.difference(dataSolicitacao);
    if (funcionarioPodeSolicitarFerias() && diferencaDias.inDays >= 15) {
      return true;
    }
    return false;
  }

  bool aprovarSolicitacao(Gerente gerente) {
    if (gerente.departamento.nome == this.funcionario.departamento.nome &&
        solicitouComQuinzeDias()) {
      return true;
    }
    return false;
  }

  bool funcionarioPodeSolicitarFerias() {
    var diferencaDias =
        DateTime.now().difference(this.funcionario.dataDeEntrada);
    if (diferencaDias.inDays >= 365) {
      return true;
    }
    return false;
  }

  DateTime agendarFerias(Gerente gerente) {
    if (!aprovarSolicitacao(gerente)) {
      throw Exception(
          "Não foi possível agendar suas férias, por favor, verifique com o seu gerente");
    }
    return this.dataSaida;
  }
}
