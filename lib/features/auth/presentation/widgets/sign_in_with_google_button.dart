import 'dart:developer';

import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInWithGoogleButton extends ConsumerWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          try {
            ref.read(signInWithGoogleProvider.notifier).signInWithGoogle();
          } catch (e) {
            log(e.toString());
          }
        },
        child: Text(context.tr.signInWithGoogle));
  }
}
