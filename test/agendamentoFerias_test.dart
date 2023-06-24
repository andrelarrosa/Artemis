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
import 'package:artemis/dominio/dto/agendamentoEntrada_dto.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';
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
  test("Solicitação de Férias Incorreta", () {

    var naoSolicitouCerto = SolicitacaoFeriasDTO(
        funcionario: Funcionario(nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        email: 'andre.larrosa@outlook.com',
        departamento: Departamento(nome: "RH")),
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
        dataSaida: DateTime.utc(2023, DateTime.march, 24),
        gerente: Gerente(
        dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
        departamento: Departamento(nome: "RH"),
        dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15)));

    var agendamento = AgendamentoFeriasEntradaDTO(funcionario: naoSolicitouCerto.funcionario,
        dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
        dataSaida: DateTime.utc(2023, DateTime.march, 24));

    var agendamentoFeriasNaoSolicitouCerto = AgendamentoFerias(agendamento: agendamento);

    expect(agendamentoFeriasNaoSolicitouCerto.solicitouComQuinzeDias(naoSolicitouCerto), false);
  });
}