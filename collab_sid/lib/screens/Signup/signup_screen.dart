import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Profile/profile_form.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  void _buildUser(String email, String password,String name,BuildContext ctx) async {
    UserCredential authResult;
    try{
       authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
          'name':name,
          'email':email,
          'password':password,
         
        });
        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).collection('profile').doc(authResult.user.uid).set({
          'name':'Not set',
          'bio':'Not set',
          'gender':'Not set',
          'dateofbirth':'Not set',
          'institution':'Not set',
          'degree':'Not set',
          'skills':'Not set'
        });
        Navigator.of(context).pushReplacementNamed(ProfileFormScreen.routeName);
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
