import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/user_model.dart';

class DbLogin {
  final String _tableName = "user";
  final String _id = "id";
  final String _name = "name";
  final String _eMail = "email";
  final String _phoneNumber = "phonenumber";
  final String _password = "password";

  static final DbLogin _dbMusica = DbLogin._();
  Database? _db;

  factory DbLogin() {
    return _dbMusica;
  }

  DbLogin._();

  get db async {
    _db ??= await inicializarDB();
    return _db;
  }

  void _onCreate(Database db, int version) {
    String sql =
        "CREATE TABLE $_tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$_name VARCHAR,$_password VARCHAR, $_phoneNumber INTERGER, $_eMail VARCHAR)";
    db.execute(sql);
  }

  Future<Database> inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);

    return db;
  }

  Future<bool> saveUser(UserModel loginModel) async {
    Database bancoDados = await db;
    var reculpera = await recuperarUsuario(loginModel);

    if (reculpera.length == 0) {
      var usuario = loginModel.toJson();

      // ignore: unused_local_variable
      int resultado = await bancoDados.insert(_tableName, usuario);
      return true;
    } else {
      return false;
    }
  }

  Future recuperarUsuario(UserModel loginModel) async {
    var bancoDados = await db;
    String usuario = loginModel.name;

    String sql = "SELECT * FROM $_tableName WHERE Usuario = '$usuario'";
    var anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  Future recuperarLoginUsuario(UserModel loginModel) async {
    var bancoDados = await db;
    String usuario = loginModel.name;
    String senha = loginModel.password;

    String sql =
        "SELECT * FROM $_tableName WHERE Usuario = '$usuario' AND Senha = '$senha' ";

    var itens = await bancoDados.rawQuery(sql);
    List<UserModel> listaTemporaria = [];
    for (var item in itens) {
      UserModel lista = UserModel.fromJson(item);
      listaTemporaria.add(lista);
    }

    return listaTemporaria;
  }

  Future<bool> atualizarUsuario(UserModel loginModel) async {
    var bancoDados = await db;
    return await bancoDados.update(_tableName, loginModel,
        where: "id = ?", whereArgs: [loginModel.id]);
  }

  Future<int> removerUsuario(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
