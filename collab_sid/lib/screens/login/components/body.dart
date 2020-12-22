import '../../../screens/Signup/signup_screen.dart';
import '../../../components/already_have_an_account_check.dart';
import '../../../components/rounded_button.dart';
//import '../../../constants.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './background.dart';

class Body extends StatefulWidget {
  Body(this.userLogin);
  final void Function(String email, String password, BuildContext ctx) userLogin ;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    String email,password;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "LOGIN",
              press: () {
                widget.userLogin(email.trim(), password.trim(), context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
