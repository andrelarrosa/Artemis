import 'package:artemis/dominio/dao/dao_funcionario.dart';
import 'package:artemis/dominio/dto/departamento_dto.dart';
import 'package:artemis/dominio/dto/funcionario_dto.dart';
import 'package:flutter/material.dart';

class FuncionarioForm extends StatefulWidget {
  @override
  _FuncionarioFormState createState() => _FuncionarioFormState();
}

class _FuncionarioFormState extends State<FuncionarioForm> {
  final _formKey = GlobalKey<FormState>();

  String _nome = '';
  DateTime? _horaExtra;
  DateTime _dataDeEntrada = DateTime.now();
  DAOFuncionario dao = DAOFuncionario();
  DepartamentoDTO _departamento = DepartamentoDTO(nome: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              // SizedBox(height: 16.0),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Hora Extra'),
              //   validator: (value) {
              //     // Adicione suas próprias validações de hora extra aqui, se necessário
              //     return null;
              //   },
              //   onSaved: (value) {
              //     // Converter a string de hora extra em um DateTime, se necessário
              //     _horaExtra = DateTime.parse(value!);
              //   },
              // ),
              // SizedBox(height: 16.0),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Data de Entrada'),
              //   validator: (value) {
              //     // Adicione suas próprias validações de data de entrada aqui, se necessário
              //     return null;
              //   },
              //   onSaved: (value) {
              //     // Converter a string de data de entrada em um DateTime, se necessário
              //     _dataDeEntrada = DateTime.parse(value!);
              //   },
              // ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Departamento'),
                validator: (value) {
                  // Adicione suas próprias validações de data de entrada aqui, se necessário
                  return null;
                },
                onSaved: (value) {
                  // Converter a string de data de entrada em um DateTime, se necessário
                  _departamento = DepartamentoDTO(nome: value.toString());
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  _horaExtra = DateTime.utc(2023, DateTime.march, 9);
                  _dataDeEntrada = DateTime.utc(2021, DateTime.april, 15);
                  await dao.salvarFuncionario(FuncionarioDTO(
                    nome: _nome.toString(),
                    horaExtra: DateTime.parse(_horaExtra.toString()),
                    dataDeEntrada:  DateTime.parse(_dataDeEntrada.toString()),
                    departamento: _departamento,
                  ));
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Departamento {
  vendas,
  marketing,
  financeiro,
  recursosHumanos,
  ti,
  outros,
}
