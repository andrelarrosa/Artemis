import 'package:artemis/dominio/dto/funcionario_dto.dart';
import 'package:artemis/dominio/portas/secundaria/idao_funcionario.dart';
import 'package:artemis/infra/conexao/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';

class DAOFuncionario implements IDAOFuncionario {
  Future<bool> salvarFuncionario(FuncionarioDTO funcionario) async {
    Database db = await Conexao.abrirConexao();
    const sql = 'INSERT INTO funcionario (nome) VALUES (?)';
    var linhasAfetadas = await db.rawInsert(sql, [funcionario.nome]);
    return linhasAfetadas > 0;
  }
}
