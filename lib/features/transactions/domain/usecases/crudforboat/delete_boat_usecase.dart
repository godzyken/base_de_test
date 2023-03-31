import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';

abstract class DeleteBoatLocationUseCase {
  Future<void> execute(final BoatId id);
}
