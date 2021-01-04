
import 'package:flutter/material.dart';
import './components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /*final _auth = FirebaseAuth.instance;
  bool loading = false ;
  void _userLogin(String email, String password, BuildContext ctx) async {
    UserCredential authResult;
    try{
       authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen(),));
    }on PlatformException catch(err)
    {
      var message="An error occured";
      if(err.message!=null)
      {
        message=err.message;
        setState(() {
          loading = false;
        });
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text(message)));
    }catch(err)
    {
      print(err);
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text("Invalid Credentials !"), backgroundColor: kPrimaryColor,));
      setState(() {
          loading = false;
        });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(/*_userLogin,loading*/),
    );
  }
}

