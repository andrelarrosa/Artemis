import 'package:artemis/entidade/funcionario.dart';

class Gerente extends Funcionario {
  Gerente({required super.dataDeEntrada});


 bool aprovarFerias(Funcionario funcionario, DateTime dataSolicitacao) {
    if(funcionario.solicitouComQuinzeDias(dataSolicitacao)){
      return true;
    }
    return false;
 }
}