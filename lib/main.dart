import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Scaffolds/SignInSignUpPage.dart';

/// The main function.
/// Initializes all necessary bindings and run the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MainApp());
  });
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nexa',
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(child: SignInSignUpPage()),
        ),
      ),
    );
  }
}
