import 'package:artemis/dominio/aplicacao_agendamento.dart';
import 'package:artemis/infra/enviar_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:artemis/dominio/dto/agendamentoSaida_dto.dart';
import 'package:artemis/dominio/dto/solicitacao_ferias_dto.dart';
import 'package:artemis/dominio/portas/secundaria/ienviar_email.dart';

import 'dominio/core/departamento.dart';
import 'dominio/core/funcionario.dart';
import 'dominio/core/gerente.dart';
import 'dominio/dto/agendamentoEntrada_dto.dart';

class Inicializador extends StatelessWidget {
  const Inicializador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Aplicativo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tela em Branco'),
        ),
        body: FormPage(),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dataDeEntradaController = TextEditingController();
  final TextEditingController departamentoController = TextEditingController();
  final TextEditingController dataSolicitacaoController =
      TextEditingController();
  final TextEditingController dataSaidaController = TextEditingController();
  final TextEditingController dataDeEntradaGerenteController =
      TextEditingController();
  final TextEditingController departamentoGerenteController =
      TextEditingController();
  final TextEditingController dataUltimaBonificacaoController =
      TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preencher os campos com os valores iniciais
    nomeController.text = 'André';
    emailController.text = 'andre.larrosa@outlook.com';
    dataDeEntradaController.text = '2021-04-15';
    departamentoController.text = 'RH';
    dataSolicitacaoController.text = '2023-03-15';
    dataSaidaController.text = '2023-03-31';
    dataDeEntradaGerenteController.text = '2005-04-15';
    departamentoGerenteController.text = 'RH';
    dataUltimaBonificacaoController.text = '2005-04-15';
    descricaoController.text = '${nomeController.text} solicitou férias!';
  }

  @override
  void dispose() {
    // Limpar os controladores ao sair da página
    nomeController.dispose();
    emailController.dispose();
    dataDeEntradaController.dispose();
    departamentoController.dispose();
    dataSolicitacaoController.dispose();
    dataSaidaController.dispose();
    dataDeEntradaGerenteController.dispose();
    departamentoGerenteController.dispose();
    dataUltimaBonificacaoController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> enviarFormulario() async {
    // Extrair os valores dos campos e criar as instâncias necessárias
    final solicitouCerto = SolicitacaoFeriasDTO(
      funcionario: Funcionario(
        nome: nomeController.text,
        dataDeEntrada: DateTime.parse(dataDeEntradaController.text),
        email: emailController.text,
        departamento: Departamento(nome: departamentoController.text),
      ),
      dataSolicitacao: DateTime.parse(dataSolicitacaoController.text),
      dataSaida: DateTime.parse(dataSaidaController.text),
      gerente: Gerente(
        dataDeEntrada: DateTime.parse(dataDeEntradaGerenteController.text),
        departamento: Departamento(nome: departamentoGerenteController.text),
        dataUltimaBonificacao:
            DateTime.parse(dataUltimaBonificacaoController.text),
      ),
    );

    final agendamento = AgendamentoFeriasEntradaDTO(
      funcionario: solicitouCerto.funcionario,
      dataSolicitacao: solicitouCerto.dataSolicitacao,
      dataSaida: solicitouCerto.dataSaida,
    );

    final agendamentoSaida = AgendamentoSaidaDTO(
      descricao: descricaoController.text,
      funcionario: solicitouCerto.funcionario,
      dataSolicitacao: solicitouCerto.dataSolicitacao,
      dataSaida: solicitouCerto.dataSaida,
      aprovado: true,
    );

    final enviarEmail = AplicacaoAgendamento();
    await enviarEmail.verificarAgendamento();

    // Exibir mensagem de sucesso ou fazer outra ação
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Enviado'),
          content: Text('O email foi enviado com sucesso.'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Aplicativo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulário'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: dataDeEntradaController,
                  decoration: InputDecoration(labelText: 'Data de Entrada'),
                ),
                TextFormField(
                  controller: departamentoController,
                  decoration: InputDecoration(labelText: 'Departamento'),
                ),
                TextFormField(
                  controller: dataSolicitacaoController,
                  decoration: InputDecoration(labelText: 'Data de Solicitação'),
                ),
                TextFormField(
                  controller: dataSaidaController,
                  decoration: InputDecoration(labelText: 'Data de Saída'),
                ),
                TextFormField(
                  controller: dataDeEntradaGerenteController,
                  decoration:
                      InputDecoration(labelText: 'Data de Entrada do Gerente'),
                ),
                TextFormField(
                  controller: departamentoGerenteController,
                  decoration:
                      InputDecoration(labelText: 'Departamento do Gerente'),
                ),
                TextFormField(
                  controller: dataUltimaBonificacaoController,
                  decoration:
                      InputDecoration(labelText: 'Data da Última Bonificação'),
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: enviarFormulario,
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
