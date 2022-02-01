import 'package:clicki_eat/BasePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MessOffScaffold extends StatefulWidget {
  const MessOffScaffold({Key? key}) : super(key: key);

  @override
  _MessOffScaffoldState createState() => _MessOffScaffoldState();
}

class _MessOffScaffoldState extends State<MessOffScaffold> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateTime start = now.add(Duration(days: 3));
    DateTime end = DateTime(now.year, now.month + 1, 0);

    return BasePageScaffold(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: screenHeight * 0.05, bottom: screenHeight * 0.04),
                child: Text(
                  "Mess Off",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  child: TableCalendar(
                    firstDay: start,
                    lastDay: end,
                    focusedDay: start,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    // rowHeight: screenHeight * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
        addons: []);
  }
}
