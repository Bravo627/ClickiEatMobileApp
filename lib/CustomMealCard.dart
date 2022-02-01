import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class CustomMealCard extends StatefulWidget {
  final String mealTime;
  final DateTime day;
  final Map<String, List<String>> meals;

  CustomMealCard({Key? key, required this.mealTime, required this.day, required this.meals}) : super(key: key);

  @override
  _CustomMealCardState createState() => _CustomMealCardState();
}

class _CustomMealCardState extends State<CustomMealCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> todayMeals = getMessMealFromList(widget.day, widget.meals);

    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        // border: Border.all(color: Colors.black, width: 1,)
        boxShadow: [
          BoxShadow(color: Color.fromARGB(100, 237, 147, 189), offset: Offset(1, 2), blurRadius: 8),
        ],
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
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
