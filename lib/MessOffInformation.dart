import 'package:cloud_firestore/cloud_firestore.dart';

String monthIntToString(int month) {
  switch (month) {
    case 01:
      return "january";
    case 02:
      return "february";
    case 03:
      return "march";
    case 04:
      return "april";
    case 05:
      return "may";
    case 06:
      return "june";
    case 07:
      return "july";
    case 08:
      return "august";
    case 09:
      return "september";
    case 10:
      return "october";
    case 11:
      return "november";
    case 12:
      return "december";
  }

  return "";
}

Future<Map<String, Map<String, int>>> getMessOffInformation(String userEmail, DateTime startDay, DateTime endDay) async {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> yearSnapshot =
    (await instance.collection("MessOff").doc(userEmail).collection(startDay.year.toString()).get());

  List<String> monthsToGet = List.empty(growable: true);

  monthsToGet.add(monthIntToString(startDay.month));
  if (startDay.month != endDay.month)
    monthsToGet.add(monthIntToString(endDay.month));

  Map<String, Map<String, int>> result = Map<String, Map<String, int>>();
  for (var innerSnapshot in yearSnapshot.docs) {
    Map<String, dynamic> data = innerSnapshot.data();
    Map<String, int> mappedData = data.map((key, value) {
      return MapEntry(key, value as int);
    });

    if (monthsToGet.contains(innerSnapshot.id)) {
      result[innerSnapshot.id] = mappedData;
    }
  }

  return result;
}
