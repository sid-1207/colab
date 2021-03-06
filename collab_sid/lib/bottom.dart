import 'package:flutter/material.dart';
import './constants.dart';
import './screens/Forum/forum_screen.dart';
import './screens/home/home_screen.dart';
import './screens/Notifications/notifs_screen.dart';
import './screens/Explore/explore_screen.dart';
import './screens/Profile/view_profile.dart';
class BottomTabs extends StatefulWidget {
     int currentIndex=2 ;
  BottomTabs(this.currentIndex);
  @override
  _BottomTabsState createState() => _BottomTabsState();

}

class _BottomTabsState extends State<BottomTabs> {
 
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      items: [
        BottomNavigationBarItem(
          label: "Forum",
          icon: Icon(Icons.forum),
          backgroundColor: kPrimaryColor,
        ),
        BottomNavigationBarItem(
          label:"Explore",
          icon: Icon(Icons.explore),
          backgroundColor: kPrimaryColor,
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
          backgroundColor: kPrimaryColor,
        ),
        BottomNavigationBarItem(
          label: "Notifications",
          icon: Icon(Icons.notifications),
          backgroundColor: kPrimaryColor,
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person),
          backgroundColor: kPrimaryColor,
        )
      ],
      onTap: (index) {
        setState(() {
          widget.currentIndex = index;
        });
        switch (widget.currentIndex) {
          case 0:
            setState(() {
              Navigator.of(context).pushReplacementNamed(ForumScreen.routeName);
            });
            break;
          case 1:
           setState(() {
              Navigator.of(context).pushReplacementNamed(ExploreScreen.routeName);
            });
          break;
          case 2:
          print("here");
          setState(() {
              Navigator.of(context).pushReplacementNamed(HomeScreen1.routeName);
            });
            break;
          
          case 3:
          setState(() {
              Navigator.of(context).pushReplacementNamed(NotificationsScreen.routeName);
            });
            break;
          case 4:
          setState(() {
              Navigator.of(context).pushReplacementNamed(ViewProfileScreen.routeName);
            });
            break;
        }
      },
    );
  }
}
