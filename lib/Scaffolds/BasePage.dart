import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasePageScaffold extends StatefulWidget {
  final Widget child;
  final List<Widget> addons;
  final bool isGradient;

  const BasePageScaffold({Key? key, required this.child, required this.addons, this.isGradient = false})
      : super(key: key);

  @override
  _BasePageScaffoldState createState() => _BasePageScaffoldState();
}

class _BasePageScaffoldState extends State<BasePageScaffold> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    late Padding ourPadding;
    if (widget.isGradient) {
      ourPadding = Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.1),
        child: Container(
          height: screenHeight * 0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [
              0.4,
              0.9,
            ], colors: [
              Colors.white,
              Color.fromARGB(75, 237, 147, 189),
            ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: widget.child,
        ),
      );
    } else {
      ourPadding = Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.1),
        child: Container(
          height: screenHeight * 0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [
              0.4,
              0.9,
            ], colors: [
              Colors.white,
              Colors.white,
            ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: widget.child,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/BackgroundIllustration.svg",
              fit: BoxFit.fill,
            ),
            ourPadding,
            ...widget.addons
          ],
        ),
      ),
    );
  }
}
