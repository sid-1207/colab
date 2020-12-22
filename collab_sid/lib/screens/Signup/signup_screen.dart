import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  void _buildUser(String email, String password,BuildContext ctx) async {
    UserCredential authResult;
    try{
       authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    }on PlatformException catch(err)
    {
      var message="An error occured";
      if(err.message!=null)
      {
        message=err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text(message)));
    }catch(err)
    {
      print(err);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_buildUser),
    );
  }
}
