import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:artemis/infra/conexao/script/script.dart';

class Conexao {
  static Database? _db;

  static Future<Database> abrirConexao() async {
    if (_db == null) {
      String caminho = join(await getDatabasesPath(), 'banco.db');
      deleteDatabase(caminho);
      _db = await openDatabase(
        caminho,
        version: 10,
        onCreate: (db, version) {
          for (var comando in criarBanco) {
            db.execute(comando);
          }
        },
      );
    }
    return _db!;
  }
}