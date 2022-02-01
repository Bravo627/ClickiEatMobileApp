import 'package:clicki_eat/BasePage.dart';
import 'package:clicki_eat/CustomHomePageCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomHomeIcon.dart';
import 'MessOffPage.dart';
import 'User.dart' as MyUser;

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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(50, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome " + MyUser.User.instance.getName(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
              padding: EdgeInsets.only(
                  left: screenWidth * 0.1,
                  top: screenHeight * 0.02,
                  right: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHomePageCard(
                      icon: Image.asset('assets/default_pic.jpg'),
                      title: "Mess Menu",
                      func: () {}),
                  CustomHomePageCard(
                      icon: Image.asset('assets/default_pic.jpg'),
                      title: "Mess Off",
                      func: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (builder) {
                            return MessOffScaffold();
                          }),
                        );
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.1,
                  top: screenHeight * 0.02,
                  right: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHomePageCard(
                      icon: Image.asset('assets/default_pic.jpg'),
                      title: "Location",
                      func: () {}),
                  CustomHomePageCard(
                      icon: Image.asset('assets/default_pic.jpg'),
                      title: "Chat",
                      func: () {}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                height: screenHeight * 0.12,
                width: double.infinity,
                child: BottomHomeIcon(),
              ),
            ),
          ],
        ),
      ),
      addons: [
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.1, top: screenHeight * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(75, 0, 0, 0),
                      offset: Offset(1, 2),
                      blurRadius: 8)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MyUser.User.instance.getProfilePic(),
            ),
          ),
        ),
      ],
    );
  }
}
