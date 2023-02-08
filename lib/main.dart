import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/common/error_text.dart';
import 'package:hamro_app/common/loader.dart';
import 'package:hamro_app/constants/global_variables.dart';
import 'package:hamro_app/features/auth/controller/authController.dart';
import 'package:hamro_app/features/auth/screens/signUpScreen.dart';
import 'package:hamro_app/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateProvider).when(
          data: (user) {
            return MaterialApp(
              title: 'Todo App',
              theme: ThemeData(
                  // scaffoldBackgroundColor: GlobalVariables.secondaryColor,
                  colorScheme: ColorScheme.light(
                      primary: GlobalVariables.secondaryColor),
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white),
                  )),
              home: user == null ? SignUpScreen() : HomePage(),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
