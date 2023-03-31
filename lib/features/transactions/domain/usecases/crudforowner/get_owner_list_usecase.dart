import '../../entities/owner/owner_list_entity.dart';

abstract class GetOwnerListUseCase {
  Future<OwnerList> execute();

  Stream<List<OwnerList>> streamOwners();
}
