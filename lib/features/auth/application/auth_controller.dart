import 'dart:async';
import 'dart:developer';

import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_links/uni_links.dart';

import '../domain/entities/user/user_entity.dart';

class AuthController extends StateNotifier<UserEntity?> {
  AuthController(this._ref) : super(null) {
    _initialize();
  }
  final Ref _ref;

  AuthRepository get _repository => _ref.read(authRepositoryProvider);

  Future<void> _initialize() async {
    final res = await _repository.restoreSession();
    state = res.fold((l) => null, (r) => r);
    _updateAuthState();

    if (state == null) {
      await Future.delayed(const Duration(seconds: 3));

      await _handleInitialDeepLink();
    }

    _repository.authStateChange((userEntity) {
      state = userEntity;
      _updateAuthState();
    });
  }

  void _updateAuthState() {
    authStateListenable.value = state != null;
  }

  Future<void> _handleInitialDeepLink() async {
    try {
      final initialLink = await getInitialLink();
      if (!(initialLink?.contains('refresh_token') ?? false)) {
        return;
      }

      final refreshTokenQueryParams = initialLink
          ?.split('&')
          .firstWhere((element) => element.contains('refresh_token'));

      final refreshToken = refreshTokenQueryParams
          ?.substring(refreshTokenQueryParams.indexOf('=') + 1);

      if (refreshToken == null) return;

      final res = await _repository.setSession(refreshToken);
      state = res.fold((l) => null, (r) => r);
      _updateAuthState();
    } on PlatformException catch (e) {
      log(e.code);
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}
