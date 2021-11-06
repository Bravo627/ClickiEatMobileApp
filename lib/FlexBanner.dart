import 'package:flutter/material.dart';

class FlexBanner extends StatelessWidget {
  const FlexBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        color: Colors.pinkAccent,
      ),
      child: Stack(
        children: [
          // Placeholder(color: Colors.teal,),
          Center(
            child: CircleAvatar(

            ),
          ),
        ],
      ),
    );
  }
}
