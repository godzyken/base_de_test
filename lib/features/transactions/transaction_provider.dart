import 'dart:developer';

import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionProvider {
  static final TransactionProvider instance = TransactionProvider._init();
  static Database? _db;

  TransactionProvider._init();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _useDatabase('boats.db');
    return _db!;
  }

  String get sqlCreateTable =>
      'CREATE TABLE boats (id INTEGER PRIMARY KEY, name TEXT, society TEXT)';

  String get sqlSelect => 'SELECT * FROM boats ORDER BY id';

  String get sqlInsert =>
      'INSERT INTO boats (name, owner, rentedAt, returnAt) Values (?,?,?,?)';

  String get sqlUpdate =>
      'UPDATE boats SET name = ?, rentedAt = ?, returnAt = ?, available = ?';

  String get sqlDeleteAll => 'DELETE FROM boats';

  String get sqlDeleteId => 'DELETE FROM boats WHERE id = ?';

  Future<Database> _useDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'boats.db'),
      onCreate: (db, version) {
        return db.execute(sqlCreateTable);
      },
      version: 1,
    );
  }

  Future<List<Boat>> searchBoats() async {
    final db = await instance.db;
    final result = await db.rawQuery(sqlSelect);
    log('$result');
    return result.map((json) => Boat.fromJson(json)).toList();
  }

  Future<Boat> save(Boat boatEntity) async {
    final db = await instance.db;
    final id = await db
        .rawInsert(sqlInsert, [boatEntity.name, boatEntity.ownerEntity]);

    log('$id');
    return boatEntity.copyWith(boatId: BoatId(value: id));
  }

  Future<Boat> update(Boat boatEntity) async {
    final db = await instance.db;
    final id = await db.rawUpdate(sqlUpdate, [
      boatEntity.name,
      boatEntity.rentedAt,
      boatEntity.returnedAt,
      boatEntity.available
    ]);
    log('$id');
    return boatEntity.copyWith(boatId: BoatId(value: id));
  }

  Future<int> deleteAll() async {
    final db = await instance.db;
    final result = await db.rawDelete(sqlDeleteAll);
    log('$result');
    return result;
  }

  Future<int> delete(int boatId) async {
    final db = await instance.db;
    final id = await db.rawDelete(sqlDeleteId, [boatId]);
    log('$id');
    return id;
  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
