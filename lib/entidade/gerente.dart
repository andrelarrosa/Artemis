import 'package:artemis/entidade/agendamentoFerias.dart';
import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/posicao_trabalho.dart';

class Gerente extends Funcionario {
  Gerente({required super.dataDeEntrada, required super.departamento});

 PosicaoTrabalho criarNovaPosicao(PosicaoTrabalho novaPosicao) {
  if(novaPosicao.departamento.nome != this.departamento.nome) {
    throw Exception("Não foi possível criar uma nova posição!");
  }
  return novaPosicao;
 }
}