import 'package:clicki_eat/Scaffolds/FeedbackPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomHomeIcon extends StatefulWidget {
  BottomHomeIcon({Key? key}) : super(key: key);

  @override
  _BottomHomeIconState createState() => _BottomHomeIconState();
}

class _BottomHomeIconState extends State<BottomHomeIcon> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: screenWidth * 0.125,
          height: screenHeight * 0.066,
          child: InkWell(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: SvgPicture.asset("assets/HomeIcon.svg", height: screenHeight * 0.04,),
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ),
        Container(
          width: screenWidth * 0.125,
          height: screenHeight * 0.066,
          child: InkWell(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: SvgPicture.asset("assets/FeedbackIcon.svg", height: screenHeight * 0.04,),
                ),
                Text(
                  "Feedback",
                  style: TextStyle(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FeedbackScaffold();
              }));
            },
          ),
        ),
      ],
    );
  }
}
