import 'package:flutter/material.dart';
import '../home/components/search_list.dart';
import '../../constants.dart';
import '../../bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ProjectDetail/project_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
  static final routeName = 'Explore-Screen';
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  var currentUser = FirebaseAuth.instance.currentUser;
  List requestedNames = [];
  List requestedIds = [];
  List starred = [];
  List pending = [];
  var userData1, starLogo = Icons.star_border;
  // showOverlay(BuildContext context) {
  //   OverlayState overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry = OverlayEntry(
  //       builder: (context) => Positioned(
  //             bottom:24,
  //             right:96,
  //             child: CircleAvatar(
  //               radius: 10,
  //               backgroundColor: Colors.red,
  //             ),
  //           ));
  //           overlayState.insert(overlayEntry);
  // }
  IconData getLogo(var doc, List starred) {
    //print(userData['starred']);
    //print(doc.id);
    if (starred.contains(doc.id))
      return Icons.star;
    else
      return Icons.star_border;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Projects"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.filter_alt_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects').snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
          //print(starred.length);

          // for (int i = 0; i < userData.docs.length; i++) {
          //   starred.add(false);
          //   pending.add(false);
          //   if (starred.length > userData.docs.length)
          //     starred.removeRange(userData.docs.length, starred.length);
          //    if (pending.length > userData.docs.length)
          //     pending.removeRange(userData.docs.length, pending.length);
          // }
          // print(starred);
          // print(pending);
          final userData = streamSnapshot.data;
          return ListView.builder(
              itemCount: userData.docs.length,
              itemBuilder: (ctx, index) {
                final doc = userData.docs[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    width: 6,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700]),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: () async {
                            userData1 =
                                await FirebaseFirestore //The user who is willing to join
                                    .instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .get();
                            //print(currentUser.uid);
                            if (doc['waitingNames']
                                .contains(userData1['name'])) {
                              return Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (builder) => ProjectDetailScreen(
                                          userData.docs[index])));
                            } else {
                              ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                content: Container(
                                    height: 20,
                                    child: Center(
                                        child: Text(
                                      "You aren't allowed to View this project!",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                                backgroundColor: Colors.black,
                              ));
                            }
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                doc["title"],
                                //plist[index]["title"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  userData1 =
                                      await FirebaseFirestore //The user who is willing to join
                                          .instance
                                          .collection('users')
                                          .doc(currentUser.uid)
                                          .collection('profile')
                                          .doc(currentUser.uid)
                                          .get();
                                  starred = userData1['starred'];
                                  if (starred.contains(doc.id)) {
                                    starred.remove(doc.id);
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .collection('profile')
                                        .doc(currentUser.uid)
                                        .update({'starred': starred});
                                    // setState(() {
                                    //   starLogo = Icons.star_border;
                                    // });
                                  } else {
                                    starred.add(doc.id);
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .collection('profile')
                                        .doc(currentUser.uid)
                                        .update({'starred': starred});
                                    // setState(() {
                                    //   starLogo = Icons.star;
                                    // });
                                  }
                                  setState(() {
                                    print("set");
                                    starLogo=getLogo(doc, starred);
                                    print(starLogo);
                                  });
                                },
                                child: Icon(
                                  starLogo,
                                  color: Colors.yellow,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Owner -",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: kPrimaryColor),
                                  ),
                                  Text(
                                    " ${doc["started_by"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Divider(thickness: 2, color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      "Members : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: kPrimaryColor),
                                    ),
                                    Text(
                                      "${doc["members_enrolled"]}/${doc["members"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    Row(
                                      children: [
                                        Text(
                                          "Starting: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.grey[700]),
                                        ),
                                        Text(
                                          "${doc["startDate"]} ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "${doc["description"]}",
                                  style:
                                      TextStyle(fontSize: 18, color: textColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    doc["tags"].toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      ScaffoldMessenger.of(ctx)
                                          .showSnackBar(SnackBar(
                                        content: Container(
                                            height: 20,
                                            child: Center(
                                                child: Text(
                                              "Request Sent to the Owner !",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                        backgroundColor: Colors.black,
                                      ));
                                      currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      userData1 =
                                          await FirebaseFirestore //The user who is willing to join
                                              .instance
                                              .collection('users')
                                              .doc(currentUser.uid)
                                              .get();
                                      requestedNames = doc['requestedNames'];
                                      requestedNames.add(userData1['name']);
                                      requestedIds = doc['requestedIds'];
                                      requestedIds.add(userData1.id);
                                      //print(userData1['name']);
                                      //print(userData1.id);
                                      await FirebaseFirestore.instance
                                          .collection('projects')
                                          .doc(doc.id)
                                          .update({
                                        'requestedNames': requestedNames,
                                        'requestedIds': requestedIds,
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(doc['ownerId'])
                                          .collection('projects')
                                          .doc(doc.id)
                                          .update({
                                        'requestedNames': requestedNames,
                                        'requestedIds': requestedIds,
                                      });

                                      //} else {
                                      //   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                      //     content: Container(
                                      //         height: 20,
                                      //         child: Center(
                                      //             child: Text(
                                      //           "Request Withdrawn!",
                                      //           style: TextStyle(
                                      //               color: Colors.white),
                                      //         ))),
                                      //     backgroundColor: Colors.black,
                                      //   ));
                                      //   currentUser =
                                      //       FirebaseAuth.instance.currentUser;
                                      //   userData1 =
                                      //       await FirebaseFirestore //The user who is willing to join
                                      //           .instance
                                      //           .collection('users')
                                      //           .doc(currentUser.uid)
                                      //           .get();
                                      //   requestedNames = doc['requestedNames'];
                                      //   requestedNames
                                      //       .remove(userData1['name']);
                                      //   requestedIds = doc['requestedIds'];
                                      //   requestedIds.remove(userData1.id);
                                      //   //print(userData1['name']);
                                      //   //print(userData1.id);
                                      //   await FirebaseFirestore.instance
                                      //       .collection('projects')
                                      //       .doc(doc.id)
                                      //       .update({
                                      //     'requestedNames': requestedNames,
                                      //     'requestedIds': requestedIds,
                                      //   });
                                      //   await FirebaseFirestore.instance
                                      //       .collection('users')
                                      //       .doc(doc['ownerId'])
                                      //       .collection('projects')
                                      //       .doc(doc.id)
                                      //       .update({
                                      //     'requestedNames': requestedNames,
                                      //     'requestedIds': requestedIds,
                                      //   });
                                      //   await FirebaseFirestore.instance
                                      //       .collection('users')
                                      //       .doc(doc['ownerId'])
                                      //       .collection('projects')
                                      //       .doc(doc.id)
                                      //       .update({
                                      //     'requestedNames': requestedNames,
                                      //     'requestedIds': requestedIds,
                                      //   });
                                      // }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "REQUEST",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      bottomNavigationBar: BottomTabs(1),
    );
  }
}
