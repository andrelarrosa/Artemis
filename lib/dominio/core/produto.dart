class ProdutoTerceirizado {
  final String nome;
  final DateTime dataInicioProduto;
  final DateTime dataFinalProduto;
  final bool finalizado;
  final double valorAcordado;
  
  ProdutoTerceirizado(
      {required this.nome,
      required this.dataInicioProduto,
      required this.dataFinalProduto,
      required this.finalizado,
      required this.valorAcordado});
}
