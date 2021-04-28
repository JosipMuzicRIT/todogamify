import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/components/empty-screen.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todozie",
      theme: ThemeData(
        // 22577A
        // 38A3A5
        // 57CC99
        // 80ED99
        // C7f9CC
        appBarTheme: AppBarTheme(color: Color(0xFF57CC99)),

        buttonColor: Color(0xFFC7F9CC),
        splashColor: Color(0xFF80ED99),
        unselectedWidgetColor: Color(0xFFC7f9CC),

        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            button: GoogleFonts.roboto().copyWith(fontSize: 16),
          ),
        ),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const EmptyScreen(
              text: "Something went wrong, please try again later",
            );

          if (snapshot.connectionState != ConnectionState.done)
            return const EmptyScreen();

          return StreamBuilder(
            stream: Auth(auth: _auth).user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return const EmptyScreen();
              }
              if (snapshot.data?.uid == null) {
                return LoginScreen();
              }
              return HomeScreen();
            },
          );
        },
      ),
    );
  }
}
