class ProdutoTerceirizado {
  final String nome;
  final DateTime dataInicio;
  final DateTime dataFinal;
  final bool finalizado;
  final double valorAcordado;
  
  ProdutoTerceirizado(
      {required this.nome,
      required this.dataInicio,
      required this.dataFinal,
      required this.finalizado,
      required this.valorAcordado});
}
