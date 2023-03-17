import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

@GenerateMocks([Database])
void main() async {
  const tableName = 'boats_table';
  const tableOwner = 'owner_table';
  const tableAddress = 'address_table';
  const databaseVersion = 1;
  const databaseName = 'boats_database';
  const columnId = 'id';
  const columnOwnerId = 'owner_id';
  const columnName = 'name';
  const columnPhone = 'phone';
  const columnAddressId = 'address_id';
  const columnIdentityNumber = 'matricule';
  const columnCategoryCnp = 'cnp';
  const columnAvailable = 'available';
  const columnCreatedAt = 'create_date';
  const columnDeletedAt = 'deleted_date';
  const columnRentedAt = 'rent_date';
  const columnReturnAt = 'return_date';
  const columnRole = 'return_role';
  const columnDocking = 'docking';
  const columnCity = 'city';
  const columnZipCode = 'zip_code';
  const columnGeo = 'geo';

  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute(sqlDb(
      columnId,
      columnName,
      columnAddressId,
      columnOwnerId,
      columnPhone,
      columnIdentityNumber,
      columnCategoryCnp,
      columnAvailable,
      columnCreatedAt,
      columnDeletedAt,
      columnRentedAt,
      columnReturnAt,
      columnRole,
      columnDocking));
  await db.insert(
      'Boat',
      valuesRsp(
          columnName,
          columnAddressId,
          columnOwnerId,
          columnPhone,
          columnIdentityNumber,
          columnCategoryCnp,
          columnAvailable,
          columnCreatedAt,
          columnDeletedAt,
          columnRentedAt,
          columnReturnAt,
          columnRole,
          columnDocking));

  await db.insert(
      'Boat',
      valuesRsp(
          columnName,
          columnAddressId,
          columnOwnerId,
          columnPhone,
          columnIdentityNumber,
          columnCategoryCnp,
          columnAvailable,
          columnCreatedAt,
          columnDeletedAt,
          columnRentedAt,
          columnReturnAt,
          columnRole,
          columnDocking));

  var result = await db.query('Boat');
  print(result);
  // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  await db.close();
}

Map<String, Object?> valuesRsp(
  String columnName,
  String columnAddressId,
  String columnOwnerId,
  String columnPhone,
  String columnIdentityNumber,
  String columnCategoryCnp,
  String columnAvailable,
  String columnCreatedAt,
  String columnDeletedAt,
  String columnRentedAt,
  String columnReturnAt,
  String columnRole,
  String columnDocking,
) =>
    <String, Object?>{
      columnName: 'boat 1',
      columnAddressId: 'address_id',
      columnOwnerId: 'ownerId_id',
      columnPhone: 'Phone',
      columnIdentityNumber: 'IdentityNumber',
      columnCategoryCnp: 'CategoryCnp',
      columnAvailable: 'Available',
      columnCreatedAt: 'CreatedAt',
      columnDeletedAt: 'DeletedAt',
      columnRentedAt: 'RentedAt',
      columnReturnAt: 'ReturnAt',
      columnRole: 'Role',
      columnDocking: 'Docking'
    };

String sqlDb(
  String columnId,
  String columnName,
  String columnAddressId,
  String columnOwnerId,
  String columnPhone,
  String columnIdentityNumber,
  String columnCategoryCnp,
  String columnAvailable,
  String columnCreatedAt,
  String columnDeletedAt,
  String columnRentedAt,
  String columnReturnAt,
  String columnRole,
  String columnDocking,
) {
  return '''
CREATE TABLE IF NOT EXISTS Boat (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $columnName TEXT NOT NULL,
    $columnAddressId INTEGER NOT NULL,
    $columnOwnerId INTEGER NOT NULL,
    $columnPhone INTEGER NOT NULL,
    $columnIdentityNumber TEXT NOT NULL,
    $columnCategoryCnp TEXT NOT NULL,
    $columnAvailable BOOLEAN NOT NULL,
    $columnCreatedAt INTEGER NOT NULL,
    $columnDeletedAt INTEGER NOT NULL,
    $columnRentedAt INTEGER NOT NULL,
    $columnReturnAt INTEGER NOT NULL,
    $columnRole TEXT NOT NULL,
    $columnDocking TEXT NOT NULL
)
''';
}
