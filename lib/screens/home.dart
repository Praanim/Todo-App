import 'package:flutter/material.dart';
import 'package:hamro_app/screens/form_screen.dart';
import 'package:hamro_app/screens/myContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FormScreen()));
              },
              icon: Icon(Icons.add),
              label: Text("Create Task")),
        ],
      ),
      body: MyContainer(),
    );
  }
}
