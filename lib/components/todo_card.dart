import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/services/database.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final FirebaseFirestore firestore;
  final String uid;

  const TodoCard({
    this.todo,
    this.firestore,
    this.uid,
  });

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  onChanged(value) {
    setState(() {
      Database(firestore: widget.firestore)
          .updateTodo(widget.uid, widget.todo.id, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: Color(0x6657CC99),
            offset: Offset(0, 0),
            blurRadius: 1,
          )
        ],
      ),
      child: widget.todo.done
          ? CheckboxListTile(
              value: true,
              activeColor: Color(0xFF57CC99),
              title: Text(
                widget.todo.content,
                style: TextStyle(
                  color: Color(0xFF57CC99),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              onChanged: onChanged,
            )
          : CheckboxListTile(
              value: false,
              activeColor: Color(0xFF57CC99),
              title: Text(
                widget.todo.content,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onChanged: onChanged,
            ),
    );
  }
}
