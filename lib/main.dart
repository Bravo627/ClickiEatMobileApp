import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './homepage.dart';

/// The main function.
/// Initializes all necessary bindings and run the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MainApp());
  });
}

/// The main stateless app class.
/// Returns a MaterialApp with dark theme
/// and scaffold [LoginPageScaffold].
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginPageScaffold(),
    );
  }
}

/// It is a global key for [LoginPageScaffold]
/// Used in Firebase hooks to show respective dialogs
/// Might not be the best practise but gets the job done
final GlobalKey<NavigatorState> loginPageScaffoldKey =
    new GlobalKey<NavigatorState>();

/// The scaffold class on the sign-in/sign-up page
/// Also contains the [FirebaseAuth] object
class LoginPageScaffold extends StatefulWidget {
  LoginPageScaffold({Key? key}) : super(key: loginPageScaffoldKey);

  /// The main [FirebaseAuth] instance object
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _LoginPageScaffoldState createState() => _LoginPageScaffoldState();
}

/// The state of [LoginPageScaffold]
class _LoginPageScaffoldState extends State<LoginPageScaffold> {

  /// Controller for username
  final TextEditingController _userNameController = TextEditingController();

  /// Controller for password
  final TextEditingController _passwordController = TextEditingController();

  @override
  /// Calls [super.initState()] and inserts listener to
  /// [widget._auth.userChanges()]
  /// which itself is [FirebaseAuth] object
  void initState() {
    super.initState();

    widget._auth.userChanges().listen(userChanges);
  }

  @override
  /// Disposes both controllers and calls [super.dispose()]
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  /// Contains the GUI for the login page
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address: ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 24, right: 16.0),
              child: TextField(
                decoration: InputDecoration(),
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                controller: _userNameController,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password: ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 24, right: 16.0),
              child: TextField(
                decoration: InputDecoration(),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    await signInButton(_userNameController.text,
                        _passwordController.text, widget._auth, context);
                  },
                  child: Text("Sign In"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    await signUpButton(_userNameController.text,
                        _passwordController.text, widget._auth, context);
                  },
                  child: Text("Sign Up"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The listener for the [userChanges()] in the [FirebaseAuth] object.
/// user is null when signed-out
/// else when signed-in it contains a valid user object.
Future<void> userChanges(User? user) async {
  /*
    The listener is added after the [LoginPageScaffold] has been
    created, so [loginPageScaffoldKey.currentContext] should not be null
   */
  if (user != null) {
    /*
      If the email is not verified, we send a verification
      email and sign-out the user, because [FirebaseAuth]
      automatically signs-in the user upon signing-up
     */
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      await FirebaseAuth.instance.signOut();
      await showMessageDialog("Sign up complete",
          "Please verify your email address!", loginPageScaffoldKey.currentContext!);
    } else {

      /*
        When the user signs-in we navigate to homepage of the app
        We pop this page because, if we go back on the homepage
        we should not come back to this login page
       */
      Navigator.pop(loginPageScaffoldKey.currentContext!);
      Navigator.push(loginPageScaffoldKey.currentContext!,
          MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}

/// The onClick for the signup button in the [LoginPageScaffold]
Future<void> signUpButton(String email, String password, FirebaseAuth auth,
    BuildContext context) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    await showMessageDialog("Error!", e.message ?? "Unknown error!", context);
  }
}

/// The onClick for the sign-in button in the [LoginPageScaffold]
Future<void> signInButton(String email, String password, FirebaseAuth auth,
    BuildContext context) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    await showMessageDialog("Error!", e.message ?? "Unknown error!", context);
  }
}

/// Shows a message dialog with a [title], [message] in a given [context]
/// Should be [await] if necessary for user to click the [Ok] button
Future<void> showMessageDialog(
    String title, String message, BuildContext context) async {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  await showDialog(
      context: context,
      builder: (builder) {
        return SimpleDialog(
          title: Text(title),
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.10,
              child: Center(child: Text(message)),
            ),
          ],
          contentPadding: EdgeInsets.all(16),
        );
      });
}
