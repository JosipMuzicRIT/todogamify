import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String text;

  const EmptyScreen({this.text = "Loading...", Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
