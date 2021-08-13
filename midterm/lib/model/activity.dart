import 'package:hive/hive.dart';
part 'activity.g.dart';

@HiveType(typeId: 1)
class Activity extends HiveObject {
  @HiveField(4)
  String title;

  @HiveField(5)
  String groups;

  @HiveField(7)
  String lasttime;
}
