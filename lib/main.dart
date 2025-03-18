import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBancoDeDados() async {
    final pathDB = await getDatabasesPath();
    final dbLocale = join(pathDB, "nameDatabase.db");

    var bd = await openDatabase(
      dbLocale,
      version: 1,
      onCreate: (db, dbRecentVersion) {
        String sql =
            "CREATE TABLE tb_users(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(20), age INTEGER)";
        db.execute(sql);
      },
    );

    return bd;
  }

  _salvar() async {
    Database bd = await _recuperarBancoDeDados();

    Map<String, dynamic> dadosUsuario = {"name": "Grazi", "age": 34};

    int id = await bd.insert("tb_users", dadosUsuario); // quando ele insere retorna o ID

    print("Salvo: $id");
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDeDados();

    String sql = "SELECT * FROM tb_users WHERE age BETWEEN 20 AND 34";

    List usuarios = await bd.rawQuery(sql);

    for (var item in usuarios) {
      print("ID: ${item["id"]} Nome: ${item["name"]} Idade: ${item["age"]}");
    }
  }

  _recuperarUsuarioPorId(int id) async {
    Database bd = await _recuperarBancoDeDados();

    List usuarios = await bd.query(
      "tb_users",
      columns: ["id", "name", "age"],
      where: "id = ? AND name = ?",
      whereArgs: [id, "Grazi"],
    );

    for (var usuario in usuarios) {
      print("ID: ${usuario["id"]} Nome: ${usuario["name"]} Idade: ${usuario["age"]}");
    }
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDeDados();

    bd.delete("tb_users", where: "id = ?", whereArgs: [id]);
  }

  @override
  Widget build(BuildContext context) {
    _listarUsuarios();
    // _recuperarUsuarioPorId(4);
    // _excluirUsuario(3);

    return const Placeholder();
  }
}
