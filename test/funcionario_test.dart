import 'dart:math';

import 'package:artemis/entidade/agendamentoFerias.dart';
import 'package:artemis/entidade/departamento.dart';
import 'package:artemis/entidade/estagiario.dart';
import 'package:artemis/entidade/funcionario.dart';
import 'package:artemis/entidade/gerente.dart';
import 'package:artemis/entidade/interfaces/iregistro_ponto.dart';
import 'package:artemis/entidade/posicao_trabalho.dart';
import 'package:artemis/entidade/produto.dart';
import 'package:artemis/entidade/registro_ponto.dart';
import 'package:artemis/entidade/terceirizado.dart';
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
  test(
      "Só funcionários com 1 ano ou mais de empresa podem fazer solicitação de férias",
      () {
    var funcionarioPodeSolicitar = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var funcionarioNaoPodeSolicitar = Funcionario(
        dataDeEntrada: DateTime.utc(2022, DateTime.october, 17),
        departamento: Departamento(nome: "RH"));
    expect(funcionarioPodeSolicitar.podeSolicitarFerias(), true);
    expect(funcionarioNaoPodeSolicitar.podeSolicitarFerias(), false);
  });

  test(
      "Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias",
      () {
    var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var agendamentoFerias = AgendamentoFerias(
        funcionario: funcionario,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.solicitouComQuinzeDias(), true);
  });

  test(
      "As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento",
      () {
    var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var gerente = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var agendamentoFerias = AgendamentoFerias(
        funcionario: funcionario,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.aprovarSolicitacao(gerente, funcionario), true);
  });

  test(
      "As férias só devem ser agendadas após aprovação do gerente de departamento",
      () {
    var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var gerente = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var agendamentoFerias = AgendamentoFerias(
        funcionario: funcionario,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFerias.agendarFerias(gerente, funcionario),
        DateTime.utc(2023, DateTime.march, 24));
  });

  test(
      "Somente os gerentes do departamento devem criar novas posições de trabalho",
      () {
    var gerente = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    List<Funcionario> funcionarios = [];
    funcionarios.add(funcionario);
    var novaPosicao = PosicaoTrabalho(
        nome: "recursador",
        funcionarios: funcionarios,
        departamento: gerente.departamento);
    expect(gerente.criarNovaPosicao(novaPosicao), novaPosicao);
  });

  test("Os funcionários não podem exceder o limite de horas extras", () {
    IRegistroPonto rp = HorasExtrasCertas();
    var funcionario = Funcionario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));

    RegistroPonto registroPonto = RegistroPonto(funcionario: funcionario);
    expect(registroPonto.validarHorasExtras(rp), true);
  });

  test("Os estagiários não podem trabalhar mais de 6 horas diárias", () {
    IRegistroPonto rp = HorasExtrasCertas();
    var estagiario = Estagiario(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));

    RegistroPonto registroPonto = RegistroPonto(estagiario: estagiario);
    expect(registroPonto.validarHorasEstagiario(rp), false);
  });

  test("Terceirizados devem receber pelo serviço/produto", () {
    ProdutoTerceirizado produto = ProdutoTerceirizado(
        nome: "SIS",
        dataInicio: DateTime.utc(2021, DateTime.april, 15),
        dataFinal: DateTime.utc(2022, DateTime.april, 15),
        finalizado: true,
        valorAcordado: 1200.0);

    Terceirizado terceiro = Terceirizado(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        nome: "Larrosa Informática",
        produto: produto);
    expect(terceiro.receber(DateTime.utc(2022, DateTime.april, 15)),
        terceiro.produto.valorAcordado);
  });

  test("Terceirizado não podem solicitar férias", () {
    ProdutoTerceirizado produto = ProdutoTerceirizado(
        nome: "SIS",
        dataInicio: DateTime.utc(2021, DateTime.april, 15),
        dataFinal: DateTime.utc(2022, DateTime.april, 15),
        finalizado: true,
        valorAcordado: 1200.0);

    Terceirizado terceiro = Terceirizado(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        nome: "Larrosa Informática",
        produto: produto);
    expect(terceiro.podeSolicitarFerias(), false);
  });

  test("Gerentes devem receber uma bonificação a cada 6 meses", () {
    var gerente = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2022, DateTime.october, 02));
    DateTime dataSolicitacao = DateTime.utc(2023, DateTime.april, 03);
    expect(gerente.temDireitoBonificacao(dataSolicitacao), true);
  });
}

class HorasExtrasCertas implements IRegistroPonto {
  double buscarHorasExtrasFuncionario(Funcionario? funcionario) {
    return 10.0;
  }

  double buscarHorasExtrasEstagiario(Estagiario? estagiario) {
    return 7.0;
  }

}
