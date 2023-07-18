import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static DB? _instance;
  static get instance {
    if (_instance != null) return _instance;
    _instance = DB._();

    return _instance;
  }

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();

    return _database;
  }

  Future<Database> _initDatabase() async {
    var path = join(await getDatabasesPath(), 'minhas_compras_app.db');

    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  _onCreate(Database db, int version) async {
    await db.execute(_user);
    await db.execute(_address);
  }

  String get _user => ''' 
  CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL
  )
  ''';

  String get _address => ''' 
  CREATE TABLE address(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cep TEXT NOT NULL,
    street TEXT NOT NULL,
    complement TEXT NOT NULL,
    neighborhood TEXT NOT NULL,
    locality TEXT NOT NULL,
    state TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id)
  )
  ''';
}
