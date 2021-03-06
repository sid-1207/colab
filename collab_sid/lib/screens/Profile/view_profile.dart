import 'package:flutter/material.dart';
import '../../bottom.dart';
class ViewProfileScreen extends StatefulWidget {
  static final routeName='view-profile';
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child:Text("PROFILE")),
      ),
bottomNavigationBar: BottomTabs(4),
    );
  }
}
