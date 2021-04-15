import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(Menu());



class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  //final referenceDatabase = FirebaseDatabase.instance;



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Widget build(BuildContext context) {

    final ref = FirebaseDatabase.instance.reference().child("jobs");
    List<Map<dynamic, dynamic>> lists = [];



    final view =  Material(

      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color:  Colors.blueGrey,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Text(
          "APPLY",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color:  Colors.white,
          ),
        ),
        onPressed: () {

        },
      )
    );
 




    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('SEARCH FOR A JOB'),

        actions: <Widget>[

          IconButton(icon: Icon(Icons.search),

             onPressed: ()
             {
               showSearch(context:  context, delegate: DataSearch());
            },
          )
        ],
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
                          view,
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

class DataSearch extends SearchDelegate<String> {

final jobs = [
  ];
final recentJobs = [];


  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query="";
      })];

  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selection
   return Card(
     
   );
  }

@override
Widget buildSuggestions(BuildContext context) {
  final suggestionList = query.isEmpty
      ?recentJobs
      :jobs.where((j) => j.startsWith(query)).toList();
  return ListView.builder(
    itemBuilder: (context,index)=>ListTile(
      leading: Icon(Icons.work),
      title: Text(suggestionList[index]),
    ),
    itemCount: suggestionList.length,
  );
}

}