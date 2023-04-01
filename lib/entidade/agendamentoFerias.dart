import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/gerente.dart';

class AgendamentoFerias {
  final Funcionario funcionario;
  final DateTime dataSolicitacao;
  final DateTime dataSaida;

  AgendamentoFerias({required this.funcionario, required this.dataSolicitacao, required this.dataSaida});


  bool solicitouComQuinzeDias() {
    var diferencaDias = dataSaida.difference(dataSolicitacao);
    if(funcionario.podeSolicitarFerias() && diferencaDias.inDays >= 15) {
      return true;
    }
    return false;
  }

  bool aprovarSolicitacao(Gerente gerente, Funcionario funcionario) {
    if (gerente.departamento.nome == funcionario.departamento.nome && solicitouComQuinzeDias()) {
      return true;
    }
    return false;
  }

  DateTime agendarFerias(Gerente gerente, Funcionario funcionario) {
    if(!aprovarSolicitacao(gerente, funcionario)) {
      throw Exception("Não foi possível agendar suas férias, por favor, verifique com o seu gerente");
    }
    return this.dataSaida;
  }
}