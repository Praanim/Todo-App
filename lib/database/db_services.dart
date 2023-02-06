import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_app/model/todo_model.dart';

class DatabaseHelper {
//collction reference

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('myTodos');

  Future updateUserData(String title, String description) async {
    return await todoCollection
        .doc(title)
        .set({'title': title, 'description': description});
  }

  List<ToDo> _toDoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      var map = document.data() as Map;

      return ToDo(
          title: map['title'] ?? 'nothing',
          description: map['description'] ?? 'nothing');
    }).toList();
  }

  Future<void> deleteTask(String tobeDeletedTitle) {
    return todoCollection.doc(tobeDeletedTitle).delete();
  }

  Stream<List<ToDo>> get todos {
    return todoCollection.snapshots().map(_toDoListFromSnapshot);
  }
}
