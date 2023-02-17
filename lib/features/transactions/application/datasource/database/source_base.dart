import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';

abstract class SourceBase {
  Future<BoatListEntity> allBoats();
  Future<BoatEntity> insertBoat(final BoatEntity boatEntity);
  Future<void> updateBoat(final BoatEntity boatEntity);
  Future<void> deleteBoat(final int id);
}
