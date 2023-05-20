import 'package:sqflite/sqflite.dart';

abstract class IConexao {
  Future<Database> abrirConexao(); 
}