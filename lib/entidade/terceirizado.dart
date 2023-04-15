import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/produto.dart';

// herança
class Terceirizado extends Funcionario {
  //abstração
  final String nome;
  final ProdutoTerceirizado produto;

  Terceirizado(
      {required super.dataDeEntrada,
      required super.departamento,
      required this.nome,
      required this.produto});

  // Encapsulamento da lógica para determinar se um terceiro pode receber
  double receber(DateTime dataEntrega) {
    if (!produto.finalizado) {
      throw new Exception(
          "Não poderá receber, o produto ainda não foi finalizado");
    }
    return produto.valorAcordado;
  }

  // Polimorfismo (sobrescreve o método com o mesmo nome na classe pai, Funcionario)
  @override
  bool podeSolicitarFerias() {
    return false;
  }
}
