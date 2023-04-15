import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/agendamentoFerias.dart';
import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/interfaces/iestagiario.dart';

// Segue os principios única responsabilidade (S), e Segregação de interface (I)
class Estagiario implements IEstagiario {
  final DateTime dataDeEntrada;
  final Departamento departamento;
  Estagiario({required this.dataDeEntrada, required this.departamento});

  bool podeSolicitarFerias() {
    var diferencaDias = DateTime.now().difference(this.dataDeEntrada);
    if (diferencaDias.inDays >= 365) {
      return true;
    }
    return false;
  }
}
