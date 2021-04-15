import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final ref = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(



        body:FutureBuilder(
            future: ref.child("User UID").once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //view,

                            Text("USERNAME: " + lists[index]["User UID"]),
                            Text("EMAIL: "+ lists[index]["lidentifier"]),

                          ],
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            })




    );
  }
}
