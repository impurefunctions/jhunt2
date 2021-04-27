import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'job.dart';

class Screen3 extends StatelessWidget {
  final Job job;
  // final Map job1;
  //final String contentId;
//set contents from job to textviews
  Screen3({Key key, @required this.job}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    DatabaseReference _database= FirebaseDatabase.instance.reference();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[300],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,

                    ),
                  )
                ],
              )),
          Container(
            margin:EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                    Navigator.pop(context);
                  }),
                  IconButton(icon: Icon(Icons.share), onPressed: (){

                  })
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
                alignment: Alignment.topCenter,

                child: Hero(
                  tag: 1,
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[Text(job.companyname , style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 40),  ),]
                  ),)

            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Text(job.jobvacancy),
                  Text(job.location),
                  Text(job.category),
                  Text(job.requirements),
                  Text(job.contacts)
                ],
              ),

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 120,
              child: Row(
                children: [
                  Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                          color: primaryGreen,

                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(Icons.favorite_border,color: Colors.white,)
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: MaterialButton(

                        minWidth: mq.size.width / 1.2,
                        color: Colors.blue,
                        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        child: Center(child: Text('Apply',style: TextStyle(color: Colors.white,fontSize: 24),)),
                        onPressed: () {

                          //DatabaseReference ref= FirebaseDatabase.instance.reference().child("Companies").child(job.key).push();
                          //  DatabaseReference ref1= FirebaseDatabase.instance.reference()..child("Users").child(currentUser()).child(job.key);

                          saveUserData( job);
                          //ref.set({

                          //  "usercv":job.companyname,
                          //  }).whenComplete(() => ref1.set({
                          //    "usercv":job.companyname,}));
                        }
                    ),
                  )
                ],
              )
              ,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
              ),
            ),
          )



        ],
      ),
    );
  }
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('key');
  return stringValue;
}
currentUser() {

  final User user = FirebaseAuth.instance.currentUser;
  final uid = user.uid.toString();
  return uid;
}
Future<bool> saveUserData(Job  job) async {
  await FirebaseDatabase.instance.reference().
  child("Companies").
  child(job.key)
      .push()
      .set(<String, Object>{
    "mobileNumber": job.companyname,
    "userName": job.contacts,
    "fullName": job.category,
  }).then((onValue) {
    return true;
  }).catchError((onError) {
    return false;
  }).whenComplete(() =>  FirebaseDatabase.instance.reference().
  child("Users").
  child(job.key)
      .push().set(<String, Object>{

    "mobileNumber": job.companyname,
    "userName": job.contacts,
    "fullName": job.category,
  }) );

}