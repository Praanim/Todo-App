import 'package:flutter/material.dart';
import 'package:hamro_app/database/db_services.dart';
import 'package:hamro_app/model/todo_model.dart';
import 'package:hamro_app/shared/decoration.dart';

class MyContainer extends StatefulWidget {
  const MyContainer({Key? key}) : super(key: key);

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
          return Text(
            "Something went wrong",
            style: textStyle,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "Loading",
            style: textStyle,
          );
        }
        if (snapshot.hasData) {
          List<ToDo>? todos = snapshot.data;
          return ListView.builder(
            itemCount: todos!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  child: ListTile(
                      title: Text(todos[index].title!),
                      subtitle: Text(todos[index].description!),
                      trailing: GestureDetector(
                        onTap: () async {
                          await _databaseHelper.deleteTask(todos[index].title!);
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