import 'package:artemis/entidade/agendamentoFerias.dart';
import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/posicao_trabalho.dart';

class Gerente extends Funcionario {
  final DateTime dataUltimaBonificacao;
  Gerente(
      {required super.dataDeEntrada,
      required super.departamento,
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
