import 'package:flutter/material.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/Activitydialog.dart';

import 'package:midterm/page/boxes.dart';
import 'package:midterm/page/thirdpage.dart';

Widget buildContent(List<Activity> activities) {
  if (activities.isEmpty) {
    return Center(
      child: Text(
        'No activity yet!',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 24),
        Text(
          'All Activities',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.greenAccent.shade700,
          ),
        ),
        SizedBox(height: 24),
        Expanded(
          child: ReorderableListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: activities.length,
            itemBuilder: (BuildContext context, int index) {
              final activity = activities[index];
              return buildActivity(context, activity);
            },
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final Activity act = activities.removeAt(oldIndex);
              activities.insert(newIndex, act);
            },
          ),
        ),
      ],
    );
  }
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
              }),
        ),
      ],
    );
  }
}

Widget buildActivity(
  BuildContext context,
  Activity activity,
) {
  var lasttimelist = activity.lasttime.split(' ');
  var day = int.parse(lasttimelist[0]);
  var month = lasttimelist[1].toString();
  var year = int.parse(lasttimelist[2]);
  var lasttime = 'Date : ' +
      day.toString() +
      ' ' +
      month +
      ' ' +
      year.toString() +
      '          ';

  return Card(
    key: ValueKey(activity.title),
    color: Colors.white,
    child: ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: Text(
        activity.title,
        maxLines: 2,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(activity.groups),
      trailing: Text(
        lasttime,
        style: TextStyle(
            color: Colors.greenAccent.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      children: [
        buildButtons(context, activity),
      ],
    ),
  );
}

Widget buildButtons(BuildContext context, Activity activity) => Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text('About'),
            icon: Icon(Icons.business),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Thirdpage(),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Edit'),
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ActivityDialog(
                  activity: activity,
                  onClickedDone: (title, groups, lasttime) =>
                      editActivity(activity, title, groups, lasttime),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Delete'),
            icon: Icon(Icons.delete),
            onPressed: () => deleteActivity(activity),
          ),
        )
      ],
    );

Future addActivity(String title, String groups, String lasttime) async {
  final activity = Activity()
    ..title = title
    ..groups = groups
    ..lasttime = lasttime;

  final box = Boxes.getActivity();
  box.add(activity);
  //box.put('mykey', employee);

  // final mybox = Boxes.getactivities();
  // final myemployee= mybox.get('key');
  // mybox.values;
  // mybox.keys;
}

void editActivity(
  Activity activity,
  String title,
  String groups,
  String lasttime,
) {
  activity.title = title;
  activity.groups = groups;
  activity.lasttime = lasttime;

  activity.save();
}

void deleteActivity(Activity activity) {
  activity.delete();
}
