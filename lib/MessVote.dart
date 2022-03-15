import 'package:clicki_eat/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

String replaceSpecialCharacterInMealName(String mealName) {
  return mealName.replaceAll(RegExp(r"[^\w\s]+"), "");
}

class MessVote {
  static Map<String, bool>? _instance;

  static Future<Map<String, bool>> _getMessVote() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;

    Map<String, dynamic> result = (await instance.collection("MessVote").doc(User.instance.getEmailAddress()).get()).data()!;
    return result.map((String key, dynamic value) => MapEntry<String, bool>(key, value as bool));
  }

  static Future<Map<String, bool>> get instance async {
    if (_instance == null) {
      _instance = await _getMessVote();
      return _instance!;
    }

    return _instance!;
  }

  static void reset() {
    _instance = null;
  }

  static void send(Map<String, bool> data) async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    data = data.map((String key, bool value) {
      return MapEntry(replaceSpecialCharacterInMealName(key), value);
    });
    await instance.collection("MessVote").doc(User.instance.getEmailAddress()).update(data);
  }
}

enum VoteType {
  LIKE, DISLIKE, NONE
}

Future<Map<String, VoteType>> castMessVoteFromFirebase(Future<Map<String, bool>> firebaseDataFuture) async {
  Map<String, bool> firebaseData = await firebaseDataFuture;

  Map<String, VoteType> messVoteData = firebaseData.map((key, value) {
    if (value) {
      return MapEntry(key, VoteType.LIKE);
    } else {
      return MapEntry(key, VoteType.DISLIKE);
    }
  });

  return messVoteData;
}

Map<String, bool> castMessVoteToFirebase(Map<String, VoteType> ourData) {
  ourData.keys.where((element) => ourData[element] == VoteType.NONE).toList().forEach((element) => ourData.remove);

  return ourData.map((key, value) {
    if (value == VoteType.LIKE) {
      return MapEntry(key, true);
    }

    return MapEntry(key, false);
  });
}
