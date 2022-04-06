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

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: screenHeight * 0.04,
            height: screenHeight * 0.04,
            child: InkWell(
              child: SvgPicture.asset("assets/HomeIcon.svg"),
              onTap: () {},
            ),
          ),
          Container(
            width: screenHeight * 0.04,
            height: screenHeight * 0.04,
            child: InkWell(
              child: SvgPicture.asset("assets/LocationIcon.svg"),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
