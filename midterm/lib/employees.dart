import 'package:hive/hive.dart' ;
part  'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String name ;

  @HiveField(1)
  String position ;
 
  @HiveField(2)
  int salary ;
  

  @HiveField(3)
  bool isWrong = false ;
}