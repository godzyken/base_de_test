import 'dart:async';
import 'dart:developer';

import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class BoatDatabaseImpl implements SourceBase {
  static final BoatDatabaseImpl instance = BoatDatabaseImpl._init();
  static const _databaseName = 'boats_database';
  static const _tableName = 'boats_table';
  static const _tableOwner = 'owner_table';
  static const _tableAddress = 'address_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnOwnerId = 'owner_id';
  static const _columnName = 'name';
  static const _columnPhone = 'phone';
  static const _columnAddressId = 'address_id';
  static const _columnIdentityNumber = 'identity_number';
  static const _columnTypesBoat = 'boat_types';
  static const _columnCategoryCnp = 'cat_cnp';
  static const _columnAvailable = 'is_available';
  static const _columnCreatedAt = 'created_at';
  static const _columnDeletedAt = 'deleted_at';
  static const _columnRentedAt = 'rented_at';
  static const _columnReturnAt = 'returned_at';
  static const _columnRole = 'role';
  static const _columnDocking = 'docking';
  static const _columnCity = 'city';
  static const _columnZipCode = 'zip_code';
  static const _columnGeo = 'geo';
  static Database? _database;

  BoatDatabaseImpl._init();

  Future<Database> get database async {
    await Sqflite.getDebugModeOn();
    await Sqflite.setDebugModeOn(true);

    _database ??= await _initDatabase();
    return _database!;
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
          $_columnTypesBoat TEXT NOT NULL,
          $_columnIdentityNumber TEXT NOT NULL,
          $_columnCategoryCnp TEXT NOT NULL,
          $_columnCreatedAt INTEGER NOT NULL,
          $_columnDeletedAt INTEGER NOT NULL,
          $_columnRentedAt INTEGER NOT NULL,
          $_columnReturnAt INTEGER NOT NULL,
          $_columnRole TEXT NOT NULL,
          $_columnOwnerId INTEGER NOT NULL,
          $_columnAddressId INTEGER NOT NULL,
          FOREIGN KEY ($_columnOwnerId) REFERENCES $_tableOwner(id),
          FOREIGN KEY ($_columnAddressId) REFERENCES $_tableAddress(id)
        )
      ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableOwner(
          $_columnOwnerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT NOT NULL,
          $_columnPhone INTEGER NOT NULL,
          $_columnAvailable BOOLEAN NOT NULL
        )
      ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableAddress(
          $_columnAddressId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnDocking TEXT NOT NULL,
          $_columnCity TEXT NOT NULL,
          $_columnZipCode INTEGER NOT NULL,
          $_columnGeo INTEGER NOT NULL
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
  Future<BoatListEntity> allBoats() async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<OwnerListEntity> allOwners() async {
    final db = await database;
    return db.query(_tableOwner);
  }

  @override
  Future<AddressListEntity> allAddress() async {
    final db = await database;
    return db.query(_tableAddress);
  }

  @override
  Future<int> deleteAllBoat() async {
    final db = await database;
    final res = await db.rawDelete(_tableName);
    log('result: $res');
    return res;
  }

  @override
  Future<AddressEntity> insertAddress(final AddressEntity address) async {
    final db = await database;
    late final AddressEntity addressEntity;
    await db.transaction((txn) async {
      final id = await txn.insert(
        _tableAddress,
        address,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final results = await txn.query(
        _tableAddress,
        where: '$_columnAddressId = ?',
        whereArgs: [id],
      );
      addressEntity = results.first;
    });
    return addressEntity;
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
  Future<OwnerEntity> insertOwner(final OwnerEntity owner) async {
    final db = await database;
    late final OwnerEntity ownerEntity;
    await db.transaction((txn) async {
      final id = await txn.insert(
        _tableOwner,
        owner,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final results = await txn.query(
        _tableOwner,
        where: '$_columnOwnerId = ?',
        whereArgs: [id],
      );
      ownerEntity = results.first;
    });
    return ownerEntity;
  }

  @override
  Future<void> updateAddress(final AddressEntity addressEntity) async {
    final db = await database;
    final int id = addressEntity['id'];
    await db.update(
      _tableAddress,
      addressEntity,
      where: '$_columnAddressId = ?',
      whereArgs: [id],
    );
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

  @override
  Future<void> updateOwner(final OwnerEntity ownerEntity) async {
    final db = await database;
    final int id = ownerEntity['id'];
    await db.update(
      _tableOwner,
      ownerEntity,
      where: '$_columnOwnerId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteAddress(final int id) async {
    final db = await database;
    return await db.delete(
      _tableAddress,
      where: '$_columnAddressId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteBoat(final int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteOwner(final int id) async {
    final db = await database;
    return await db.delete(
      _tableOwner,
      where: '$_columnOwnerId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future close() async {
    final db = await database;
    db.close();
  }
}
