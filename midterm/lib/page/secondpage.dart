import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';


class Secondpage extends StatefulWidget {
  @override
  _SecondpageState createState() => _SecondpageState() ;

}
 class _SecondpageState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("SECONDPAGE") ,),
      body : Container(
        child: Center(

        ),

      ) ,
    );
  }
}

