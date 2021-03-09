import 'package:flutter/material.dart';
import '../../bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsScreen extends StatefulWidget {
  static final routeName = 'notifs-screen';
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var currentUser;
  var userData;
  bool notifs;
  List requestedNames = [];
  List requestedIds = [];
  List waitingNames = [];
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    userData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('projects')
        .doc();
      print("welcome to notifs");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('projects')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
          final userData = streamSnapshot.data;
          return ListView.builder(
              itemCount: userData.docs.length,
              itemBuilder: (ctx, index) {
                final doc = userData.docs[index];
                print(doc['requestedNames']);
                if (doc['requestedNames'].length > 0)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: doc['requestedNames'].length,
                      itemBuilder: (ctx, i) {
                        print("hi");
                        print(doc['requestedNames'][i]);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow[100]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Container(
                                        child: Text(
                                      "${doc['requestedNames'][i].toString()} wants to join ${doc['title']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )),
                                  ),
                                  Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                          onPressed: () async {
                                            requestedNames =
                                                doc['requestedNames'];
                                            requestedNames.remove(
                                                doc['requestedNames'][i]);
                                            requestedIds = doc['requestedIds'];
                                            requestedIds
                                                .remove(doc['requestedIds'][i]);
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(doc['ownerId'])
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'requestedNames': requestedNames,
                                              'requestedIds': requestedIds,
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'requestedNames': requestedNames,
                                              'requestedIds': requestedIds,
                                            });
                                            waitingNames
                                                .add(doc['requestedNames'][i]);
                                            print(doc['title']);
                                            print(waitingNames);
                                            await FirebaseFirestore.instance
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'waitingNames': waitingNames,
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(doc['ownerId'])
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'waitingNames': waitingNames,
                                            });
                                          },
                                          child: Text(
                                            "Accept",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  SizedBox(width: 4),
                                  Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                          onPressed: () async {
                                            //print(doc.id);
                                            requestedNames =
                                                doc['requestedNames'];
                                            requestedNames.remove(
                                                doc['requestedNames'][i]);
                                            requestedIds = doc['requestedIds'];
                                            requestedIds
                                                .remove(doc['requestedIds'][i]);
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(doc['ownerId'])
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'requestedNames': requestedNames,
                                              'requestedIds': requestedIds,
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('projects')
                                                .doc(doc.id)
                                                .update({
                                              'requestedNames': requestedNames,
                                              'requestedIds': requestedIds,
                                            });
                                          },
                                          child: Text(
                                            "Decline",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )))
                                ],
                              )),
                        );
                      });
                else
                  return Container(height: 0);
              });
        },
      ),
      bottomNavigationBar: BottomTabs(3),
    );
  }
}
