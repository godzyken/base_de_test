import 'package:base_de_test/features/auth/domain/entities/user_properties/email.dart';
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../domain/entities/sign_in/sign_in_state.dart';
import '../domain/entities/user_properties/password.dart';

class SignInWithPasswordController extends StateNotifier<SignInState> {
  final AuthRepository _authRepository;

  SignInWithPasswordController(this._authRepository)
      : super(const SignInState());

/*  FormzStatus validate({EmailFormz? email, PasswordFormz? password}) {
    return Formz.validate([
      email ?? state.emailFormz,
      password ?? state.passwordFormz
    ]);
  }*/

  void onEmailChange(String value) {
    final email = EmailFormz.dirty(value);

    state = state.copyWith(
      emailFormz: email,
      status: onStatus,
    );
  }

  FormzSubmissionStatus? get onStatus {
    return FormzSubmissionStatus.values.fold(FormzSubmissionStatus.initial,
        (previousValue, element) => previousValue ?? element);
  }

  void onPasswordChange(String value) {
    final password = PasswordFormz.dirty(value);

    state = state.copyWith(
      passwordFormz: password,
      status: onStatus,
    );
  }

  Future<void> signInWithPassword() async {
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);

    try {
      await _authRepository.signInWithPassword(
          state.emailFormz!.value, state.passwordFormz!.value);

      state = state.copyWith(status: FormzSubmissionStatus.success);
    } catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.toString());
    }
  }
}
