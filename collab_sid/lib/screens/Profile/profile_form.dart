import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFormScreen extends StatefulWidget {
  static final routeName = 'profile-form';
  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  var chosenGender;
  var _datetime;
  var selectedGender;
  List tags = [];
  List starred=[];
  var bio, name, dob, institution, degree;

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  PickedFile image;
  var currentUser, userData;
  final picker = ImagePicker();
  void selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Build Your Profile"),
        actions: [
          IconButton(
              iconSize: 30,
              color: Colors.white,
              icon: Icon(Icons.check),
              onPressed: () async {
                currentUser = FirebaseAuth.instance.currentUser;
                userData = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .get();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .collection('profile')
                    .doc(currentUser.uid)
                    .update({
                  'bio': bio,
                  'name': name,
                  'gender': chosenGender,
                  'dateofbirth': _datetime,
                  'degree': degree,
                  'institution': institution,
                  'starred':starred,
                });
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .update({
                  'name': name,
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    child: IconButton(
                        icon: Icon(image == null ? Icons.camera_alt : image,
                            color: Colors.white, size: 35),
                        onPressed: selectImage),
                    radius: 45,
                  ),
                  SizedBox(width: 5),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (value) {
                        bio = value;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Something About Yourself',
                          labelStyle:
                              TextStyle(color: Colors.black45, letterSpacing: 4)
                          //labelStyle: TextStyle(color: Colors.black45)
                          ),
                    ),
                  ),
                ],
              ),
              ExpansionCard(
                onExpansionChanged: (v) async {
                  currentUser = FirebaseAuth.instance.currentUser;
                  userData = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser.uid)
                      .get();
                  setState(() {
                    name = userData['name'];
                  });
                },
                leading: Text(
                  "Personal Details ",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    onPressed: null),
                children: <Widget>[
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      initialValue: name,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        //labelStyle: TextStyle(color: Colors.black45)
                      ),
                    ),
                  ),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                "Gender:",
                                style: TextStyle(
                                    color: Colors.deepPurple[400],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              chosenGender == null
                                  ? "Not chosen"
                                  : chosenGender.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            GenderSelection(
                              maleText: "", //default Male
                              femaleText: "", //default Female
//linearGradient: pinkRedGradient,
                              selectedGenderIconBackgroundColor:
                                  Colors.indigo, // default red
                              checkIconAlignment:
                                  Alignment.centerLeft, // default bottomRight
                              selectedGenderCheckIcon:
                                  null, // default Icons.check
                              onChanged: (Gender gender) {
                                chosenGender = gender.toString();
                                if (chosenGender[7] == 'M') {
                                  setState(() {
                                    chosenGender = "Male";
                                  });
                                } else {
                                  setState(() {
                                    chosenGender = "Female";
                                  });
                                }
                              },
                              equallyAligned: true,
                              animationDuration: Duration(milliseconds: 400),
                              isCircular: true, // default : true,
                              isSelectedGenderIconCircular: true,
                              opacityOfGradient: 0.6,
                              //padding: const EdgeInsets.all(3),
                              size: 200, //default : 120
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  "Date Of Birth:",
                                  style: TextStyle(
                                      color: Colors.deepPurple[400],
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                _datetime == null ? "Not chosen" : _datetime,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5),
                          RaisedButton(
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              "Pick a date",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                var date = DateTime.parse(value.toString());
                                var formattedDate =
                                    "${date.day}-${date.month}-${date.year}";
                                setState(() {
                                  _datetime = formattedDate;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              ExpansionCard(
                leading: Text(
                  "Education ",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    onPressed: null),
                children: <Widget>[
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: TextField(
                      onChanged: ((value) {
                        institution = value;
                      }),
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Institution',
                        //labelStyle: TextStyle(color: Colors.black45)
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: TextField(
                      onChanged: (value) {
                        degree = value;
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Degree',
                        //labelStyle: TextStyle(color: Colors.black45)
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionCard(
                leading: Text(
                  "Skills ",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    onPressed: null),
                children: <Widget>[
                  Container(
                    child: Tags(
                      key: _globalKey,
                      itemCount: tags.length,
                      columns: 6,
                      textField: TagsTextField(
                          hintText: "Add a Skill",
                          textStyle: TextStyle(letterSpacing: 2, fontSize: 14),
                          onSubmitted: (string) {
                            setState(() {
                              tags.add(Item(title: string));
                            });
                          }),
                      itemBuilder: (index) {
                        final Item currentItem = tags[index];
                        return ItemTags(
                          textActiveColor: Colors.black,
                          activeColor: Colors.deepPurple[200],
                          index: index,
                          title: currentItem.title,
                          customData: currentItem.customData,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          combine: ItemTagsCombine.withTextBefore,
                          onPressed: (i) => print(i),
                          onLongPressed: (i) => print(i),
                          removeButton: ItemTagsRemoveButton(onRemoved: () {
                            setState(() {
                              tags.removeAt(index);
                            });
                            return true;
                          }),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
              // FlatButton(
              //     color: kPrimaryColor,
              //     onPressed: () {},
              //     child: Text(
              //       "Save Changes",
              //       style: TextStyle(color: Colors.white),
              //     ))
            ],
          ),
        )),
      ),
    );
  }
}
