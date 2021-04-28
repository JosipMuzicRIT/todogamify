import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String content;
  String id;
  bool done;

  Todo({
    this.content,
    this.id,
    this.done,
  });

  Todo.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    content = documentSnapshot.data()["content"] as String;
    id = documentSnapshot.id;
    done = documentSnapshot.data()["done"] as bool;
  }
}
