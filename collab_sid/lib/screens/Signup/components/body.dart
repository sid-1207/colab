import 'package:collab/components/already_have_an_account_check.dart';
import 'package:collab/components/rounded_button.dart';
import 'package:collab/components/rounded_input_field.dart';
import 'package:collab/components/rounded_password_field.dart';
import 'package:collab/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './background.dart';

class Body extends StatefulWidget {
  Body(this.buildUser);
  final void Function(String email, String password, BuildContext ctx)
      buildUser;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please enter valid email address';
                }
                return null;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
                if (value.isEmpty || value.length < 7) {
                  return 'Please enter valid Password';
                }
                return null;
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                widget.buildUser(email.trim(), password.trim(), context);
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
