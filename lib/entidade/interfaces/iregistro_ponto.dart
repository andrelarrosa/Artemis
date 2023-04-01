import 'package:artemis/entidade/funcionario.dart';

abstract class IRegistroPonto {
  double buscarHorasExtras(Funcionario funcionario);
}