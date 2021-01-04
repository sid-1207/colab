import 'package:flutter/material.dart';
import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final plist = [
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
    {
      "title": "Flutter Project",
      "tags": ["Dart", "Flutter", "Apps"],
      "members_req": 5,
      "members": 2,
      "desc":
          "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. ",
      "creator": "Samkit",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: kPrimaryLightColor),//Colors.grey[300]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(plist[index]["title"], style: TextStyle(color: textColor),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plist[index]["tags"].toString(),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                              "Members : ${plist[index]["members"]}/${plist[index]["members_req"]}",
                              style: TextStyle(color: textColor),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "${plist[index]["desc"]}",
                            style: TextStyle(color: textColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Started by - ${plist[index]["creator"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
        ),
        itemCount: plist.length,
      );
  }
}
