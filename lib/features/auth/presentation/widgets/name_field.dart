import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/presentation/utils/extensions/text_input_field.dart';
import '../../auth_provider.dart';

class NameField extends ConsumerWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(signUpProvider).nameFormz;
    final bool showError = name!.invalid;
    final nameState = ref.watch(signUpProvider);
    final errorText = nameState.errorMessage;

    return TextInputField(
      key: const Key('name_formz'),
      onChanged: (name) => ref.read(signUpProvider.notifier).onNameChange(name),
      hintText: context.tr.enterUsername,
      errorText: errorText,
      obscureText: !showError ? false : showError,
      label: context.tr.userName,
      inputType: TextInputType.name,
      validator: (value) => name.error?.getMessage(),
    );
  }
}
