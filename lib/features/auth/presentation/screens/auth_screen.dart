import 'package:base_de_test/features/auth/presentation/screens/sign_screen.dart';
import 'package:base_de_test/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:base_de_test/features/auth/presentation/widgets/sign_in_with_google_button.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/switch_button.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _showSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 250, 16, 0),
              child: _showSignIn ? const SignInScreen() : const SignUpScreen(),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _showSignIn
                  ? Text(
                      context.tr.welcomeBack,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.black87,
                      ),
                    )
                  : Text(
                      context.tr.create,
                      style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
            )),
            SwitchButton(
                showSignIn: _showSignIn,
                onTap: () {
                  setState(() {
                    _showSignIn = !_showSignIn;
                  });
                }),
            const SizedBox.shrink(),
            const SignInWithGoogleButton()
          ],
        ));
  }
}
