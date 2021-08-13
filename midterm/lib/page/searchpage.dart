import 'package:flutter/material.dart';
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
            onPressed: () {},
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