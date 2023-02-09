import 'package:base_de_test/features/auth/application/sign_in_with_password_controller.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/presentation/utils/extensions/text_input_field.dart';

class EmailField extends ConsumerWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(signInNotifierProvider).emailFormz;
    final bool showError = email!.invalid;

    return TextInputField(
      key: const Key('email_formz'),
      onChanged: (email) =>
          ref.read(signInNotifierProvider.notifier).onEmailChange(email),
      hintText: context.tr.enterUserEmail,
      errorText: email.error.toString(),
      obscureText: !showError ? false : showError,
      label: context.tr.userEmail,
      inputType: TextInputType.emailAddress,
      validator: (value) => email.error?.getMessage(),
    );
  }
}
