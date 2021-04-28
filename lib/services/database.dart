import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<Todo>> streamTodos({String uid}) {
    try {
      return firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .orderBy("done")
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        final List<Todo> list = <Todo>[];
        querySnapshot.docs.forEach((doc) {
          list.add(Todo.fromDocumentSnapshot(documentSnapshot: doc));
        });
        return list;
      });
    } catch (e) {
      print("The error is: ${e.message}");
      return null;
    }
  }

  Future<void> addTodo({String uid, String content}) async {
    try {
      firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .add({"content": content, "done": false});
    } catch (e) {
      print("The error is: ${e.message}");
    }
  }

  Future<void> updateTodo(String uid, String id, bool value) async {
    try {
      firestore.collection("todos").doc(uid).collection("todos").doc(id).update(
        {
          "done": value,
        },
      );
    } catch (e) {
      print("The error is: ${e.message}");
    }
  }
}
