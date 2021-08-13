import 'package:flutter/material.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/activitypage.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Thirdpage extends StatefulWidget {
  @override
  _ThirdpageState createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ABOUT"),
        ),
        body: ValueListenableBuilder<Box<Activity>>(
            valueListenable: Boxes.getActivity().listenable(),
            builder: (context, box, _) {
              final activities = box.values.toList().cast<Activity>();
              return showContent(activities);
            }));
  }
}
