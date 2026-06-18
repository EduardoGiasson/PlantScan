import '../database/database_provider.dart';
import '../model/planta.dart';

class PlantaDao {

  final dbProvider = DatabaseProvider.instance;

  Future<void> salvar(Planta planta) async {

    final db = await dbProvider.database;

    await db.insert(
      Planta.TABLE_NAME,
      planta.toMap(),
    );
  }

  Future<void> atualizar(Planta planta) async {

    final db = await dbProvider.database;

    await db.update(
      Planta.TABLE_NAME,
      planta.toMap(),
      where: "${Planta.FIELD_ID} = ?",
      whereArgs: [planta.id],
    );
  }

  Future<List<Planta>> listar() async {

    final db = await dbProvider.database;

    final result = await db.query(
      Planta.TABLE_NAME,
      orderBy: "${Planta.FIELD_ID} DESC",
    );

    return result.map((e) => Planta.fromMap(e)).toList();
  }

  Future<void> excluir(int id) async {

    final db = await dbProvider.database;

    await db.delete(
      Planta.TABLE_NAME,
      where: "${Planta.FIELD_ID} = ?",
      whereArgs: [id],
    );
  }
}