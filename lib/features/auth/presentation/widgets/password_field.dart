import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/presentation/utils/extensions/text_input_field.dart';
import '../../auth_provider.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(signInNotifierProvider).passwordFormz;
    final bool showError = password!.isNotValid;
    final passwordState = ref.watch(signInNotifierProvider);
    final errorText = passwordState.errorMessage;

    return TextInputField(
      key: const Key('email_formz'),
      onChanged: (password) =>
          ref.read(signInNotifierProvider.notifier).onPasswordChange(password),
      hintText: context.tr.enterUserPassword,
      errorText: errorText,
      obscureText: !showError ? false : showError,
      label: context.tr.userPassword,
      inputType: TextInputType.visiblePassword,
      validator: (value) => password.error?.getMessage(),
    );
  }
}
