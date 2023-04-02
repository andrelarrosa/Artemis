import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/interfaces/iregistro_ponto.dart';

class RegistroPonto {
  // inversão de dependência
  final Funcionario funcionario;

  RegistroPonto({required this.funcionario});

  bool validarHorasExtras(IRegistroPonto registroPonto) {
    double horasExtras = registroPonto.buscarHorasExtras(this.funcionario);
    return horasExtras <= 12.0;
  }

  bool validarHorasEstagiario(IRegistroPonto registroPonto) {
    double horasExtras = registroPonto.buscarHorasExtras(this.funcionario);
    return horasExtras <= 6.0;
  }
}
