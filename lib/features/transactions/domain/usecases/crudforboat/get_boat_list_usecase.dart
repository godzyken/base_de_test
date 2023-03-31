import '../../entities/boat/boat_list_entity.dart';

abstract class GetBoatListUseCase {
  Future<BoatList> execute();

  Stream<List<BoatList>> streamBoats();
}
