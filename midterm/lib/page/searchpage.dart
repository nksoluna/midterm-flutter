/*import 'package:flutter/material.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/activitypage.dart';

import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Activity> allacts;
  String query = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text("Search"),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: ValueListenableBuilder<Box<Activity>>(
        valueListenable: Boxes.getActivity().listenable(),
        builder: (context, box, _) {
          final activities = box.values.toList().cast<Activity>();
          return showContent(activities);
        },
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }
  
@override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

@override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Activity acts ;
    query.isEmpty ?
    

  }

  
}
*/