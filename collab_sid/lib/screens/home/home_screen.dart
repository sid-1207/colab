import 'package:flutter/material.dart';
import '../../bottom.dart';
import '../home/components/search_list.dart';
import '../home/home.dart';
import './starred.dart';
import './enrolled.dart';
// import './home.dart';
// import './components/search_list.dart';
import '../../constants.dart';
import '../create/create_screen.dart';
// import '../../bottom.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
  static final routeName = 'Home-Screen';
}

class _HomeScreen1State extends State<HomeScreen1>
    with TickerProviderStateMixin {
  TabController tabController;
  var fabIcon = Icon(Icons.add);
  @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(vsync: this, length: 3)
  //     ..addListener(() {
  //       setState(() {
  //         switch (tabController.index) {
  //           case 0:
  //             fabIcon = Icon(Icons.add);
  //             break;
  //           case 1:
  //             fabIcon = Icon(Icons.add);
  //             break;
  //         }
  //       });
  //     });
  // }
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              fabIcon = Icon(Icons.add);
              break;
            case 1:
              fabIcon = Icon(Icons.add);
              break;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomTabs(2),
      appBar: AppBar(
        title: Text("Home Page"),
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
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text("ENROLLED"),
            ),
            Tab(
              child: Text("CREATED"),
            ),
            Tab(
              icon: Icon(Icons.star_border),
            ),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          EnrolledScreen(),
          HomeScreen(),
          StarredScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(CreateScreen.routeName);
        },
        child: fabIcon,
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
