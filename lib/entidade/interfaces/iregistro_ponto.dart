import 'package:artemis/entidade/estagiario.dart';
import 'package:artemis/entidade/funcionario.dart';

abstract class IRegistroPonto {
  double buscarHorasExtrasFuncionario(Funcionario? funcionario);
  double buscarHorasExtrasEstagiario(Estagiario? estagiario);
}