import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/Activitydialog.dart';
import 'package:midterm/page/activitypage.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  String groupfilter = 'หมวดหมู่';
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

          if (groupfilter == 'งานบ้าน') {
            final homework = activities
                .where((element) => element.groups == 'งานบ้าน')
                .toList();
            return buildContent(homework);
          }
          if (groupfilter == 'ทำงาน') {
            final worker = activities
                .where((element) => element.groups == 'ทำงาน')
                .toList();
            return buildContent(worker);
          }
          if (groupfilter == 'งานอดิเรก') {
            final hobbies = activities
                .where((element) => element.groups == 'งานอดิเรก')
                .toList();
            return buildContent(hobbies);
          }
          if (groupfilter == 'งานซ่อม') {
            final fixed = activities
                .where((element) => element.groups == 'งานซ่อม')
                .toList();
            return buildContent(fixed);
          } else {
            return buildContent(activities);
          }
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

  Widget buildFilter(BuildContext context) => DropdownButton<String>(
        value: groupfilter,
        elevation: 16,
        style: const TextStyle(color: Colors.greenAccent),
        underline: Container(
          height: 2,
          color: Colors.greenAccent.shade700,
        ),
        onChanged: (String newValue) {
          setState(() {
            groupfilter = newValue;
          });
        },
        items: <String>['หมวดหมู่', 'งานบ้าน', 'ทำงาน', 'งานอดิเรก', 'งานซ่อม']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildContent(List<Activity> activities) {
    BuildContext context;
    if (activities.isEmpty) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            buildFilter(context),
          ],
        ),
        SizedBox(
          height: 350,
        ),
        Center(
          child: Text(
            'No activity yet!',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        )
      ]);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              buildFilter(context),
            ],
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
}
