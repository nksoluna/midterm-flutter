import 'package:hive/hive.dart';
import 'package:midterm/employees.dart';

class Boxes {
  static Box<Employee> getEmployees() => 
  Hive.box<Employee>('Employee') ;
}