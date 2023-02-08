import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_app/model/todo_model.dart';

class DatabaseHelper {
//collction reference

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('myTodos');

  Future createUserData(String authId, String title, String description) async {
    return await todoCollection.add(
      {"uid": authId, "title": title, "description": description},
    ).then((value) => print("Notes added"));
  }

  Future updateUserData(
      String docId, String title, String description, String authId) async {
    return await todoCollection
        .doc(docId)
        .set({"uid": authId, 'title': title, 'description': description}).then(
            (value) => print("Updated the data in realtime"));
  }

  List<ToDo> _toDoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      var docid = document.id;
      print(docid);
      var map = document.data() as Map;

      return ToDo(
          docid: docid,
          title: map['title'] ?? 'nothing',
          description: map['description'] ?? 'nothing',
          userId: map['uid']);
    }).toList();
  }

  Future<void> deleteTask(String docId) {
    return todoCollection.doc(docId).delete();
  }

  Stream<List<ToDo>> get todos {
    return todoCollection.snapshots().map(_toDoListFromSnapshot);
  }
}
