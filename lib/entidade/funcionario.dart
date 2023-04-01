import 'package:artemis/entidade/departamento.dart';

class Funcionario {
  final DateTime dataDeEntrada;
  final Departamento departamento;

  Funcionario({required this.dataDeEntrada, required this.departamento});
  
  bool podeSolicitarFerias() {
    var diferencaDias = DateTime.now().difference(this.dataDeEntrada);
    if(diferencaDias.inDays >= 365) {
      return true;
    }
    return false;
  }
}
