import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/button.dart';
import 'package:todo/components/field.dart';
import 'package:todo/components/spacers.dart';
import 'package:todo/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  showError(String errMsg, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errMsg)));
  }

  bool validateFields(BuildContext context) {
    if (_emailController.value.text.length == 0 ||
        _passwordController.value.text.length == 0) {
      showError("Fields cannot be empty", context);
      return false;
    }
    return true;
  }

  createAccount(context) async {
    if (!validateFields(context)) return;

    final String retVal = await Auth(auth: widget.auth).createAccount(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (retVal == "Success") {
      _emailController.clear();
      _passwordController.clear();
      Navigator.of(context).pop();
    } else {
      showError(retVal, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/signup.svg',
                height: 200,
              ),
              spacer40,
              spacer40,
              DefaultField(
                text: "Email",
                controller: _emailController,
              ),
              spacer20,
              DefaultField(
                text: "Password",
                controller: _passwordController,
              ),
              spacer40,
              DefaultButton(
                onPressed: () => createAccount(context),
                text: "Sign up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
