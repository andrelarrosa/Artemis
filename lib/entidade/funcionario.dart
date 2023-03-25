class Funcionario {
  DateTime dataDeEntrada;

  Funcionario({required this.dataDeEntrada});
  
  bool podeSolicitarFerias() {
    var diferencaDias = DateTime.now().difference(this.dataDeEntrada);
    if(diferencaDias.inDays >= 365) {
      return true;
    }
    return false;
  }

  bool solicitouComQuinzeDias(DateTime dataSolicitacao) {
    var diferencaDias = DateTime.now().difference(dataSolicitacao);
    if(diferencaDias.inDays >= 15){
      return true;
    }
    return false;
  }
}
