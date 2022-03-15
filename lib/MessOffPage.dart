import 'package:clicki_eat/BasePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

import 'CustomMealCard.dart';
import 'MessMenu.dart';
import 'MessOffInformation.dart';
import 'User.dart' as MyUser;

class MessOffScaffold extends StatefulWidget {
  static bool isFirst = true;
  static Future<Map<String, List<String>>>? futureMessMenu;
  static Map<String, Map<String, int>>? messOffInformation;
  static Future<Map<String, Map<String, int>>>? futureMessOffInformation;

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
    end = DateTime(now.year, now.month + 2, 0);

    datesSelected.add(start);

    if (MessOffScaffold.isFirst) {
      MessOffScaffold.futureMessMenu = MessMenu.instance;
      MessOffScaffold.futureMessOffInformation =
          getMessOffInformation(MyUser.User.instance.getEmailAddress(), start, end);
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
                padding: EdgeInsets.only(top: screenHeight * 0.04),
                child: Text(
                  "Mess Off",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
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
                    focusedDay: datesSelected.last,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        datesSelected = [selectedDay];
                      });
                    },
                    onRangeSelected: (startDay, endDay, focusedDay) {
                      HapticFeedback.vibrate();
                      if (startDay == null || endDay == null) {
                        return;
                      }

                      if (startDay.isAfter(endDay)) {
                        DateTime temp = startDay;
                        startDay = endDay;
                        endDay = temp;
                      }

                      datesSelected.clear();
                      DateTime day = startDay;
                      while (day.isBefore(endDay) || day.isAtSameMomentAs(endDay)) {
                        datesSelected.add(day);
                        day = day.add(Duration(days: 1));
                      }

                      print(datesSelected);
                      setState(() {});
                    },
                    selectedDayPredicate: (day) {
                      for (DateTime loopDay in datesSelected) {
                        if (isSameDay(day, loopDay)) return true;
                      }

                      return false;
                    },
                    rangeSelectionMode: RangeSelectionMode.toggledOff,
                    // rowHeight: screenHeight * 0.05,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: FutureBuilder<List<dynamic>>(
                  future: Future.wait([MessOffScaffold.futureMessMenu!, MessOffScaffold.futureMessOffInformation!]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (MessOffScaffold.messOffInformation == null) {
                        MessOffScaffold.messOffInformation = snapshot.data![1]! as Map<String, Map<String, int>>;
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomMealCard(
                                mealTime: "Breakfast",
                                days: datesSelected,
                                meals: snapshot.data![0]! as Map<String, List<String>>,
                                messOffInformation: MessOffScaffold.messOffInformation!,
                              ),
                              CustomMealCard(
                                mealTime: "Lunch",
                                days: datesSelected,
                                meals: snapshot.data![0]! as Map<String, List<String>>,
                                messOffInformation: MessOffScaffold.messOffInformation!,
                              ),
                              CustomMealCard(
                                mealTime: "Dinner",
                                days: datesSelected,
                                meals: snapshot.data![0]! as Map<String, List<String>>,
                                messOffInformation: MessOffScaffold.messOffInformation!,
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A),
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                minimumSize: Size(double.infinity, 48),
                              ),
                              onPressed: () {
                                setMessOffInformation(MyUser.User.user.getEmailAddress(), start, end, MessOffScaffold.messOffInformation!);
                              },
                              child: Text(
                                "Submit...",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.1),
                        child: CircularProgressIndicator.adaptive(),
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
