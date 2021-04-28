import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/button.dart';
import 'package:todo/components/field.dart';
import 'package:todo/components/spacers.dart';
import 'package:todo/screens/signup.dart';
import 'package:todo/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
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

  signIn(BuildContext context) async {
    if (!validateFields(context)) return;

    final String retVal = await Auth(auth: widget.auth).signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (retVal == "Success") {
      _emailController.clear();
      _passwordController.clear();
    } else {
      showError(retVal, context);
    }
  }

  goToSignup(context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/login.svg',
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
                onPressed: () => signIn(context),
                text: "Log in",
              ),
              EmptyButton(
                onPressed: () => goToSignup(context),
                text: "Sign up",
              )
            ],
          ),
        ),
      ),
    );
  }
}
