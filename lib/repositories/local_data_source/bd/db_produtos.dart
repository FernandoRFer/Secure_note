import 'dart:developer';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../Model/product_model.dart';

class DbProdutos {
  final String _tableName = "Docs";
  final String _idUser = "IdUsuario";
  final String _title = "Title";
  final String _subtitle = "Password";
  final String _description = "Description";

  static final DbProdutos _dbMusica = DbProdutos._();
  Database? _db;

  factory DbProdutos() {
    return _dbMusica;
  }

  DbProdutos._();

  get db async {
    _db ??= await starDB();
    return _db;
  }

  _onCreate(Database db, int version) {
    String sql =
        "CREATE TABLE $_tableName (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$_idUser int ,$_title VARCHAR ,$_subtitle VARCHAR $_description VARCHAR)";
    db.execute(sql);
  }

  Future<Database> starDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "produtos.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);

    return db;
  }

  Future<int> salvarDbProdutos(ProductModel produtoModel) async {
    Database bancoDados = await db;
    var usuario = produtoModel.toJson();

    int resultado = await bancoDados.insert(_tableName, usuario);
    return resultado;
  }

  Future getProduct(int? id) async {
    var bancoDados = await db;

    String sql = "SELECT * FROM $_tableName WHERE IdUsuario = $id ";

    var itens = await bancoDados.rawQuery(sql);
    List<ProductModel> listaTemporaria = [];
    for (var item in itens) {
      var lista = ProductModel.fromJson(item);
      listaTemporaria.add(lista);
    }

    log(listaTemporaria.toString());
    return listaTemporaria;
  }

  Future<void> updateUser(ProductModel produtoModel) async {
    var bancoDados = await db;
    String sql =
        "UPDATE $_tableName SET Produtos = '${produtoModel.produto}' , Descricao = '${produtoModel.descricao}'  WHERE id = ${produtoModel.id}";

    var result = await bancoDados.rawQuery(sql);
    log(result);

    return result;
  }

  Future<int> removeProduct(int? id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
