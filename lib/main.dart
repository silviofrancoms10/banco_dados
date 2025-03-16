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

    var retorno = await openDatabase(
      dbLocale,
      version: 1,
      onCreate: (db, dbRecentVersion) {
        String sql =
            "CREATE TABLE tb_users(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(20), age INTEGER)";
        db.execute(sql);
      },
    );

    print("aberto: " + retorno.isOpen.toString());
  }

  @override
  Widget build(BuildContext context) {
    _recuperarBancoDeDados();

    return const Placeholder();
  }
}
