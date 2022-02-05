import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MessOffInformation.dart';

List<String> getMessMealFromList(DateTime currentDay, Map<String, List<String>> meals) {
  int dayOfWeek = currentDay.weekday;

  List<String> result = [];
  switch (dayOfWeek) {
    case 1:
      result = meals["monday"]!;
      break;
    case 2:
      result = meals["tuesday"]!;
      break;
    case 3:
      result = meals["wednesday"]!;
      break;
    case 4:
      result = meals["thursday"]!;
      break;
    case 5:
      result = meals["friday"]!;
      break;
    case 6:
      result = meals["saturday"]!;
      break;
    case 7:
      result = meals["sunday"]!;
      break;
  }

  return result.map((e) {
    return e.trim();
  }).toList();
}

bool isMealOn(Map<String, Map<String, int>> messOffInformation, DateTime date, String meal) {
  String monthsAsString = monthIntToString(date.month);
  if (!messOffInformation.containsKey(monthsAsString)) {
    return true;
  }

  Map<String, int> monthMessOffInformation = messOffInformation[monthsAsString]!;

  String dateAsString = date.toUtc().toString();
  if (!monthMessOffInformation.containsKey(dateAsString)) {
    return true;
  }

  int dayMealInformation = monthMessOffInformation[dateAsString]!;
  switch (meal) {
    case "breakfast":
      return dayMealInformation & 1 != 0;
    case "lunch":
      return dayMealInformation & 2 != 0;
    case "dinner":
      return dayMealInformation & 4 != 0;
  }

  return true;
}

bool isMealsOn(Map<String, Map<String, int>> messOffInformation, List<DateTime> dates, String meal) {
  bool result = true;
  for (DateTime date in dates) {
    result &= isMealOn(messOffInformation, date, meal);
  }

  return result;
}

void updateMealInformation(Map<String, Map<String, int>> messOffInformation, DateTime date, String meal, bool on) {
  String monthsAsString = monthIntToString(date.month);
  String dateAsString = date.toUtc().toString();
  if (!messOffInformation.containsKey(monthsAsString)) {
    Map<String, int> dayInformation = Map();

    int dayInformationInt = 7;
    if (meal == "breakfast") {
      if (!on) {
        dayInformationInt &= ~1;
      }
    } else if (meal == "lunch") {
      if (!on) {
        dayInformationInt &= ~2;
      }
    } else if (meal == "dinner") {
      if (!on) {
        dayInformationInt &= ~4;
      }
    }

    dayInformation[dateAsString] = dayInformationInt;
    messOffInformation[monthsAsString] = dayInformation;
    return;
  }

  Map<String, int> monthMessOffInformation = messOffInformation[monthsAsString]!;
  if (!monthMessOffInformation.containsKey(dateAsString)) {
    int dayInformationInt = 7;
    if (meal == "breakfast") {
      if (!on) {
        dayInformationInt &= ~1;
      }
    } else if (meal == "lunch") {
      if (!on) {
        dayInformationInt &= ~2;
      }
    } else if (meal == "dinner") {
      if (!on) {
        dayInformationInt &= ~4;
      }
    }

    monthMessOffInformation[dateAsString] = dayInformationInt;
    return;
  }

  int dayInformationInt = monthMessOffInformation[dateAsString]!;
  if (meal == "breakfast") {
    if (!on) {
      dayInformationInt &= ~1;
    } else {
      dayInformationInt |= 1;
    }
  } else if (meal == "lunch") {
    if (!on) {
      dayInformationInt &= ~2;
    } else {
      dayInformationInt |= 2;
    }
  } else if (meal == "dinner") {
    if (!on) {
      dayInformationInt &= ~4;
    } else {
      dayInformationInt |= 4;
    }
  }

  monthMessOffInformation[dateAsString] = dayInformationInt;
}

void updateMealsInformation(
    Map<String, Map<String, int>> messOffInformation, List<DateTime> dates, String meal, bool on) {
  for (DateTime date in dates) {
    updateMealInformation(messOffInformation, date, meal, on);
  }
}

class CustomMealCard extends StatefulWidget {
  final String mealTime;
  final List<DateTime> days;
  final Map<String, List<String>> meals;
  final Map<String, Map<String, int>> messOffInformation;

  CustomMealCard(
      {Key? key, required this.mealTime, required this.days, required this.meals, required this.messOffInformation})
      : super(key: key);

  @override
  _CustomMealCardState createState() => _CustomMealCardState();
}

class _CustomMealCardState extends State<CustomMealCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> todayMeals = getMessMealFromList(widget.days[0], widget.meals);

    return Container(
      height: screenHeight * 0.25,
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        // border: Border.all(color: Colors.black, width: 1,)
        // boxShadow: [
        //   BoxShadow(color: Color.fromARGB(100, 237, 147, 189), offset: Offset(1, 2), blurRadius: 8),
        // ],
      ),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.06,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Center(
              child: Text(
                widget.mealTime,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(100, 237, 147, 189), offset: Offset(1, 2), blurRadius: 16, spreadRadius: 2),
              ],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: (widget.days.length == 1)
                    ? Text(
                        (widget.mealTime.toLowerCase() == "breakfast")
                            ? todayMeals[0]
                            : (widget.mealTime.toLowerCase() == "lunch")
                                ? todayMeals[1]
                                : (widget.mealTime.toLowerCase() == "dinner")
                                    ? todayMeals[2]
                                    : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    : Text(
                        "Multiple Days Selected",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
          ),
          ((isMealsOn(widget.messOffInformation, widget.days, widget.mealTime.toLowerCase()))
              ? Container(
                  height: screenHeight * 0.05,
                  child: InkWell(
                    onTap: () {
                      updateMealsInformation(
                          widget.messOffInformation, widget.days, widget.mealTime.toLowerCase(), false);
                      setState(() {});
                    },
                    splashColor: Colors.pinkAccent,
                    child: Icon(
                      Icons.remove_circle,
                      size: screenHeight * 0.04,
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              : Container(
                  height: screenHeight * 0.05,
                  child: InkWell(
                    onTap: () {
                      updateMealsInformation(
                          widget.messOffInformation, widget.days, widget.mealTime.toLowerCase(), true);
                      setState(() {});
                    },
                    splashColor: Colors.pinkAccent,
                    child: Icon(
                      Icons.add_circle,
                      size: screenHeight * 0.04,
                      color: Colors.deepPurple,
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
