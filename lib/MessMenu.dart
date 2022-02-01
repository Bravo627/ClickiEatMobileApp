import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, List<String>>> getMessMenu() async {
  final List<String> weekDaysName = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];

  FirebaseFirestore instance = FirebaseFirestore.instance;

  Map<String, List<String>> result = Map<String, List<String>>();
  for (String dayName in weekDaysName)
  {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await instance.collection("MessMenu").doc(dayName).get();
    dynamic mealsDynamic = snapshot.get("meals");
    List<String> mealsArray = (mealsDynamic as List).map((e) => (e.toString())).toList();
    result[dayName] = mealsArray;
  }

  return result;
}
