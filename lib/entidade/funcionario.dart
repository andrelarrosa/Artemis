import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/interfaces/ifuncionario.dart';

// Segue princípio de Uma responsabilidade(S), aberto/fechado (O)
class Funcionario implements IFuncionario {
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
