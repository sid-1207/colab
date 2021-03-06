import 'screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/Profile/profile_form.dart';
import './screens/home/home_screen.dart';
import './screens/create/create_screen.dart';
import './screens/Forum/forum_screen.dart';
import './screens/Notifications/notifs_screen.dart';
import './screens/Profile/view_profile.dart';
import './screens/Explore/explore_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collab',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        HomeScreen1.routeName: (ctx) => HomeScreen1(),
        ProfileFormScreen.routeName: (ctx) => ProfileFormScreen(),
        CreateScreen.routeName: (ctx) => CreateScreen(),
        ForumScreen.routeName: (ctx) => ForumScreen(),
        NotificationsScreen.routeName: (ctx) => NotificationsScreen(),
        ViewProfileScreen.routeName: (ctx) => ViewProfileScreen(),
        ExploreScreen.routeName: (ctx) => ExploreScreen(),
      },
    );
  }
}
