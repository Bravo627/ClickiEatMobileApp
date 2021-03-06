import 'package:clicki_eat/Components/CustomHomePageCard.dart';
import 'package:clicki_eat/Scaffolds/BasePage.dart';
import 'package:clicki_eat/Scaffolds/MessBillPage.dart';
import 'package:clicki_eat/Scaffolds/MessMenuPage.dart';
import 'package:clicki_eat/Scaffolds/SignInSignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/BottomHomeIcon.dart';
import '../Singletons/User.dart' as MyUser;
import 'ChatPage.dart';
import 'MessMenuPage.dart';
import 'MessOffPage.dart';

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({Key? key}) : super(key: key);

  @override
  _HomePageScaffoldState createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageSafeArea(),
    );
  }
}

class HomePageSafeArea extends StatelessWidget {
  const HomePageSafeArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BasePageScaffold(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.08),
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.1,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  )
                ]),
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome " + MyUser.User.instance.getName(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          MyUser.User.instance.getEmailAddress(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.02, right: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHomePageCard(
                    iconURL: "assets/MessMenuIcon.svg",
                    title: "Mess Menu",
                    func: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) {
                          return MessMenuScaffold();
                        }),
                      );
                    },
                  ),
                  CustomHomePageCard(
                    iconURL: "assets/MessOffIcon.svg",
                    title: "Mess Off",
                    func: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) {
                          return MessOffScaffold();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.02, right: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHomePageCard(
                    iconURL: "assets/MessBillIcon.svg",
                    title: "Mess Bill",
                    func: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) {
                          return MessBillScaffold();
                        }),
                      );
                    },
                  ),
                  CustomHomePageCard(
                    iconURL: "assets/ChatIcon.svg",
                    title: "Chat",
                    func: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) {
                          return ChatPageScaffold();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                height: screenHeight * 0.1,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomHomeIcon(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      addons: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 2), blurRadius: 8)]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MyUser.User.instance.getProfilePic(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.75, top: screenHeight * 0.015),
          child: Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 2), blurRadius: 2)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                child: Icon(
                  Icons.logout_outlined,
                  size: screenWidth * 0.1,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                      return Scaffold(
                        body: SafeArea(
                          child: SingleChildScrollView(child: SignInSignUpPage()),
                        ),
                      );
                    }));
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
