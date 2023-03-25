import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/gerente.dart';
import 'package:flutter_test/flutter_test.dart';
// Regras:
// >>Só funcionários com 1 ano ou mais de empresa podem fazer solicitação de férias
// >>Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias
// >>As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento
// >>As férias só devem ser agendadas após aprovação do gerente de departamento
// >>Somente os gerentes devem criar novas posições de trabalho
// >>Os funcionários não podem exceder o limite de horas extras
// >>Os estagiários não podem trabalhar mais de 6 horas diárias
// >>Terceirizado devem receber pelo serviço/produto
// >>Terceirizado não podem solicitar férias
// >>Gerentes devem receber uma bonificação a cada 6 meses

void main() {
  test("Só funcionários com 1 ano ou mais de empresa podem fazer solicitação de férias", (){
    var funcionarioPodeSolicitar = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15));
    var funcionarioNaoPodeSolicitar = Funcionario(dataDeEntrada: DateTime.utc(2022, DateTime.october, 17));
    expect(funcionarioPodeSolicitar.podeSolicitarFerias(), true);
    expect(funcionarioNaoPodeSolicitar.podeSolicitarFerias(), false);
  });

  test("Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias", (){
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15));
    expect(funcionario.solicitouComQuinzeDias(DateTime.utc(2023, DateTime.march, 9)), true);
  });

  test("As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento", () {
    var gerente = Gerente(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15));
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15));
    expect(gerente.aprovarFerias(funcionario, DateTime.utc(2023, DateTime.march, 9)), true);
  });

}

