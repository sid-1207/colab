import 'package:flutter/material.dart';
import '../../bottom.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
  static final routeName = 'forum-screen';
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Welcome to Forum")),
      ),
      bottomNavigationBar: BottomTabs(0),
    );
  }
}
