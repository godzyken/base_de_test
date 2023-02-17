import '../entities/boat_list_entity.dart';

abstract class GetBoatListUseCase {
  Future<BoatList> execute();
}
