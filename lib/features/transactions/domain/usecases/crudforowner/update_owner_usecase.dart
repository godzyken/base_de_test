import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class UpdateOwnerUseCase {
  Future<void> execute(
    final OwnerId id,
    final String name,
    final String phone,
    final bool isValid,
  );
}
