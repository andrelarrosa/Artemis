import 'package:artemis/dominio/core/departamento.dart';
import 'package:artemis/dominio/core/agendamentoFerias.dart';
import 'package:artemis/dominio/portas/primaria/iestagiario.dart';

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
