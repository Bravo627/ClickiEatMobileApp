import 'package:flutter/material.dart';

class AuthTabSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoginMode;
  final VoidCallback onPress;

  const AuthTabSection({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.isLoginMode,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                labelText: 'Email Address'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                labelText: 'Password'),
            obscureText: true,
          ),
          (!isLoginMode) ? Text("Yo") : Container(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              primary: Colors.white,
              minimumSize: Size(double.infinity, 48),
            ),
            onPressed: onPress,
            child: Text(
              isLoginMode ? "Log In" : "Sign Up",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
