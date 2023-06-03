import 'dart:math';

import 'package:artemis/dominio/core/agendamentoFerias.dart';
import 'package:artemis/dominio/core/departamento.dart';
import 'package:artemis/dominio/core/estagiario.dart';
import 'package:artemis/dominio/core/funcionario.dart';
import 'package:artemis/dominio/core/gerente.dart';
import 'package:artemis/dominio/core/posicao_trabalho.dart';
import 'package:artemis/dominio/core/produto.dart';
import 'package:artemis/dominio/core/registro_ponto.dart';
import 'package:artemis/dominio/core/terceirizado.dart';
import 'package:artemis/dominio/portas/secundaria/iregistro_ponto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Escopo:
/**  Sistema de RH
 * Controlará quando os funcionários da empresa podem pedir solicitar suas férias, sendo aprovadas pelo gerente do seu setor, 
 * controlará os bônus que os gerentes podem receber no salário, quando poderá ser solicitada tal bonificação, 
 * controlará também as horas que o funcionário terá de hora-extra, 
 * terá controle de quantos setores terão na empresa e quais serão os seus gerentes.
*/

// Domínio:
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
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var agendamentoFeriasPodeSolicitar = AgendamentoFerias(
        funcionario: funcionarioPodeSolicitar,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(
        agendamentoFeriasPodeSolicitar.funcionarioPodeSolicitarFerias(), true);

    var funcionarioNaoPodeSolicitar = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2022, DateTime.october, 17),
        departamento: Departamento(nome: "RH"));
    var agendamentoFeriasNaoPodeSolicitar = AgendamentoFerias(
        funcionario: funcionarioNaoPodeSolicitar,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFeriasNaoPodeSolicitar.funcionarioPodeSolicitarFerias(),
        false);
  });

  test(
      "Os funcionários devem solicitar férias com uma antecedência mínima de 15 dias",
      () {
    var funcionarioSolicitouCerto = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var agendamentoFeriasSolicitouCerto = AgendamentoFerias(
        funcionario: funcionarioSolicitouCerto,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFeriasSolicitouCerto.solicitouComQuinzeDias(), true);

    var funcionarioNaoSolicitouCerto = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var agendamentoFeriasNaoSolicitouCerto = AgendamentoFerias(
        funcionario: funcionarioNaoSolicitouCerto,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(agendamentoFeriasNaoSolicitouCerto.solicitouComQuinzeDias(), false);
  });

  test(
      "As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento (Certo)",
      () {
    var funcionario = Funcionario(
        nome: "André",
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
    expect(agendamentoFerias.aprovarSolicitacao(gerente), true);
  });

  test(
      "As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento (Menos de 15 dias)",
      () {
    var funcionarioSolicitouMenosQuinzeDias = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var gerenteSolicitouMenosQuinzeDias = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var agendamentoFeriasSolicitouMenosQuinzeDias = AgendamentoFerias(
        funcionario: funcionarioSolicitouMenosQuinzeDias,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 10),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(
        agendamentoFeriasSolicitouMenosQuinzeDias
            .aprovarSolicitacao(gerenteSolicitouMenosQuinzeDias),
        false);
  });

  test(
      "As suas solicitações de férias devem ser aprovadas pelos seus gerentes de departamento (departamento diferente)",
      () {
    var funcionarioSolicitouGerenteErrado = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var gerenteSolicitouGerenteErrado = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var agendamentoFeriasSolicitouGerenteErrado = AgendamentoFerias(
        funcionario: funcionarioSolicitouGerenteErrado,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 10),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(
        agendamentoFeriasSolicitouGerenteErrado
            .aprovarSolicitacao(gerenteSolicitouGerenteErrado),
        false);
  });

  test(
      "As férias só devem ser agendadas após aprovação do gerente de departamento",
      () {
    var funcionario = Funcionario(
        nome: "André",
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
    expect(agendamentoFerias.agendarFerias(gerente),
        DateTime.utc(2023, DateTime.march, 24));

    var funcionarioErrado = Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "RH"));
    var gerenteErrado = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var agendamentoFeriasErrado = AgendamentoFerias(
        funcionario: funcionarioErrado,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 9),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));
    expect(() => agendamentoFeriasErrado.agendarFerias(gerenteErrado),
        throwsException);
  });

  test(
      "Somente os gerentes do departamento devem criar novas posições de trabalho",
      () {
    var gerente = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15));
    var funcionario = Funcionario(
        nome: "André",
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
        nome: "André",
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
        dataInicioProduto: DateTime.utc(2021, DateTime.april, 15),
        dataFinalProduto: DateTime.utc(2022, DateTime.april, 15),
        finalizado: true,
        valorAcordado: 1200.0);

    Terceirizado terceiro = Terceirizado(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        nome: "Larrosa Informática",
        produto: produto);
    expect(terceiro.receber(DateTime.utc(2022, DateTime.april, 15)),
        terceiro.produto.valorAcordado);

    ProdutoTerceirizado produtoNaoEntregue = ProdutoTerceirizado(
        nome: "SIS",
        dataInicioProduto: DateTime.utc(2021, DateTime.april, 15),
        dataFinalProduto: DateTime.utc(2022, DateTime.april, 15),
        finalizado: false,
        valorAcordado: 1200.0);

    Terceirizado terceiroNaoEntregou = Terceirizado(
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        departamento: Departamento(nome: "Desenvolvimento"),
        nome: "Larrosa Informática",
        produto: produtoNaoEntregue);
    expect(
        () =>
            terceiroNaoEntregou.receber(DateTime.utc(2022, DateTime.april, 15)),
        throwsException);
  });

  test("Terceirizado não podem solicitar férias", () {
    ProdutoTerceirizado produto = ProdutoTerceirizado(
        nome: "SIS",
        dataInicioProduto: DateTime.utc(2021, DateTime.april, 15),
        dataFinalProduto: DateTime.utc(2022, DateTime.april, 15),
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
    var gerenteComDireitoABonificacao = Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2022, DateTime.october, 02));
    DateTime dataSolicitacao = DateTime.utc(2023, DateTime.april, 03);
    expect(gerenteComDireitoABonificacao.temDireitoBonificacao(dataSolicitacao),
        true);

    var gerenteSemDireitoABonificacao = Gerente(
        departamento: Departamento(nome: "RH"),
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        dataUltimaBonificacao: DateTime.utc(2023, DateTime.february, 02));
    DateTime dataSolicitacaoErrada = DateTime.utc(2023, DateTime.april, 03);
    expect(
        gerenteSemDireitoABonificacao
            .temDireitoBonificacao(dataSolicitacaoErrada),
        false);
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
