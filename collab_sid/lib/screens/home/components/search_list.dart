import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final proj = ["C", "C++", "Python", "Flutter", "Django"];
  final recentproj = ["Python", "Flutter"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? recentproj
        : proj.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
            text: suggestionlist[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
            children: [
              TextSpan(
                text: suggestionlist[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionlist.length,
    );
    //throw UnimplementedError();
  }
}
