import 'package:flutter/material.dart';
import 'package:jhunt/views/login_screen.dart';
import 'package:jhunt/views/resume.dart';
import 'package:jhunt/views/menu.dart';
import 'package:jhunt/views/settings.dart';
import 'package:jhunt/views/myprofile.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            child: Text(
              'USER',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg')
                )),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: ()  {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Menu()));
            },
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Profile()));

            },
          ),

          ListTile(
            leading: Icon(Icons.topic),
            title: Text('Update Resume'),
              onTap: ()  {
            //  Navigator.pop(context);
              Navigator.push(context,new MaterialPageRoute(builder: (context)=>new Resume()));
            },

          ),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => {
              Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){

              Navigator.push(context,new MaterialPageRoute(builder: (context)=>new SettingsOnePage()));
            }
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),

            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Login()));
            }
          ),
        ],
      ),
    );
  }
}