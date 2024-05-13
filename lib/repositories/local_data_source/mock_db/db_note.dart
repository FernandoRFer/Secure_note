// import 'dart:convert';
// import 'dart:developer';
// import 'package:sqflite/sqflite.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// //import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import '../Model/note_model.dart';

// abstract class IDbNotes {
//   Future<int> insert(NoteModel produtoModel);
//   Future<List<NoteModel>> get(int? id);
//   Future<int> remove(int id);
//   Future<void> update(NoteModel produtoModel);
// }

// class DbNotes implements IDbNotes {
//   final String _tableName = "docs";
//   final String _idUser = "idusuario";
//   final String _title = "title";
//   final String _note = "note";

//   static final DbNotes _dbMusica = DbNotes._();
//   Database? _db;

//   factory DbNotes() {
//     return _dbMusica;
//   }

//   DbNotes._();

//   get db async {
//     _db ??= await starDB();
//     return _db;
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     String sql =
//         "CREATE TABLE $_tableName (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$_idUser int ,$_title VARCHAR ,$_note VARCHAR)";
//     await db.execute(sql);
//   }

//   Future<Database> starDB() async {
//     final caminhoBancoDados = await getDatabasesPath();
//     final localBancoDados = join(caminhoBancoDados, "produtos.db");

//     Database db =
//         await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);

//     return db;
//   }

//   @override
//   Future<int> insert(NoteModel produtoModel) async {
//     Database bancoDados = await db;
//     var usuario = produtoModel.toJson();

//     int resultado = await bancoDados.insert(_tableName, usuario);
//     return resultado;
//   }

//   @override
//   Future<List<NoteModel>> get(int? id) async {
//     var bancoDados = await db;
//     String sql;
//     if (id != null) {
//       sql = "SELECT * FROM $_tableName WHERE IdUsuario = $id ";
//     } else {
//       sql = "SELECT * FROM $_tableName ";
//     }

//     var itens = await bancoDados.rawQuery(sql);
//     List<NoteModel> listaTemporaria = [];
//     for (var item in itens) {
//       var lista = NoteModel.fromJson(item);
//       listaTemporaria.add(lista);
//     }

//     log(listaTemporaria.toString());
//     return listaTemporaria;
//   }

//   @override
//   Future<int> remove(int id) async {
//     var bancoDados = await db;
//     return await bancoDados
//         .delete(_tableName, where: "id = ?", whereArgs: [id]);
//   }

//   @override
//   Future<void> update(NoteModel produtoModel) async {
//     var bancoDados = await db;
//     final set = jsonEncode(produtoModel.toJson());
//     String sql =
//         "UPDATE $_tableName SET Produtos = '${produtoModel.title}' , Descricao = '${produtoModel.note}'  WHERE id = ${produtoModel.id}";

//     var result = await bancoDados.rawQuery(sql);
//     log(result);

//     return result;
//   }

//   Future<int> removeProduct(int? id) async {
//     var bancoDados = await db;
//     return await bancoDados
//         .delete(_tableName, where: "id = ?", whereArgs: [id]);
//   }
// }
