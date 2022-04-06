import 'package:clicki_eat/Scaffolds/BasePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Components/CustomMealCard.dart';
import '../Singletons/MessOffInformation.dart';
import '../Singletons/User.dart' as MyUser;

Future<int> getMealPrice() async {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Map<String, dynamic> info = (await instance.collection("MealPrice").doc("PricePerMeal").get()).data()!;
  return info["price"] as int;
}

Future<int> getCurrentMonthMessBill() async {
  int result = 0;
  DateTime now = DateTime.now();
  DateTime previousMonthStart;
  if (now.month - 1 < 1) {
    previousMonthStart = DateTime(now.year - 1, 12, 1);
  } else {
    previousMonthStart = DateTime(now.year, now.month - 1, 1);
  }

  DateTime monthStart = DateTime(now.year, now.month, 1);
  print(previousMonthStart);
  print(monthStart);

  Map<String, Map<String, int>> messOffInformation =
      await getMessOffInformation(MyUser.User.instance.getEmailAddress(), previousMonthStart, monthStart);
  print(messOffInformation);

  int mealPrice = await getMealPrice();
  print(mealPrice);
  while (previousMonthStart.isBefore(monthStart)) {
    if (isMealOn(messOffInformation, previousMonthStart, "breakfast")) {
      result += mealPrice;
    }

    if (isMealOn(messOffInformation, previousMonthStart, "lunch")) {
      result += mealPrice;
    }

    if (isMealOn(messOffInformation, previousMonthStart, "dinner")) {
      result += mealPrice;
    }

    previousMonthStart = previousMonthStart.add(Duration(days: 1));
  }

  print(result);
  return result;
}

class MessBillScaffold extends StatefulWidget {
  const MessBillScaffold({Key? key}) : super(key: key);
  static Future<int> currentMonthBill = getCurrentMonthMessBill();

  @override
  _MessBillScaffoldState createState() => _MessBillScaffoldState();
}

class _MessBillScaffoldState extends State<MessBillScaffold> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<int>(
      future: MessBillScaffold.currentMonthBill,
      builder: (builder, snapShot) {
        if (snapShot.hasData) {
          return BasePageScaffold(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: Text(
                      "Mess Bill",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04, left: screenWidth * 0.05),
                    child: Row(
                      children: [
                        Text(
                          "Current Month",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.05),
                    child: Row(
                      children: [
                        Text(
                          "Rs. ${snapShot.data!}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: screenHeight * 0.5),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(50, 0xFF, 0xA6, 0x3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/BinancePay.svg"),
                        label: Text(
                          "Binance",
                          style: TextStyle(
                            color: Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(50, 0xFF, 0xA6, 0x3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/EasyPaisaPay.svg"),
                        label: Text(
                          "Easypaisa",
                          style: TextStyle(
                            color: Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            addons: [],
          );
        } else {
          return BasePageScaffold(
            child: Container(
              width: double.infinity,
              child: Container(
                width: 128,
                height: 128,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            addons: [],
          );
        }
      },
    );
  }
}
