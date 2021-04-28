import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/field.dart';
import 'package:todo/components/todo_card.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/database.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final TextEditingController _todoController = TextEditingController();

  addTodo() {
    if (_todoController.text.isNotEmpty) {
      setState(() {
        Database(firestore: widget.firestore).addTodo(
            uid: widget.auth.currentUser.uid,
            content: _todoController.text.trim());
        _todoController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todoie"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Database(firestore: widget.firestore)
                  .streamTodos(uid: widget.auth.currentUser.uid),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return const Center(
                      child: Text("You dont have any unfinished Todos"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, index) {
                      return TodoCard(
                        firestore: widget.firestore,
                        uid: widget.auth.currentUser.uid,
                        todo: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Color(0x6622577A),
                  offset: Offset(0, 0),
                  blurRadius: 1,
                )
              ],
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 28,
              top: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: DefaultField(controller: _todoController),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: Color(0xFF57CC99),
                  ),
                  child: new IconButton(
                    icon: new Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: addTodo,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
