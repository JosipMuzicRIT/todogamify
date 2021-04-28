import 'package:flutter/material.dart';

class DefaultField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const DefaultField({Key key, this.controller, this.text = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: text.toLowerCase() == "password",
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: const EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
