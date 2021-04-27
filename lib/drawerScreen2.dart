import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/companyregister_screen.dart';
import 'package:jhunt/configuration.dart';
import 'package:jhunt/homeScreen.dart';
import 'package:jhunt/jobscreen.dart';
import 'package:jhunt/resume.dart';
import 'package:jhunt/screen3.dart';
import 'package:jhunt/theme/routes.dart';

class DrawerScreen2 extends StatefulWidget {
  @override
  _DrawerScreen2State createState() => _DrawerScreen2State();
}

/*class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryGreen,
      padding: EdgeInsets.only(top:50,bottom: 70,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pako Keokilwe',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text('Active Status',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),

          Column(
            children: drawerItems.map((element) => Padding(

          padding:  const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  /*
  GestureDetector(
                    onTap: (TapDownDetails details) {
                      int idx=drawerItems.indexOf(element);
                      if(idx==0){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Jobscreen()) );
                      }else if(idx==1){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Registercompany()) );
                      }else if(idx==2){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen()) );
                      }
                      else if(idx==3){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Resume()) );
                      }
                    },
                  ),*/
                  Icon(element['icon'],color: Colors.white,size: 30,),
                  SizedBox(),
                  Text(element['title'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

                    ],
              ),
            )).toList(),
          ),

          Row(
            children: [
              Icon(Icons.settings,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Settings',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Container(width: 2,height: 20,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Log out',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)


            ],

          )


        ],
      ),

    );
  }
}*/

class _DrawerScreen2State extends State<DrawerScreen2>{
  @override
  Widget build(BuildContext context) {
    return Container(
        color: primaryGreen,
   child:Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),

          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'See my companies',
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Resume()) ),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'See Applications',
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Screen3()) ),
          ),

          createDrawerBodyItem(
            icon: Icons.event_note,
            text: 'Add Job',
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Jobscreen()) ),
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Register New Company',
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Registercompany()) ),
          ),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    ));
  }
}

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:  AssetImage('images/bg_header.jpeg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Welcome to Flutter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
