import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/produto.dart';

class Terceiro extends Funcionario {
  final String nome;
  final DateTime dataInicioProduto;
  final DateTime dataFinalProduto;
  final Produto produto;

  Terceiro(
      {required super.dataDeEntrada,
      required super.departamento,
      required this.nome,
      required this.dataInicioProduto,
      required this.dataFinalProduto,
      required this.produto});

  double receber(DateTime dataEntrega) {
    if (!produto.finalizado) {
      throw new Exception(
          "Não poderá receber, o produto ainda não foi finalizado");
    }
    return produto.valorAcordado;
  }

  @override
  bool podeSolicitarFerias() {
    return false;
  }
}
