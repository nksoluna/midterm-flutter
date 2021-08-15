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
  String monthfilter = 'เดือน';

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
        actions: [],
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: ValueListenableBuilder<Box<Activity>>(
          valueListenable: Boxes.getActivity().listenable(),
          builder: (context, box, _) {
            final activities = box.values.toList().cast<Activity>();
            if (monthfilter == 'ม.ค.') {
              final jan = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ม.ค.')
                  .toList();
              return buildContent(jan);
            }
            if (monthfilter == 'ก.พ.') {
              final feb = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ก.พ.')
                  .toList();
              return buildContent(feb);
            }
            if (monthfilter == 'มี.ค.') {
              final mar = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'มี.ค.')
                  .toList();
              return buildContent(mar);
            }
            if (monthfilter == 'เม.ษ.') {
              final apr = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'เม.ษ.')
                  .toList();
              return buildContent(apr);
            }
            if (monthfilter == 'พ.ค.') {
              final may = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'พ.ค.')
                  .toList();
              return buildContent(may);
            }
            if (monthfilter == 'มิ.ย.') {
              final jun = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'มิ.ย.')
                  .toList();
              return buildContent(jun);
            }
            if (monthfilter == 'ก.ค.') {
              final jul = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ก.ค.')
                  .toList();
              return buildContent(jul);
            }
            if (monthfilter == 'ส.ค.') {
              final aug = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ส.ค.')
                  .toList();
              return buildContent(aug);
            }
            if (monthfilter == 'ก.ย.') {
              final sep = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ก.ย.')
                  .toList();
              return buildContent(sep);
            }
            if (monthfilter == 'ต.ค.') {
              final oct = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ต.ค.')
                  .toList();
              return buildContent(oct);
            }
            if (monthfilter == 'พ.ย.') {
              final nov = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'พ.ย.')
                  .toList();
              return buildContent(nov);
            }
            if (monthfilter == 'ธ.ค.') {
              final dec = activities
                  .where((element) => element.lasttime.split(' ')[1] == 'ธ.ค.')
                  .toList();
              return buildContent(dec);
            }
            return buildContent(activities);
          }),
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
        value: monthfilter,
        elevation: 16,
        style: const TextStyle(color: Colors.greenAccent),
        underline: Container(
          height: 2,
          color: Colors.greenAccent.shade700,
        ),
        onChanged: (String newValue) {
          setState(() {
            monthfilter = newValue;
          });
        },
        items: <String>[
          'เดือน',
          'ม.ค.',
          'ก.พ.',
          'มี.ค.',
          'เม.ษ.',
          'พ.ค.',
          'มิ.ย.',
          'ก.ค.',
          'ส.ค.',
          'ก.ย.',
          'ต.ค.',
          'พ.ย.',
          'ธ.ค.'
        ].map<DropdownMenuItem<String>>((String value) {
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
