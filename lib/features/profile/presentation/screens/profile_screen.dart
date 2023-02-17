import 'package:base_de_test/features/auth/application/auth_state_controller.dart';
import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authStateProvider.notifier);
    final authUser = ref.watch(authControllerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("user id: ${authUser?.id}"),
          Text("user email: ${authUser?.email}"),
          Text("email verified: ${authUser?.createdAt}"),
          TextButton(
              onPressed: () {
                authController.onSignOut();
              },
              child: Text(context.tr.signOut)),
        ],
      ),
    );
  }
}
