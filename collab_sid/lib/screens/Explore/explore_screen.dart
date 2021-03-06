
import 'package:flutter/material.dart';
import '../home/components/search_list.dart';
import '../../constants.dart';
import '../../bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ProjectDetail/project_detail_screen.dart';
class ExploreScreen extends StatefulWidget{
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
  static final routeName = 'Explore-Screen';
}

class _ExploreScreenState extends State<ExploreScreen> with TickerProviderStateMixin{ 
    var userData;
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
    
        final userData = streamSnapshot.data;
        return ListView.builder(
            itemCount: userData.docs.length,
            itemBuilder: (ctx, index) {
              final doc = userData.docs[index];
              //print(doc["title"]);
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
                         onTap: (){
                           return Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => ProjectDetailScreen(userData.docs[index])
                      ));
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
                            Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 36,
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
                                      width: MediaQuery.of(context).size.width *
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  doc["tags"].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      Scaffold.of(ctx).showSnackBar(SnackBar(
                                        content:
                                            Container(height:20,child: Center(child: Text("Request Sent to the Owner !",style: TextStyle(color: Colors.white),))),
                                        backgroundColor: Colors.black,
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "JOIN",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ))
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
