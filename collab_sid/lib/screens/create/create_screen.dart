import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:numberpicker/numberpicker.dart';
import '../home/home_screen.dart';

class CreateScreen extends StatefulWidget {
  static final routeName = 'create-screen';
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var dlist = [
    "Python",
    "C++",
    "C",
    "Dart",
    "Flutter",
    "Django",
    "Java",
    "Javascript"
  ];
  String dvalue = "Python";
  DateTime selectedDate;
  var selectedList = [];
  var description = "";
  var title = "";
  List tags = [];
  List requestedNames = [];
  List requestedIds = [];
  List joinedIds = [];
  List joinedNames = [];
  List waitingNames=[];
  //List starredBy=[];
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  int currentValue = 2;
  var currentUser, userData;

  void _submitForm() async {
    if (tags.isEmpty) {
      // Scaffold.of(ctx).showSnackBar(SnackBar(
      //   content: Text("Please Select Some Tags !"),
      //   backgroundColor: kPrimaryColor,
      // ));
      print("Error");
    } else {
      currentUser = FirebaseAuth.instance.currentUser;
      userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      var newDoc =
          await FirebaseFirestore.instance.collection("projects").doc();
      newDoc.set({
        'ownerId': currentUser.uid,
        'title': title,
        'tags': selectedList,
        'members': currentValue,
        'description': description,
        'startDate': DateFormat('MMM yyyy').format(selectedDate),
        'members_enrolled': 0,
        'started_by': userData['name'],
        'requestedNames': requestedNames,
        'joinedNames': joinedNames,
        'requestedIds': requestedIds,
        'joinedIds': joinedIds,
        'waitingNames':waitingNames,
        //'starredBy':starredBy,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('projects')
          .doc(newDoc.id)
          .set({
        'ownerId': currentUser.uid,
        'title': title,
        'tags': selectedList,
        'members': currentValue,
        'description': description,
        'startDate': DateFormat('MMM yyyy').format(selectedDate),
        'members_enrolled': 0,
        'started_by': userData['name'],
        'requestedNames': requestedNames,
        'joinedNames': joinedNames,
        'requestedIds': requestedIds,
        'joinedIds': joinedIds,
        'waitingNames':waitingNames,
        //'starredBy':starredBy,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 20),
        child: TextButton(
            onPressed: () {
              _submitForm();
              Navigator.of(context).pushReplacementNamed(HomeScreen1.routeName);
            },
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white, fontSize: 17),
              textAlign: TextAlign.center,
            )),
        color: kPrimaryColor,
        width: double.infinity,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Idea Name",
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a value !";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Description",
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.black),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Description !";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Members",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              height: 30,
                              child: NumberPicker.integer(
                                scrollDirection: Axis.horizontal,
                                initialValue: currentValue,
                                minValue: 2,
                                maxValue: 6,
                                onChanged: (value) {
                                  setState(() {
                                    currentValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 5,
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            showMonthPicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  DateTime.now().year, DateTime.now().month),
                              lastDate: DateTime(DateTime.now().year + 5),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  selectedDate = date;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                selectedDate == null
                                    ? "Start Date "
                                    : DateFormat('MMM yyyy')
                                        .format(selectedDate),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Icon(Icons.calendar_today_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (tags.isEmpty)
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Please select some tags !",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                if (tags.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    decoration: BoxDecoration(),
                    child: Tags(
                      key: _globalKey,
                      itemCount: tags.length,
                      columns: 6,
                      itemBuilder: (index) {
                        final Item currentItem = tags[index];
                        return ItemTags(
                          index: index,
                          title: currentItem.title,
                          textActiveColor: Colors.black,
                          activeColor: kPrimaryColor,
                          customData: currentItem.customData,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          combine: ItemTagsCombine.withTextBefore,
                          onPressed: (i) => print(i),
                          removeButton: ItemTagsRemoveButton(onRemoved: () {
                            setState(() {
                              tags.removeAt(index);
                              selectedList.remove(currentItem.title.toString());
                            });
                            return true;
                          }),
                        );
                      },
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dvalue,
                      onChanged: (value) {
                        setState(() {
                          dvalue = value;
                          selectedList.add(value);
                          tags.add(Item(
                            title: value,
                          ));
                        });
                      },
                      items:
                          dlist.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
