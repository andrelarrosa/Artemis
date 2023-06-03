import 'package:artemis/dominio/core/estagiario.dart';
import 'package:artemis/dominio/core/funcionario.dart';

abstract class IRegistroPonto {
  double buscarHorasExtrasFuncionario(Funcionario? funcionario);
  double buscarHorasExtrasEstagiario(Estagiario? estagiario);
}
