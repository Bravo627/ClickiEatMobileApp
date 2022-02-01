import 'package:flutter/material.dart';

class BottomHomeIcon extends StatefulWidget {
  final Image icon;
  final String title;
  final VoidCallback func;
  BottomHomeIcon({Key? key, required this.icon, required this.title, required this.func}) : super(key: key);

  @override
  _BottomHomeIconState createState() => _BottomHomeIconState();
}

class _BottomHomeIconState extends State<BottomHomeIcon> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
