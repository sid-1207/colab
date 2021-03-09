import 'package:collab/constants.dart';
import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatefulWidget {
  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
  static final routeName = 'ProjectDetail-screen';
  ProjectDetailScreen(this.doc);
  final doc;
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final doc = widget.doc;
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.doc['title']),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kPrimaryColor,
        child: Container(
            color: kPrimaryColor,
            child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'ENROLL',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ],
                ))),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              color: kPrimaryLightColor,
              child: ListTile(
                title: Text(doc['title'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                subtitle: Text("Started by ${doc['started_by']}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic)),
              ),
            ),
            //Divider(color: Colors.black,),
            Container(
                color: kPrimaryLightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('useremail@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          //fontStyle: FontStyle.italic
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    Text('github/linkedin',
                        style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          color: Colors.black,
                          fontSize: 20,
                          //fontStyle: FontStyle.italic
                        ))
                  ],
                ),
              ),
            // Container(
            //   child: ListTile(
            //     title: Text(
            //       'Title:',
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //     ),
            //     subtitle: Text(
            //       doc['title'],
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 4,
            // ),
            Container(
              child: ListTile(
                title: Text('Members Enrolled:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text('${doc["members_enrolled"]}/${doc["members"]}',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Divider(
              thickness: 4,
            ),
            Container(
              child: ListTile(
                title: Text(
                  'Members:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Member A, Member B, Member C',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(
              thickness: 4,
            ),
            Container(
              child: ListTile(
                title: Text('Description:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle:
                    Text(doc['description'], style: TextStyle(fontSize: 20)),
              ),
            ),
            Divider(
              thickness: 4,
            ),
            Container(
              child: ListTile(
                title: Text('Tags:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text(doc['tags'].join(', '),
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Divider(
              thickness: 4,
            ),
            Container(
              // width: 60.0,
              //padding: EdgeInsets.only(top: 3.0, right: 4.0),
              child: ListTile(
                title: Text('Start Date:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Align(
                    alignment: Alignment.bottomLeft,
                    child:
                        Text(doc['startDate'], style: TextStyle(fontSize: 20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
