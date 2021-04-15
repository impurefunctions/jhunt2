import 'package:flutter/material.dart';
import 'companysidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';


void main() => runApp(CompanyHomePage());

class Companyhome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CompanyHomePage(),
    );
  }
}


class CompanyHomePage extends StatelessWidget {

  //final ref = FirebaseDatabase.instance.reference().child("jobs");
 // final  List<Map<dynamic, dynamic>> lists = [];
@override
  Widget build(BuildContext context) {


  final ref = FirebaseDatabase.instance.reference();
   List<Map<dynamic, dynamic>> lists = [];





  return Scaffold(
    drawer: NavDrawer(),
    appBar: AppBar(
      title: Text('MY PROFILE'),
     backgroundColor: Colors.blueGrey ,
    ),
    body:FutureBuilder(
        future: ref.once(),
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

                        Text("Company Name: " + lists[index]["companyname"]),
                        Text("Location: "+ lists[index]["location"]),
                        Text("Job Vacancy: " +lists[index]["jobvacancy"]),
                        Text("Contacts: " + lists[index]["contacts"]),
                        Text("Category: "+ lists[index]["category"]),
                        Text("Requirements: " +lists[index]["requirements"]),
                        //view,
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



