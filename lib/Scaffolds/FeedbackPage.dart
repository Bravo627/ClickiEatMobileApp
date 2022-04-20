import 'package:clicki_eat/Scaffolds/BasePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Singletons/User.dart';

class FeedbackScaffold extends StatefulWidget {
  const FeedbackScaffold({Key? key}) : super(key: key);

  @override
  _FeedbackScaffoldState createState() => _FeedbackScaffoldState();
}

class _FeedbackScaffoldState extends State<FeedbackScaffold> {
  TextEditingController _controller = TextEditingController();
  bool _switchValue = false;

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
                  "Feedback",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0xFF, 0x30, 0x5D, 0x51),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          minLines: 16,
                          maxLines: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Anonymous"),
                                Switch(
                                  value: _switchValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _switchValue = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(0xFF, 0xFF, 0xA6, 0x3A),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            minimumSize: Size(double.infinity, 48),
                          ),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
                                FirebaseFirestore.instance.collection("Feedbacks").doc("feedbacks").set({
                                  "updated": DateTime.now().toUtc().toString(),
                                });

                                String message = _controller.text;
                                _controller.text = "";

                                transaction.set(
                                  FirebaseFirestore.instance
                                      .collection("Feedbacks")
                                      .doc("feedbacks")
                                      .collection("Feedbacks")
                                      .doc(DateTime.now().toUtc().toString()),
                                  {
                                    "from": _switchValue ? "" : User.user.getEmailAddress(),
                                    "name": _switchValue ? "" : User.user.getName(),
                                    "message": message,
                                    "timestamp": DateTime.now().toUtc().toString(),
                                  },
                                );
                              }).then((value) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Feedback sent successfully"),
                                  ),
                                );
                                _controller.text = "";
                              });
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        addons: []);
  }
}
