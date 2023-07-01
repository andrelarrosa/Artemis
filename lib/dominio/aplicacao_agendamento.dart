import 'package:artemis/dominio/core/agendamentoFerias.dart';
import 'package:artemis/dominio/portas/primaria/iverificar_agendamento.dart';
import 'package:artemis/infra/dao/dao_agendamento.dart';
import 'package:artemis/infra/enviar_email.dart';
import 'package:artemis/infra/enviar_email_fake.dart';

import 'core/departamento.dart';
import 'core/funcionario.dart';
import 'core/gerente.dart';
import 'dto/agendamentoEntrada_dto.dart';
import 'dto/agendamentoSaida_dto.dart';
import 'dto/solicitacao_ferias_dto.dart';

class AplicacaoAgendamento implements IVerificarAgendamento {
  var solicitouCerto = SolicitacaoFeriasDTO(
      funcionario: Funcionario(
          nome: "André",
          dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
          email: 'andre.larrosa@outlook.com',
          departamento: Departamento(nome: "RH")),
      dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
      dataSaida: DateTime.utc(2023, DateTime.march, 31),
      gerente: Gerente(
          dataDeEntrada: DateTime.utc(2005, DateTime.april, 15),
          departamento: Departamento(nome: "RH"),
          dataUltimaBonificacao: DateTime.utc(2005, DateTime.april, 15)));

   var agendamentoSaida = AgendamentoSaidaDTO(
      descricao: "Solicitou Férias",
      funcionario: Funcionario(
          nome: "André",
          dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
          email: 'andre.larrosa@outlook.com',
          departamento: Departamento(nome: "RH")),
      dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
      dataSaida: DateTime.utc(2023, DateTime.march, 31),
      aprovado: true);

  var enviarEmail = EnviarEmail();
  var dao = DAOAgendamento();

  AgendamentoFerias agendamentoFerias = AgendamentoFerias(
      agendamento: AgendamentoFeriasEntradaDTO(
    funcionario: Funcionario(
        nome: "André",
        dataDeEntrada: DateTime.utc(2021, DateTime.april, 15),
        email: 'andre.larrosa@outlook.com',
        departamento: Departamento(nome: "RH")),
    dataSolicitacao: DateTime.utc(2023, DateTime.march, 15),
    dataSaida: DateTime.utc(2023, DateTime.march, 31),
  ));

  @override
  bool verificarAgendamento() {    
    if(agendamentoFerias.aprovarSolicitacao(solicitouCerto)){
      agendamentoFerias.EnviarEmail(solicitouCerto, agendamentoSaida,dao: dao, email: enviarEmail);
      return true;
    }
    return false;
  }
}
