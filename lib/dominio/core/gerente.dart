import 'package:artemis/dominio/core/agendamentoFerias.dart';
import 'package:artemis/dominio/core/departamento.dart';
import 'package:artemis/dominio/core/posicao_trabalho.dart';

// Liskov, responsabilidade única
class Gerente {
  final DateTime dataUltimaBonificacao;
  final DateTime dataDeEntrada;
  final Departamento departamento;
  Gerente(
      {required this.dataDeEntrada,
      required this.departamento,
      required this.dataUltimaBonificacao});

  PosicaoTrabalho criarNovaPosicao(PosicaoTrabalho novaPosicao) {
    if (novaPosicao.departamento.nome != this.departamento.nome) {
      throw Exception("Não foi possível criar uma nova posição!");
    }
    return novaPosicao;
  }

  bool temDireitoBonificacao(DateTime dataSolicitacao) {
    dataSolicitacao = dataSolicitacao.toUtc();
    if (dataUltimaBonificacao == null ||
        dataSolicitacao.difference(dataUltimaBonificacao).inDays >= 183) {
      return true;
    }
    return false;
  }
}
