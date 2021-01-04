
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../screens/Signup/signup_screen.dart';
import '../../../components/already_have_an_account_check.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './background.dart';
import '../../home/home_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  var _auth = FirebaseAuth.instance;
  void userLogin(String email, String password, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        loading = true;
      });
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
     Navigator.of(context).pushReplacementNamed(HomeScreen1.routeName);
    } on PlatformException catch (err) {
      var message = "An error occured";
      if (err.message != null) {
        message = err.message;
        setState(() {
          loading = false;
        });
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {
      print(err);
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text("Invalid Credentials !"),
        backgroundColor: kPrimaryColor,
      ));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String email, password;

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
            loading
                ? CircularProgressIndicator()
                : RoundedButton(
                    text: "LOGIN",
                    press: () {
                      userLogin(email.trim(), password.trim(), context);
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
