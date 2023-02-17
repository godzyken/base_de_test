import 'dart:developer';

import 'package:base_de_test/features/auth/domain/entities/user/user_entity.dart';
import 'package:base_de_test/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:base_de_test/features/auth/infrastructure/datasources/local/auth_token_local_data_source.dart';
import 'package:base_de_test/features/common/domain/failures/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository(this.authTokenLocalDataSource, this.authClient);

  final AuthTokenLocalDataSource authTokenLocalDataSource;

  final supabase.GoTrueClient authClient;

  UserEntity? get currentUser => authClient.currentUser == null
      ? null
      : UserEntity.fromJson(authClient.currentUser!.toJson());

  Stream<supabase.AuthUser?>? get user => null;

  @override
  void authStateChange(
    void Function(UserEntity? userEntity) callback,
  ) {
    authClient.onAuthStateChange.listen((data) {
      final supabase.AuthChangeEvent event = data.event;
      final supabase.Session? session = data.session;

      switch (event) {
        case supabase.AuthChangeEvent.signedIn:
          callback(UserEntity.fromJson(session!.user.toJson()));
          break;
        case supabase.AuthChangeEvent.signedOut:
          callback(null);
          break;
        case supabase.AuthChangeEvent.userUpdated:
          callback(UserEntity.fromJson(session!.user.toJson()));
          break;
        case supabase.AuthChangeEvent.passwordRecovery:
          // TODO: Handle this case.
          break;
        case supabase.AuthChangeEvent.tokenRefreshed:
          // TODO: Handle this case.
          break;
        case supabase.AuthChangeEvent.userDeleted:
          // TODO: Handle this case.
          break;
        case supabase.AuthChangeEvent.mfaChallengeVerified:
          // TODO: Handle this case.
          break;
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> restoreSession() async {
    final res = authTokenLocalDataSource.get();

    if (res.isLeft()) {
      return left(Failure.empty());
    }

    final response = await authClient.recoverSession(res.getOrElse((_) => ''));
    final data = response.session;

    if (response.session != null || response.user == null) {
      await authTokenLocalDataSource.remove();
      return left(Failure.unauthorized());
    }

    await authTokenLocalDataSource
        .store(response.session?.persistSessionString ?? '');
    return right(UserEntity.fromJson(data!.user.toJson()));
  }

  @override
  Future<Either<Failure, UserEntity>> setSession(String token) async {
    final response = await authClient.setSession(token);
    await authTokenLocalDataSource
        .store(response.session?.persistSessionString ?? '');

    final data = response.session;

    if (response.session != null || response.user == null) {
      await authTokenLocalDataSource.remove();
      return left(Failure.unauthorized());
    }

    return right(UserEntity.fromJson(data!.user.toJson()));
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String? email,
    String? username,
    String? password,
  ) async {
    final response = await authClient.signUp(
      email: email,
      password: password!,
      data: {'username': username},
    );

    await authTokenLocalDataSource
        .store(response.session?.persistSessionString ?? '');

    final data = response.session;

    if (response.session != null || response.user == null) {
      await authTokenLocalDataSource.remove();
      return left(Failure.unauthorized());
    }

    return right(UserEntity.fromJson(data!.user.toJson()));
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithPassword(
    String? email,
    String? password,
  ) async {
    log('signInWithPassword()');
    final res = await authClient.signInWithPassword(
      email: email,
      password: password!,
    );

    await authTokenLocalDataSource
        .store(res.session?.persistSessionString ?? '');

    final data = res.session;

    if (res.session != null || res.user == null) {
      await authTokenLocalDataSource.remove();
      return left(Failure.unauthorized());
    }

    return right(UserEntity.fromJson(data!.user.toJson()));
  }

  @override
  Future<Either<Failure, bool>> signInWithGoogle() async {
    log('signInWithGoogle()');
    final res = await authClient.signInWithOAuth(
      supabase.Provider.google,
    );
    if (!res) {
      return left(Failure.badRequest());
    }
    return right(true);
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    await authTokenLocalDataSource.remove();

    final res = await authClient
        .signOut()
        .then((value) => true, onError: left(Failure.badRequest()));
    if (!res) {
      return left(Failure.badRequest());
    }
    return right(true);
  }
}
