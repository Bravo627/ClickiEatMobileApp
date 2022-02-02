import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:clicki_eat/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AuthTabSection.dart';
import 'FlexBanner.dart';
import 'HomePage.dart';
import 'ShowAlertDialog.dart';
import 'User.dart' as MyUser;

class SignInSignUpPage extends StatefulWidget {
  const SignInSignUpPage({Key? key}) : super(key: key);

  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

/*
class _SignInSignUpPageState extends State<SignInSignUpPage> with SingleTickerProviderStateMixin {
  late TabController controller;
  late double screenWidth;
  late double screenHeight;
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController hostelNameController = TextEditingController();
  late StreamSubscription subscription;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    subscription = FirebaseAuth.instance.authStateChanges().listen(authListener);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          height: (!isLoading) ? screenHeight * 0.5 : screenHeight * 0.2,
          width: (!isLoading) ? double.infinity : screenHeight * 0.2,
          child: (!isLoading)
              ? TabBarView(
                  controller: controller,
                  children: [
                    AuthTabSection(
                      nameController: signUpNameController,
                      emailController: signInEmailController,
                      passwordController: signInPasswordController,
                      hostelsController: hostelNameController,
                      isLoginMode: true,
                      onPress: () async {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: signInEmailController.text, password: signInPasswordController.text);
                        } on FirebaseAuthException catch (e) {
                          await showAlertDialog(context, "Error", e.toString());
                        }
                      },
                    ),
                    AuthTabSection(
                      nameController: signUpNameController,
                      emailController: signUpEmailController,
                      passwordController: signUpPasswordController,
                      hostelsController: hostelNameController,
                      isLoginMode: false,
                      onPress: () async {
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: signUpEmailController.text, password: signUpPasswordController.text);

                          HashMap<String, String> map = HashMap<String, String>();
                          map["hostel"] = hostelNameController.text;
                          map["name"] = signUpNameController.text;
                          await FirebaseFirestore.instance.collection("Users").doc(signUpEmailController.text).set(map);
                          await FirebaseAuth.instance.signOut();
                        } on FirebaseAuthException catch (e) {
                          await showAlertDialog(context, "Error", e.toString());
                        }
                      },
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }

  void authListener(User? user) {
    setState(() {
      isLoading = true;
    });

    if (user != null) {
      if (!user.emailVerified) {
        user.sendEmailVerification();
        showAlertDialog(context, "Email Verification", "Check your email for verification...");
      } else {
        MyUser.User.instance.setEmailAddress(user.email!);
        FirebaseFirestore.instance.collection("Users").doc(user.email!).get().then((value) {
          Map<String, dynamic> map = value.data()!;
          MyUser.User.instance.setHostel(map["hostel"]);
          MyUser.User.instance.setName(map["name"]);
          if (map["image"] == null) {
            MyUser.User.instance.setProfilePic(Image.asset(
              "assets/default_pic.jpg",
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
            ));
          } else {
            MyUser.User.instance.setProfilePic(Image.memory(
              Base64Decoder().convert(map["image"]),
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
            ));
          }

          print(MyUser.User.instance.getEmailAddress());
          print(MyUser.User.instance.getName());
          print(MyUser.User.instance.getHostel());

          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return HomePageScaffold();
          }));
        });
      }
    } else {
      MyUser.User.instance.setName("");
      MyUser.User.instance.setEmailAddress("");
      MyUser.User.instance.setHostel("");
    }

    setState(() {
      isLoading = false;
    });
  }
}
*/
