import 'package:flutter/material.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Workpage extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Workpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [],
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: ValueListenableBuilder<Box<Activity>>(
        valueListenable: Boxes.getActivity().listenable(),
        builder: (context, box, _) {
          final activities = box.values.toList().cast<Activity>();

          final work =
              activities.where((element) => element.groups == 'ทำงาน').toList();
          return showContent(work);
        },
      ),
    );
  }

  Widget showContent(List<Activity> activities) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No Data!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'HISTORY OF ACTIVITIES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.greenAccent.shade700,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final activity = activities[index];
                    return Card(
                      color: Colors.white,
                      child: ExpansionTile(
                        tilePadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        title: Text(
                          activity.title,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.greenAccent.shade700),
                        ),
                        subtitle: Text(activity.groups),
                        trailing: Text(
                          activity.lasttime,
                          style: TextStyle(
                              color: Colors.greenAccent.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    );
                  })),
        ],
      );
    }
  }
}
