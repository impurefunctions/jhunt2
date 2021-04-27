import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhunt/screens/screens.dart';
import 'package:jhunt/widgets/widgets.dart';

class ShowApplications extends StatefulWidget {
  @override
  _ShowApplicationsState createState() => _ShowApplicationsState();
}

class _ShowApplicationsState extends State<ShowApplications> {
  //build a list to get data from firebase from the applications portal
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
