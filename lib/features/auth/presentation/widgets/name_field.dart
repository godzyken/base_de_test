import 'package:base_de_test/features/auth/application/sign_up_controller.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/presentation/utils/extensions/text_input_field.dart';

class NameField extends ConsumerWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(signUpProvider).nameFormz;
    final bool showError = name!.invalid;

    return TextInputField(
      key: const Key('name_formz'),
      onChanged: (name) => ref.read(signUpProvider.notifier).onNameChange(name),
      hintText: context.tr.enterUsername,
      errorText: name.error.toString(),
      obscureText: !showError ? false : showError,
      label: context.tr.userName,
      inputType: TextInputType.name,
      validator: (value) => name.error?.getMessage(),
    );
  }
}
