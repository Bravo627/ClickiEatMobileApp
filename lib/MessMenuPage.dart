import 'package:clicki_eat/BasePage.dart';
import 'package:clicki_eat/MessMenu.dart';
import 'package:clicki_eat/MessVote.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

int timeToIndex(String time) {
  return time == "Breakfast"
      ? 0
      : time == "Lunch"
          ? 1
          : time == "Dinner"
              ? 2
              : -1;
}

class MealCard extends StatefulWidget {
  final String time;
  final String day;

  MealCard({Key? key, required this.day, required this.time}) : super(key: key);

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final Future<Map<String, List<String>>> messMenu = MessMenu.instance;
  final Future<Map<String, VoteType>> messVote = castMessVoteFromFirebase(MessVote.instance);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([messMenu, messVote]),
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            Map<String, List<String>> messMenuData = snapshot.data![0] as Map<String, List<String>>;
            Map<String, VoteType> messVoteData = snapshot.data![1] as Map<String, VoteType>;

            return Container(
              padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.05, bottom: screenHeight * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Svg("assets/${this.widget.time}.svg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.375,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.widget.time,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                                  fontSize: 16,
                                ),
                              ),
                              ...messMenuData[this.widget.day]![timeToIndex(this.widget.time)].split(",").map((e) {
                                return Text(
                                  "• ${e.trim()}",
                                  overflow: TextOverflow.ellipsis,
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.3,
                        child: Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                messVoteData[replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)])] = VoteType.LIKE;
                                MessVote.send(castMessVoteToFirebase(messVoteData));

                                setState(() {
                                  MessVote.reset();
                                });
                              },
                              child: Icon(
                                messVoteData.containsKey(replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)]))
                                    ? messVoteData[replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)])] == VoteType.LIKE
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_alt_outlined
                                    : Icons.thumb_up_alt_outlined,
                                color: Colors.black,
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white.withOpacity(0),
                                shape: CircleBorder(),
                                minimumSize: Size(48, 48),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                messVoteData[replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)])] = VoteType.DISLIKE;
                                MessVote.send(castMessVoteToFirebase(messVoteData));

                                setState(() {
                                  MessVote.reset();
                                });
                              },
                              child: Icon(
                                messVoteData.containsKey(replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)]))
                                    ? messVoteData[replaceSpecialCharacterInMealName(messMenuData[this.widget.day]![timeToIndex(this.widget.time)])] == VoteType.DISLIKE
                                        ? Icons.thumb_down
                                        : Icons.thumb_down_alt_outlined
                                    : Icons.thumb_down_alt_outlined,
                                color: Colors.black,
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white.withOpacity(0),
                                shape: CircleBorder(),
                                minimumSize: Size(48, 48),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            if (this.widget.time == "Lunch") {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.2),
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return Container();
            }
          }
        });
  }
}

class MessMenuScaffold extends StatefulWidget {
  final Color highlightedColor = Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A);
  final Color normalColor = Color.fromARGB(0xFF, 0x30, 0x5D, 0x51);

  MessMenuScaffold({Key? key}) : super(key: key);

  @override
  _MessMenuScaffoldState createState() => _MessMenuScaffoldState();
}

class _MessMenuScaffoldState extends State<MessMenuScaffold> {
  String day = "monday";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BasePageScaffold(
      addons: [],
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: Text(
                "Mess Menu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.025, left: screenWidth * 0.1),
              child: Container(
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Monday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "monday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "monday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "monday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Tuesday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "tuesday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "tuesday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "tuesday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Wednesday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "wednesday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "wednesday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "wednesday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Thursday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "thursday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "thursday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "thursday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Friday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "friday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "friday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "friday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Saturday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "saturday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "saturday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "saturday";
                          });
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.005),
                          child: Text(
                            "Sunday",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ((day == "sunday") ? widget.highlightedColor : widget.normalColor),
                              // decoration: ((day == "sunday") ? TextDecoration.underline : TextDecoration.none),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            day = "sunday";
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MealCard(
              day: this.day,
              time: "Breakfast",
            ),
            MealCard(
              day: this.day,
              time: "Lunch",
            ),
            MealCard(
              day: this.day,
              time: "Dinner",
            ),
          ],
        ),
      ),
    );
  }
}
