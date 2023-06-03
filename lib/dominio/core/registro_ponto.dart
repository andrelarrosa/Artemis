import 'package:artemis/dominio/core/estagiario.dart';
import 'package:artemis/dominio/core/funcionario.dart';
import 'package:artemis/dominio/portas/secundaria/iregistro_ponto.dart';

class RegistroPonto {
  final Funcionario? funcionario;
  final Estagiario? estagiario;

  RegistroPonto({this.funcionario, this.estagiario});

  bool validarHorasExtras(IRegistroPonto registroPonto) {
    // inversão de dependencia
    double horasExtras =
        registroPonto.buscarHorasExtrasFuncionario(this.funcionario);
    return horasExtras <= 12.0;
  }

  bool validarHorasEstagiario(IRegistroPonto registroPonto) {
    // inversão de dependencia
    double horasExtras =
        registroPonto.buscarHorasExtrasEstagiario(this.estagiario);
    return horasExtras <= 6.0;
  }
}
