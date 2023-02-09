import 'package:flutter/material.dart';

const _kTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.black54,
);

class SwitchButton extends StatelessWidget {
  const SwitchButton({Key? key, required this.showSignIn, required this.onTap})
      : super(key: key);

  final bool showSignIn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 30,
        child: TextButton(
          onPressed: onTap,
          child: showSignIn
              ? const Text(
                  "Don't have account? Sign Up",
                  style: _kTextStyle,
                )
              : const Text(
                  "Already Have one? Sign In",
                  style: _kTextStyle,
                ),
        ));
  }
}
