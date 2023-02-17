import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BoatDatabaseImpl implements SourceBase {
  static const _databaseName = 'boats_database';
  static const _tableName = 'boats_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnName = 'name';
  static const _columnIdentityNumber = 'matricule';
  static const _columnCategoryCnp = 'cnp';
  static const _columnOwner = 'owner';
  static const _columnAvailable = 'available';
  static const _columnRentedAt = 'rent_date';
  static const _columnReturnAt = 'return_date';
  static const _columnRole = 'return_role';
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  @override
  Future<BoatListEntity> allBoats() async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<void> deleteBoat(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<BoatEntity> insertBoat(final BoatEntity boat) async {
    final db = await database;
    late final BoatEntity boatEntity;
    await db.transaction((txn) async {
      final id = await txn.insert(
        _tableName,
        boat,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final results = await txn.query(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
      );
      boatEntity = results.first;
    });
    return boatEntity;
  }

  @override
  Future<void> updateBoat(final BoatEntity boatEntity) async {
    final db = await database;
    final int id = boatEntity['id'];
    await db.update(
      _tableName,
      boatEntity,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_tableName(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_columnName TEXT NOT NULL,
            $_columnOwner TEXT NOT NULL,
            $_columnAvailable BOOLEAN NOT NULL,
            $_columnIdentityNumber TEXT NOT NULL,
            $_columnCategoryCnp TEXT NOT NULL,
            $_columnRentedAt INTEGER NOT NULL,
            $_columnReturnAt INTEGER NOT NULL,
            $_columnRole TEXT NOT NULL,
          )
        ''');
      },
      version: _databaseVersion,
    );
  }
}
