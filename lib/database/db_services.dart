import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_app/model/todo_model.dart';

class DatabaseHelper {
//collction reference

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('myTodos');

  Future createUserData(String authId, String title, String description) async {
    return await todoCollection
        .doc(authId)
        .set(ToDo(id: authId, description: description, title: title).toMap())
        .then((value) => print("Notes added"));
  }

  Future updateUserData(String authid, String title, String description) async {
    return await todoCollection
        .doc(authid)
        .set({'title': title, 'description': description}).then(
            (value) => print("Updated the data in realtime"));
  }

  List<ToDo> _toDoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      var docid = document.id;
      print(docid);
      var map = document.data() as Map;

      return ToDo(
          id: docid,
          title: map['title'] ?? 'nothing',
          description: map['description'] ?? 'nothing');
    }).toList();
  }

  Future<void> deleteTask(String docId) {
    return todoCollection.doc(docId).delete();
  }

  Stream<List<ToDo>> get todos {
    return todoCollection.snapshots().map(_toDoListFromSnapshot);
  }
}
