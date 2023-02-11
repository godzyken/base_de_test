import 'package:base_de_test/features/auth/presentation/widgets/email_field.dart';
import 'package:base_de_test/features/auth/presentation/widgets/password_field.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/submit_button.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../auth_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInController = ref.watch(signInNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.signInWithEmailPassword),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const EmailField(),
              const PasswordField(),
              SubmitButton(
                onPressed: () => signInController.signInWithPassword(),
                enabled: ref.watch(signInNotifierProvider).status ==
                    FormzStatus.valid,
                text: context.tr.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
