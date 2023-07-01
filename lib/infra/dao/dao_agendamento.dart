import 'package:artemis/dominio/portas/secundaria/idao_agendamentoFerias.dart';
import 'package:sqflite/sqflite.dart';

import '../../dominio/dto/agendamentoSaida_dto.dart';
import '../conexao/sqlite/conexao.dart';

class DAOAgendamento implements IDAOAgendamentoFerias {
  @override
  Future<bool> salvar({AgendamentoSaidaDTO? agendamentoSaidaDTO}) async {
    Database db = await Conexao.abrirConexao();
    
    const sql = 'INSERT INTO AGENDAMENTO_FERIAS (descricao, data_solicitacao, data_saida, aprovado, funcionario) VALUES (?, ?, ?, ?, ?)';
    var linhasAfetadas = await db.rawInsert(sql, [agendamentoSaidaDTO?.descricao, agendamentoSaidaDTO?.dataSolicitacao, agendamentoSaidaDTO?.dataSaida, agendamentoSaidaDTO?.aprovado, agendamentoSaidaDTO?.funcionario]);
    if(linhasAfetadas > 0){
      return Future.value(true);
    }
    return Future.value(false);
  }
}
