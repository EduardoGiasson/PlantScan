import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/planta.dart';

class DatabaseProvider {

  static const _dbName = 'plantas.db';
  static const _dbVersion = 2;

  DatabaseProvider._();

  static final DatabaseProvider instance =
  DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {

    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database!;
  }

  Future<Database> _initDatabase() async {

    String path = join(
      await getDatabasesPath(),
      _dbName,
    );

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {

    await db.execute('''
      CREATE TABLE ${Planta.TABLE_NAME} (

        ${Planta.FIELD_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Planta.FIELD_NOME} TEXT NOT NULL,
        ${Planta.FIELD_DESCRICAO} TEXT NOT NULL,
        ${Planta.FIELD_PORCENTAGEM} TEXT NOT NULL,
        ${Planta.FIELD_FOTO} TEXT

      )
    ''');
  }

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {

    if(oldVersion < 2){

      await db.execute('''
        ALTER TABLE ${Planta.TABLE_NAME}
        ADD COLUMN ${Planta.FIELD_FOTO} TEXT
      ''');

    }
  }

  Future<void> close() async {

    if(_database != null){
      await _database!.close();
    }

  }
}