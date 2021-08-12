import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:midterm/page/firstpage.dart';
import 'employees.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async  {
  WidgetsFlutterBinding.ensureInitialized() ;

await Hive.initFlutter() ;

Hive.registerAdapter(EmployeeAdapter());
await Hive.openBox<Employee>('Employee') ;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Midterm',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Firstpage(),
    );
  }
}

