import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/constants/global_variables.dart';
import 'package:hamro_app/features/auth/controller/authController.dart';
import 'package:hamro_app/features/auth/screens/widgets/signInButton.dart';
import 'package:hamro_app/shared/customtextfield.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.deepPurple,
            child: Align(
              child: Text(
                "     Welcome,\n\To SignIn page",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                    controller: _emailController, hintText: "Email"),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: _passwordController, hintText: "Password"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.secondaryColor,
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: (() {
                      //signIn
                      if (_formKey.currentState!.validate()) {
                        final authcontrollerinstance =
                            ref.read(authControllerProvider);
                        authcontrollerinstance.signInUser(_emailController.text,
                            _passwordController.text, context);
                      }
                    }),
                    icon: Icon(Icons.login),
                    label: const Text("Sign In")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
