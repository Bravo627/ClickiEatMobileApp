import 'package:clicki_eat/CustomCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/BackgroundIllustration.svg",
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.1),
            child: Container(
              height: screenHeight * 0.9,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.4,
                        0.9,
                      ],
                      colors: [
                        Colors.white,
                        Color.fromARGB(75, 237, 147, 189),
                      ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
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
                          CustomCard(
                              icon: Image.asset('assets/default_pic.jpg'),
                              title: "Mess Menu",
                              func: () {}),
                          CustomCard(
                              icon: Image.asset('assets/default_pic.jpg'),
                              title: "Mess Off",
                              func: () {}),
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
                          CustomCard(
                              icon: Image.asset('assets/default_pic.jpg'),
                              title: "Location",
                              func: () {}),
                          CustomCard(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: screenHeight * 0.08,
                              height: screenHeight * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(75, 237, 147, 189),
                                  borderRadius: BorderRadius.circular(100)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          )
        ],
      ),
    );
  }
}
