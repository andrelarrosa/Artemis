import 'dart:math';

import 'package:artemis/entidade/agendamentoFerias.dart';
import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/gerente.dart';
import 'package:artemis/entidade/interfaces/iregistro_ponto.dart';
import 'package:artemis/entidade/plano_trabalho_empresa.dart';
import 'package:artemis/entidade/posicao_trabalho.dart';
import 'package:artemis/entidade/registro_ponto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Regras:
// >>Só funcionários com 1 ano ou mais de empresa podem fazer solicitação de férias
// >>Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias
// >>As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento
// >>As férias só devem ser agendadas após aprovação do gerente de departamento
// >>Somente os gerentes do departamento devem criar novas posições de trabalho
// >>Os funcionários não podem exceder o limite de horas extras
// >>Os estagiários não podem trabalhar mais de 6 horas diárias
// >>Terceirizado devem receber pelo serviço/produto
// >>Terceirizado não podem solicitar férias
// >>Gerentes devem receber uma bonificação a cada 6 meses

void main() {
  test("Só funcionários com 1 ano ou mais de empresa podem fazer solicitação de férias", (){
    var funcionarioPodeSolicitar = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var funcionarioNaoPodeSolicitar = Funcionario(dataDeEntrada: DateTime.utc(2022, DateTime.october, 17), departamento: Departamento(nome: "RH"));
    expect(funcionarioPodeSolicitar.podeSolicitarFerias(), true);
    expect(funcionarioNaoPodeSolicitar.podeSolicitarFerias(), false);
  });

  test("Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias", (){
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var agendamentoFerias = AgendamentoFerias(funcionario: funcionario, dataSolicitacao: DateTime.utc(2023, DateTime.march, 9), dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.solicitouComQuinzeDias(), true);
  });

  test("As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento", () {
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),departamento: Departamento(nome: "RH"));
    var gerente = Gerente(dataDeEntrada: DateTime.utc(2005, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var agendamentoFerias = AgendamentoFerias(funcionario: funcionario, dataSolicitacao: DateTime.utc(2023, DateTime.march, 9), dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.aprovarSolicitacao(gerente, funcionario), true);
  });

  test("As férias só devem ser agendadas após aprovação do gerente de departamento", () {
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var gerente = Gerente(dataDeEntrada: DateTime.utc(2005, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var agendamentoFerias = AgendamentoFerias(funcionario: funcionario, dataSolicitacao: DateTime.utc(2023, DateTime.march, 9), dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.agendarFerias(gerente, funcionario), DateTime.utc(2023, DateTime.march, 24));
  });

  test("Somente os gerentes do departamento devem criar novas posições de trabalho", () {
    var gerente = Gerente(dataDeEntrada: DateTime.utc(2005, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    var funcionario = Funcionario(dataDeEntrada: DateTime.utc(2021, DateTime.april, 15), departamento: Departamento(nome: "RH"));
    List<Funcionario> funcionarios = [];
    funcionarios.add(funcionario);
    var novaPosicao = PosicaoTrabalho(nome: "recursador", funcionarios: funcionarios, departamento: gerente.departamento);
    expect(gerente.criarNovaPosicao(novaPosicao),  novaPosicao);
  });

  test("Os funcionários não podem exceder o limite de horas extras", (){
    IRegistroPonto rp = HorasExtrasCertas();
     var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));

    RegistroPonto registroPonto = RegistroPonto(funcionario: funcionario);
    expect(registroPonto.validarHorasExtras(rp), true);
  });

  test("Os estagiários não podem trabalhar mais de 6 horas diárias", () {

  });
}

class HorasExtrasCertas implements IRegistroPonto {
  double buscarHorasExtras (Funcionario funcionario) {
    return 10.0;
  }
}

