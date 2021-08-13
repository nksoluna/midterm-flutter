import 'package:hive/hive.dart';

import 'package:midterm/model/activity.dart';

class Boxes {
  static Box<Activity> getActivity() => Hive.box<Activity>('Activity');
}
