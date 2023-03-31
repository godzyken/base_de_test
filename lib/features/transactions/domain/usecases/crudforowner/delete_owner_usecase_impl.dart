import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class DeleteOwnerEntityCase {
  Future<void> execute(final OwnerId id);
}
