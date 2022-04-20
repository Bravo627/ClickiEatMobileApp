import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'User.dart';

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

  static void updateCollectively(Map<String, bool> data) async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    data = data.map((String key, bool value) {
      return MapEntry(replaceSpecialCharacterInMealName(key), value);
    });

    Map<String, dynamic> dataSnapshot = (await instance.collection("MessVoteCollectively").doc("collection").get()).data()!;
    Map<String, List<int>> collectiveData = dataSnapshot.map((String key, dynamic value) {
      return MapEntry(replaceSpecialCharacterInMealName(key), (value as List<dynamic>).map((e) { return e as int; }).toList());
    });

    for (MapEntry<String, bool> entry in data.entries) {
      if (!collectiveData.containsKey(replaceSpecialCharacterInMealName(entry.key))) {
        collectiveData[replaceSpecialCharacterInMealName(entry.key)] = [0, 0];
      }

      if (entry.value) {
        collectiveData[replaceSpecialCharacterInMealName(entry.key)]![0]++;
      } else {
        collectiveData[replaceSpecialCharacterInMealName(entry.key)]![1]++;
      }
    }

    await instance.collection("MessVoteCollectively").doc("collection").update(collectiveData);
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
