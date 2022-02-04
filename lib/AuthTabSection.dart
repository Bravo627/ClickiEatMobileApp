import 'package:clicki_eat/Hostels.dart';
import 'package:flutter/material.dart';

class HostelListButton extends StatefulWidget {
  final TextEditingController controller;
  final List<String> hostelsName;

  const HostelListButton(
      {Key? key, required this.controller, required this.hostelsName})
      : super(key: key);

  @override
  State<HostelListButton> createState() => _HostelListButtonState();
}

class _HostelListButtonState extends State<HostelListButton> {
  late String selectedHostelName;

  @override
  void initState() {
    super.initState();
    selectedHostelName = widget.hostelsName.first;
    widget.controller.text = widget.hostelsName.first;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return DropdownButtonFormField(
      value: selectedHostelName,
      decoration: InputDecoration(
        labelText: "Hostel",
      ),
      items: widget.hostelsName.map((e) {
        return DropdownMenuItem(
          child: Text(
            e,
            style: TextStyle(color: Colors.black),
          ),
          value: e,
        );
      }).toList(),
      menuMaxHeight: screenHeight * 0.6,
      isExpanded: true,
      onChanged: (String? value) {
        if (value != null) {
          widget.controller.text = value;

          setState(() {
            selectedHostelName = value;
          });
        }
      },
    );
  }
}

class AuthTabSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController hostelsController;
  final bool isLoginMode;
  final VoidCallback? onPress;

  const AuthTabSection({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.hostelsController,
    required this.isLoginMode,
    required this.onPress,
  }) : super(key: key);

  @override
  State<AuthTabSection> createState() => _AuthTabSectionState();
}

class _AuthTabSectionState extends State<AuthTabSection>
    with AutomaticKeepAliveClientMixin<AuthTabSection> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (!widget.isLoginMode)
          ?
          TextFormField(
            controller: widget.nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                labelText: 'Name'),
            textCapitalization: TextCapitalization.words,
            autocorrect: false,
          )
          : Container(),
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                labelText: 'Email Address'),
          ),
          TextFormField(
            controller: widget.passwordController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                labelText: 'Password'),
            obscureText: true,
          ),
          (!widget.isLoginMode)
              ? FutureBuilder<List<String>>(
                  future: getHostelsName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: screenHeight * 0.1,
                        child: HostelListButton(
                          controller: widget.hostelsController,
                          hostelsName: snapshot.data!,
                        ),
                      );
                    } else {
                      return Container(
                        height: screenHeight * 0.1,
                        child: Center(child: CircularProgressIndicator.adaptive()),
                      );
                    }
                  },
                )
              : Container(
                  height: screenHeight * 0.1,
                ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              minimumSize: Size(double.infinity, 48),
            ),
            onPressed: widget.onPress,
            child: Text(
              widget.isLoginMode ? "Log In" : "Sign Up",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
