import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/Activitydialog.dart';
import 'package:midterm/page/activitypage.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reorderables/reorderables.dart';

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("FIRSTPAGE"),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: ValueListenableBuilder<Box<Activity>>(
        valueListenable: Boxes.getActivity().listenable(),
        builder: (context, box, _) {
          final activities = box.values.toList().cast<Activity>();
          return buildContent(activities);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => ActivityDialog(
                  onClickedDone: addActivity,
                )),
      ),
    );
  }
}
