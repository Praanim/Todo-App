import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hamro_app/features/auth/screens/signInScreen.dart';
import 'package:hamro_app/features/auth/screens/signUpScreen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSignIn = true;
  void toggleView() {
    setState(() {
      isSignIn = !isSignIn;
      print(isSignIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn
        ? SignInScreen(
            toggleView: toggleView,
          )
        : SignUpScreen(toggleView: toggleView);
  }
}
