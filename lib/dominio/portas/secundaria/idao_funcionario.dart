import 'package:artemis/dominio/dto/funcionario_dto.dart';

abstract class IDAOFuncionario {
  Future<bool> salvarFuncionario(FuncionarioDTO funcionario);
}
