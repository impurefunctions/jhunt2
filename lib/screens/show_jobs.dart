import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhunt/screens/screens.dart';
import 'package:jhunt/widgets/widgets.dart';


class ShowJobs extends StatefulWidget {
  @override
  _ShowJobsState createState() => _ShowJobsState();
}

class _ShowJobsState extends State<ShowJobs> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child("jobs");
  //build a list to get data from firebase from the available jobs portal
  Widget _buildList() {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Hunter app"),
      ),
      body: _buildList(),
    );
  }
}
