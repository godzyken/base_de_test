import 'package:base_de_test/features/auth/domain/entities/sign_up/sign_up_state.dart';
import 'package:base_de_test/features/auth/presentation/widgets/email_field.dart';
import 'package:base_de_test/features/auth/presentation/widgets/name_field.dart';
import 'package:base_de_test/features/auth/presentation/widgets/password_field.dart';
import 'package:base_de_test/features/auth/presentation/widgets/sign_up_button.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../application/sign_up_controller.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpProvider, (previous, next) {
      if (next.status!.isSubmissionInProgress) {
        showDialog(
            context: context,
            builder: (_) => SimpleDialog(
                  title: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(context.tr.loading),
                  ),
                ));
      } else if (next.status!.isSubmissionFailure) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${next.errorMessage}"),
          ),
        );
      } else if (next.status!.isSubmissionSuccess) {
        Navigator.of(context).pop();
      }
    });
    return Column(
      children: const [
        NameField(),
        SizedBox(
          height: 16,
        ),
        EmailField(),
        SizedBox(
          height: 16,
        ),
        PasswordField(),
        SizedBox(
          height: 24,
        ),
        SignUpButton()
      ],
    );
  }
}
