import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/common/error_text.dart';
import 'package:hamro_app/common/loader.dart';
import 'package:hamro_app/features/auth/controller/authController.dart';
import 'package:hamro_app/screens/form_screen.dart';
import 'package:hamro_app/screens/myContainer.dart';

import '../model/user_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // UserModel? userModel;
  // getUserData() async {
  //   userModel = await ref.watch(authControllerProvider).getUserdata.first;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userDataProvider).when(
          data: (userModel) {
            return Scaffold(
              floatingActionButton: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FormScreen(
                              authId: userModel.uid,
                            )));
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Create",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              appBar: AppBar(
                title: Text("Todo App"),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        ref.read(authControllerProvider).logOut();
                      },
                      icon: Icon(Icons.logout),
                      label: Text("Log Out")),
                ],
              ),
              body: MyContainer(authId: userModel.uid),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader(),
        );
  }
}
