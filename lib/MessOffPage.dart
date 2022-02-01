import 'package:clicki_eat/BasePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'CustomMealCard.dart';
import 'MessMenu.dart';

class MessOffScaffold extends StatefulWidget {
  static bool isFirst = true;
  static Future<Map<String, List<String>>>? futureMessMenu;
  MessOffScaffold({Key? key}) : super(key: key);

  @override
  _MessOffScaffoldState createState() => _MessOffScaffoldState();
}

class _MessOffScaffoldState extends State<MessOffScaffold> {
  late List<DateTime> datesSelected;
  late DateTime now;
  late DateTime start;
  late DateTime end;

  @override
  void initState() {
    super.initState();

    datesSelected = [];
    now = DateTime.now();
    start = now.add(Duration(days: 3));
    end = DateTime(now.year, now.month + 1, 0);

    datesSelected.add(start);

    if (MessOffScaffold.isFirst) {
      MessOffScaffold.futureMessMenu = getMessMenu();
      MessOffScaffold.isFirst = false;
    }
  }


  @override
  void dispose() {
    datesSelected.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        datesSelected = [
                          selectedDay
                        ];
                      });
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(day, datesSelected[0]);
                    },
                    // rowHeight: screenHeight * 0.05,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: FutureBuilder<Map<String, List<String>>>(
                  future: MessOffScaffold.futureMessMenu,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomMealCard(mealTime: "Breakfast", day: datesSelected[0], meals: snapshot.data!),
                          CustomMealCard(mealTime: "Lunch", day: datesSelected[0], meals: snapshot.data!),
                          CustomMealCard(mealTime: "Dinner", day: datesSelected[0], meals: snapshot.data!),
                        ],
                      );
                    } else {
                      return Container(
                        height: screenHeight * 0.1,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        addons: []);
  }
}
