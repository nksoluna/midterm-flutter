import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';
import 'package:midterm/employees.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'Employeedialog.dart';
import 'Employeepage.dart';

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState() ;

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
      appBar: AppBar(title: Text("FIRSTPAGE") ,
      backgroundColor: Colors.greenAccent.shade700,),
      body : ValueListenableBuilder<Box<Employee>> (
        valueListenable: Boxes.getEmployees().listenable(),
        builder: (context , box , _) {
          final employees = box.values.toList().cast<Employee>() ;
          return buildContent(employees) ;
        },
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed: () => showDialog(context: context,
       builder: (context) => EmployeeDialog(
         onClickedDone: addEmployee, 
       )),),
    );
  }
}


  


