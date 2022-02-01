import 'package:flutter/material.dart';

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
            width: screenHeight * 0.08,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
                color: Color.fromARGB(75, 237, 147, 189),
                borderRadius: BorderRadius.circular(100)),
          )
        ],
      ),
    );
  }
}
