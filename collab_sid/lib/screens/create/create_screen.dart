import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateScreen extends StatefulWidget {
  static final routeName='create-screen';
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
  DateTime selectedDate = DateTime.now();
  var selectedList = [];
  List tags = new List();
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  int currentValue = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double appheight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            height: size.height,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              image: DecorationImage(
                image: AssetImage("assets/images/ideas.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(),
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Members", style: TextStyle(fontSize: 18),),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.grey,
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          DateFormat('MMM yyyy').format(selectedDate),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 5,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            showMonthPicker(
                              context: context,
                              initialDate: selectedDate,
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
                                "Select Date ",
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    splashColor: Colors.grey,
                    onPressed: () {},
                    child: Text("CREATE"),
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
