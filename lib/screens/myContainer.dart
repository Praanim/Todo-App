import 'package:flutter/material.dart';

import 'package:hamro_app/database/db_services.dart';
import 'package:hamro_app/model/todo_model.dart';
import 'package:hamro_app/screens/form_screen.dart';
import 'package:hamro_app/screens/update_screen.dart';
import 'package:hamro_app/shared/decoration.dart';

class MyContainer extends StatefulWidget {
  final String authId;
  const MyContainer({
    Key? key,
    required this.authId,
  }) : super(key: key);

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
      initialData: [],
      stream: DatabaseHelper().todos,
      builder: (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot) {
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Something went wrong",
                style: blacktextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                snapshot.error.toString(),
                style: blacktextStyle,
              )
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              "Loading",
              style: blacktextStyle,
            ),
          );
        }
        if (snapshot.hasData) {
          List<ToDo>? todos = snapshot.data;
          if (todos == null) {
            Center(
              child: Text(
                "There is no item in Todo list",
                style: blacktextStyle,
              ),
            );
          }
          return ListView.builder(
            itemCount: todos!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            todo: todos[index],
                            authId: widget.authId,
                          ),
                        ));
                      },
                      title: Text(todos[index].title),
                      subtitle: Text(todos[index].description),
                      trailing: GestureDetector(
                        onTap: () async {
                          await _databaseHelper.deleteTask(todos[index].id);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      )),
                ),
              );
            },
          );
        } else {
          return Text(
            "K ho K ho",
            style: textStyle,
          );
        }
      },
    );
  }
}
