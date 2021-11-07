import 'package:clicki_eat/Hostels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AuthTabSection.dart';
import 'FlexBanner.dart';

class SignInSignUpPage extends StatefulWidget {
  const SignInSignUpPage({Key? key}) : super(key: key);

  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

class _SignInSignUpPageState extends State<SignInSignUpPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late double screenWidth;
  late double screenHeight;
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController hostelNameController = TextEditingController();
  List<String>? hostels;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    getHostelsName().then((value) {
      setState(() {
        hostels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: FlexBanner(),
          width: screenWidth,
          height: screenHeight * 0.35,
        ),
        Container(
          height: screenHeight * 0.075,
          child: TabBar(
            // indicator: UnderlineTabIndicator(insets: EdgeInsets.zero, borderSide: BorderSide(width: 2)),
            controller: controller,
            labelColor: Colors.deepPurpleAccent,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            indicatorColor: Colors.deepPurpleAccent,
            indicatorPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: "Login",
              ),
              Tab(
                text: "Sign Up",
              ),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.5,
          child: TabBarView(
            controller: controller,
            children: [
              AuthTabSection(
                emailController: signInEmailController,
                passwordController: signInPasswordController,
                hostelsController: hostelNameController,
                isLoginMode: true,
                onPress: () {
                  print(signInEmailController.text);
                },
              ),
              AuthTabSection(
                emailController: signUpEmailController,
                passwordController: signUpPasswordController,
                hostelsController: hostelNameController,
                isLoginMode: false,
                onPress: () {
                  print(signUpEmailController.text);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
