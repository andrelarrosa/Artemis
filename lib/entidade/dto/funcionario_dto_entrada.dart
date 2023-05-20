import '../departamento.dart';

class FuncionarioDTOEntrada {
   String nome;
   DateTime? horaExtra;
   DateTime dataDeEntrada;
   Departamento departamento;

   FuncionarioDTOEntrada({required this.nome, this.horaExtra, required this.dataDeEntrada, required this.departamento});
}