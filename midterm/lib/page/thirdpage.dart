import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';


class Thirdpage extends StatefulWidget {
  @override
  _ThirdpageState createState() => _ThirdpageState() ;

}
 class _ThirdpageState extends State<Thirdpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("THIRDPAGE") ,),
      body : Container(
        child: Center(

        ),

      ) ,
    );
  }
}

