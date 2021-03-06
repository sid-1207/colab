import 'package:flutter/material.dart';
import '../../bottom.dart';

class NotificationsScreen extends StatefulWidget {
  static final routeName = 'notifs-screen';
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("YOU HAVE A NEW NOTIFICATION")),
      ),
      bottomNavigationBar: BottomTabs(3),
    );
  }
}
