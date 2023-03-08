import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/common/error_text.dart';
import 'package:hamro_app/common/loader.dart';

import 'package:hamro_app/database/db_services.dart';
import 'package:hamro_app/database/db_services_controller.dart';
import 'package:hamro_app/model/todo_model.dart';
import 'package:hamro_app/screens/form_screen.dart';
import 'package:hamro_app/screens/update_screen.dart';
import 'package:hamro_app/shared/decoration.dart';

class MyContainer extends ConsumerStatefulWidget {
  final String authId;
  MyContainer({
    Key? key,
    required this.authId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyContainerState();
}

class _MyContainerState extends ConsumerState<MyContainer> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return ref.watch(customTodosProvider(widget.authId)).when(
          data: (todos) {
            return ListView.builder(
              itemCount: todos.length,
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
                            await _databaseHelper
                                .deleteTask(todos[index].docid);
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
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader(),
        );
  }
}
// List<ToDo>? todos = snapshot.data;
//           if (todos == null) {
//             Center(
//               child: Text(
//                 "There is no item in Todo list",
//                 style: blacktextStyle,
//               ),
//             );
//           }
//           return ListView.builder(
//             itemCount: todos!.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.only(top: 8),
//                 child: Card(
//                   child: ListTile(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => UpdateScreen(
//                             todo: todos[index],
//                             authId: widget.authId,
//                           ),
//                         ));
//                       },
//                       title: Text(todos[index].title),
//                       subtitle: Text(todos[index].description),
//                       trailing: GestureDetector(
//                         onTap: () async {
//                           await _databaseHelper.deleteTask(todos[index].docid);
//                         },
//                         child: Container(
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Icon(
//                               Icons.delete,
//                               color: Colors.white,
//                             )),
//                       )),
//                 ),
//               );
//             },
//           );