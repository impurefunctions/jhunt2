import 'package:flutter/material.dart';
import 'package:jhunt/views/jobscreen.dart';
import 'package:jhunt/views/login_screen.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'COMPANY',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Company Profile'),
            onTap: () => {},
          ),

          ListTile(
            leading: Icon(Icons.post_add),
            title: Text('Advertise Job'),
            onTap: ()  {
              Navigator.push(context,new MaterialPageRoute(builder: (context)=>new Jobscreen()));
            },
          ),


          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.topic),
            title: Text('Applications'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: ()  {Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Login()));},
          ),
        ],
      ),
    );
  }
}