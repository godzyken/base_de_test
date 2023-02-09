import 'dart:developer';

import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInWithGoogleController extends StateNotifier<bool> {
  SignInWithGoogleController(this._ref) : super(false);

  final Ref _ref;

  Future<void> signInWithGoogle() async {
    log('here2');
    await _ref.read(authRepositoryProvider).signInWithGoogle();
  }
}
