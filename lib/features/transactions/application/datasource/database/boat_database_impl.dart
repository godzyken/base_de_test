import 'dart:async';
import 'dart:developer';

import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class BoatDatabaseImpl implements SourceBase {
  static const _databaseName = 'boats_database';
  static const _tableName = 'boats_table';
  static const _tableOwner = 'owner_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnOwnerId = 'owner_id';
  static const _columnName = 'name';
  static const _columnPhone = 'phone';
  static const _columnAddress = 'address';
  static const _columnIdentityNumber = 'matricule';
  static const _columnCategoryCnp = 'cnp';
  static const _columnAvailable = 'available';
  static const _columnCreatedAt = 'create_date';
  static const _columnDeletedAt = 'deleted_date';
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
    if (_database != null) {
      return _database!;
    }

    try {
      var databasePath = await getDatabasesPath();
      String p = path.join(databasePath, _databaseName);
      await Sqflite.setDebugModeOn(true);
      return openDatabase(
        p,
        onConfigure: (db) => _onConfigure(db),
        onOpen: (db) => _onOpen(db),
        onCreate: (db, version) => _onCreate(db, version),
        version: _databaseVersion,
      );
    } on Exception catch (e) {
      log('database initialisation error : $e');
      return database;
    }
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName(
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT NOT NULL,
          $_columnAvailable BOOLEAN NOT NULL,
          $_columnIdentityNumber TEXT NOT NULL,
          $_columnCategoryCnp TEXT NOT NULL,
          $_columnCreatedAt INTEGER NOT NULL,
          $_columnDeletedAt INTEGER NOT NULL,
          $_columnRentedAt INTEGER NOT NULL,
          $_columnReturnAt INTEGER NOT NULL,
          $_columnRole TEXT NOT NULL,
          $_columnOwnerId INTEGER NOT NULL,
          FOREIGN KEY ($_columnOwnerId) REFERENCES $_tableOwner(id)
        )
      ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableOwner(
          $_columnOwnerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT NOT NULL,
          $_columnPhone INTEGER NOT NULL,
          $_columnAddress TEXT NOT NULL
        )
      ''');
  }

  static void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
    await db.rawQuery('PRAGMA journal_mode=WAL');
  }

  static void _onOpen(Database db) async {
    log('database version: ${await db.getVersion()}');
  }

  @override
  Future close() async {
    final db = await database;
    db.close();
  }
}
