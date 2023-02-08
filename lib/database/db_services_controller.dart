import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/database/db_services.dart';
import 'package:hamro_app/model/todo_model.dart';

final dbControllerProvider = Provider(
    (ref) => DbController(databaseHelper: ref.watch(databaseHelperProvider)));

//aba hami streamproviderfamily wala setup garxau for stream of list of todos

final customTodosProvider = StreamProviderFamily((ref, String authId) {
  final dbcontrollerInstance = ref.watch(dbControllerProvider);
  return dbcontrollerInstance.getTodos(authId);
});

class DbController {
  final DatabaseHelper databaseHelper;
  DbController({
    required this.databaseHelper,
  });

  Stream<List<ToDo>> getTodos(String authId) {
    return databaseHelper.todoList(authId);
  }
}
