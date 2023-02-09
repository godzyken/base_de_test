import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/domain/entities/user_properties/email.dart';
import 'package:base_de_test/features/auth/domain/entities/user_properties/name.dart';
import 'package:base_de_test/features/auth/domain/entities/user_properties/password.dart';
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../domain/entities/sign_up/sign_up_state.dart';

class SignUpController extends StateNotifier<SignUpState> {
  final AuthRepository _authRepository;

  SignUpController(this._authRepository) : super(const SignUpState());

  void onNameChange(String value) {
    final name = NameFormz.dirty(value);

    state = state.copyWith(
      nameFormz: name,
      status: Formz.validate([
        name,
        state.emailFormz!,
        state.passwordFormz!,
      ]),
    );
  }

  void onEmailChange(String v) {
    final email = EmailFormz.dirty(v);

    state = state.copyWith(
      emailFormz: email,
      status: Formz.validate([
        state.nameFormz!,
        email,
        state.passwordFormz!,
      ]),
    );
  }

  void onPasswordChange(String p) {
    final password = PasswordFormz.dirty(p);

    state = state.copyWith(
      passwordFormz: password,
      status: Formz.validate([
        state.nameFormz!,
        state.emailFormz!,
        password,
      ]),
    );
  }

  void signUpWithEmailAndPassword() async {
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authRepository.signUp(state.emailFormz!.value,
          state.nameFormz!.value, state.passwordFormz!.value);

      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString());
    }
  }
}

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        (ref) => SignUpController(ref.watch(authRepositoryProvider)));
