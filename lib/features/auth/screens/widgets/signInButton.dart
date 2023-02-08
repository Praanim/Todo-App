import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hamro_app/constants/global_variables.dart';
import 'package:hamro_app/features/auth/controller/authController.dart';

class SignInButton extends ConsumerWidget {
  final String name;
  final String email;
  final String password;
  const SignInButton({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariables.secondaryColor,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: (() {
          //signIn

          final authcontrollerinstance = ref.read(authControllerProvider);
          authcontrollerinstance.createUser(name, email, password, context);
        }),
        icon: Icon(Icons.login),
        label: const Text("Sign Up"));
    ;
  }
}
