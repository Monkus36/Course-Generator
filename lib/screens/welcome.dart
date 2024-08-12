// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:curriculi/components/rounded_button.dart';
import 'package:curriculi/screens/login.dart';
import 'package:curriculi/screens/registration.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191825),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/reflect.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'Course Generator',
                  style: TextStyle(
                    color: Color(0xff865DFF),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                text: 'Log In',
                color: Color(0xff4A249D),
                action: () {
                  print("login pressed");
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                text: 'Register',
                color: Color(0xff7C00FE),
                action: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
