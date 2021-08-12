import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm/page/firstpage.dart';
import 'package:midterm/page/secondpage.dart';
import 'package:midterm/page/thirdpage.dart';


class NavDrawer extends StatelessWidget {

  final padding = EdgeInsets.symmetric(horizontal: 20) ;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.greenAccent.shade700,
        child: ListView(
          children: <Widget>[
            buildHeader(
              titleheader: 'Midterm' ,
              titledescription: 'This is Midterm Exam For test' , 
            ) ,
            const SizedBox(height: 20) ,
            buildMenuItem(
              text : ('Secondpage') ,
              icon: Icons.pages ,
              onClicked: () => selectedpage(context , 0) , 
             ) ,
             buildMenuItem(
               text: ('Thirdpage') ,
               icon : Icons.pages,
               onClicked: () => selectedpage(context , 1) , 
             ) ,
             buildMenuItem(
               text : ('Fourthpage') ,
               icon:  Icons.pages,
               onClicked: () => selectedpage(context , 2) , 
             ) ,
             SizedBox( height: 16,) ,
             Divider(color: Colors.white70) ,
             SizedBox(height: 16,) ,
             buildMenuItem(
               text: ('Home') ,
               icon : Icons.home ,
               onClicked: () => selectedpage(context , 3) , 
             )
          ],
        ),
      ),
    );
      
    
  }
}
Widget buildHeader( {
  String titleheader ,
  String titledescription  ,
}) {

  return InkWell(
    child: Container(
      // padding: padding.add(EdgeInsets.symmetric(vertical: 40 )),
      child: Column(
        children: [
          SizedBox(height: 20 ,),
          Text(titleheader , style: TextStyle(color: Colors.white70 ,
          fontSize: 19) ,) ,
          SizedBox(height: 10 ,),
          Text(titledescription , style: TextStyle(color: Colors.white70,
          fontSize: 16) ,) ,
        ],
      )),
    );
  
}

Widget buildMenuItem({
 String text ,
  IconData icon ,
VoidCallback onClicked ,


}) {
  final color = Colors.white ;
  final hoverColor = Colors.white70 ;
  return ListTile(
    leading: Icon( icon , color : color),
    title: Text(text , style : TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedpage(BuildContext context , int index) {
  switch (index) {
    case(0):
    Navigator.push(context, new MaterialPageRoute(
          builder: (context) => Secondpage()
          ));
     break ;

    case(1):
    Navigator.push(context, new MaterialPageRoute(
          builder: (context) => Thirdpage()
          ));
    break ;
      case(2):
    Navigator.push(context, new MaterialPageRoute(
          builder: (context) => Secondpage()
          ));
    break ;
      case(3):
    Navigator.push(context, new MaterialPageRoute(
          builder: (context) => Firstpage()
          ));
    break ;
  }
}