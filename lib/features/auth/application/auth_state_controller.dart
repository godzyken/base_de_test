import 'dart:async';

import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/domain/entities/auth_state/auth_state.dart'
    as ss;
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateController extends StateNotifier<ss.AuthState> {
  AuthStateController(this._authRepository)
      : super(const ss.AuthState.unauthenticated()) {
    _streamSubscription =
        _authRepository.user!.listen((user) => _onUserChanged(user));
  }

  final AuthRepository _authRepository;
  late final StreamSubscription _streamSubscription;

  ss.AuthStatus? validator(AuthUser? value) {
    if (value!.id.isEmpty) {
      return ss.AuthStatus.authenticated;
    } else {
      return ss.AuthStatus.unauthenticated;
    }
  }

  void _onUserChanged(AuthUser user) {
    if (user.id.isEmpty) {
      state = const ss.AuthState.unauthenticated();
    } else {
      state = ss.AuthState.authenticated(user: user);
    }
  }

  void onSignOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateController, ss.AuthState>(
        (ref) => AuthStateController(ref.watch(authRepositoryProvider)));
