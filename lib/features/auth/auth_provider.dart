import 'package:base_de_test/config/providers.dart';
import 'package:base_de_test/features/auth/application/auth_controller.dart';
import 'package:base_de_test/features/auth/application/sign_in_with_google_controller.dart';
import 'package:base_de_test/features/auth/domain/entities/user/user_entity.dart';
import 'package:base_de_test/features/auth/infrastructure/datasources/local/auth_token_local_data_source.dart';
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authClient = ref.watch(supabaseClientProvider).auth;
  final prefs = ref.read(sharedPreferencesProvider).asData!.value;
  return AuthRepository(
    AuthTokenLocalDataSource(
      prefs,
    ),
    authClient,
  );
});

final authStateListenable = ValueNotifier<bool>(false);

final authControllerProvider =
    StateNotifierProvider<AuthController, UserEntity?>(
        (ref) => AuthController(ref));

final signInWithGoogleProvider =
    StateNotifierProvider<SignInWithGoogleController, bool>((ref) {
  return SignInWithGoogleController(ref);
});
