import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Image icon;
  final String title;
  final VoidCallback func;

  CustomCard(
      {Key? key, required this.icon, required this.title, required this.func})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.36,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(32)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(100, 237, 147, 189),
                offset: Offset(1, 2),
                blurRadius: 8)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          splashColor: Color.fromARGB(75, 237, 147, 189),
          onTap: widget.func,
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.icon.image, fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.015),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
