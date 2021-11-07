import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      ),
      child: Stack(
        children: [
          SvgPicture.asset("assets/BackgroundIllustration.svg", fit: BoxFit.fill,),
          Center(
            child: SvgPicture.asset("assets/HomepageLogo.svg"),
          ),
        ],
      ),
    );
  }
}
