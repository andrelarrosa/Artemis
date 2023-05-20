import '../departamento.dart';

class FuncionarioDTOSaida {
   String nome;
   DateTime? horaExtra;
   DateTime dataDeEntrada;
   Departamento departamento;

   FuncionarioDTOSaida({required this.nome, this.horaExtra, required this.dataDeEntrada, required this.departamento});
}