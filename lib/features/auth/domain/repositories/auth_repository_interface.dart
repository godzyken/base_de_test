import 'package:base_de_test/features/auth/domain/entities/user/user_entity.dart';
import 'package:base_de_test/features/common/domain/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, bool>> signInWithGoogle();
  Future<Either<Failure, bool>> signOut();

  void authStateChange(
    void Function(UserEntity? userEntity) callback,
  );

  Future<void> setSession(String token);

  Future<Either<Failure, UserEntity>> restoreSession();

  Future<Either<Failure, UserEntity>> signUp(
    String? email,
    String? username,
    String? password,
  );

  Future<Either<Failure, UserEntity>> signInWithPassword(
    String? email,
    String? password,
  );
}
