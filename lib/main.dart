import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhunt/authentication_service.dart';
import 'package:jhunt/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/screen2.dart';
import 'package:jhunt/sign_google.dart';
import 'package:jhunt/sign_in.dart';
import 'package:jhunt/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawerScreen.dart';
import 'drawerScreen2.dart';
import 'homeScreen.dart';
import 'dart:math';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 // var dbRef;
 // bool _isCompanyOwner = false;
  bool _isCompanyOwner=false;
  final Future<FirebaseApp> _fbApp=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      Provider<AuthenticationService>(create: (_)=>AuthenticationService(FirebaseAuth.instance)
      ),
      StreamProvider(create: (context)=> context.read<AuthenticationService>().authStateChanges,

      )
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Job Finder',

      theme: ThemeData(primaryColor: Colors.blueGrey),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context,snapshot){
          if(snapshot.hasError){
            print('You have an error ${snapshot.error.toString()}');
                return Text('Something wrong');
          }else if (snapshot.hasData){
            return HomePage();
          AuthenticationWrapper();
           // ;
          }else{
            return Center(
              child: CircularProgressIndicator(),
          );
          }
        },
      )
      )  );
  }

}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthenticationWrapper(),
          //DrawerScreen(),
         // HomeScreen(),
          //SplashScreen(),

        ],
      ),

    );
  }
}
class ShowJobs extends StatefulWidget{
  @override
  ShowJobsState createState() => ShowJobsState();
}
class ShowApplications extends StatefulWidget{
  @override
  ShowApplicationsState createState() => ShowApplicationsState();
}



class ShowJobsState extends State<ShowJobs>{
  DatabaseReference ref= FirebaseDatabase.instance.reference().child("jobs");
  //build a list to get data from firebase from the available jobs portal
Widget _buildList(){
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
      }
  );

}
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Hunter app"),),
      body: _buildList(),

    );
  }


}
class ShowApplicationsState extends State<ShowApplications>{
  //build a list to get data from firebase from the applications portal
  Widget _buildList(){
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
        }
    );

  }
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Hunter app"),),
      body: _buildList(),

    );
  }


}



class AuthenticationWrapper extends StatelessWidget{
  const AuthenticationWrapper({Key,key}): super (key: key);
  final bool _isCompanyOwner=false;
/*
  @override
  void initState() {
    super.initState();
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {

      String email = firebaseUser.email;
      String uid = firebaseUser.uid;
      var dbRef = FirebaseDatabase.instance.reference()
          .child("Companies");

      dbRef.orderByChild("email").equalTo(email).once().then((
          DataSnapshot snapshot) {
        if (snapshot.value.isNotEmpty) {
          _isCompanyOwner = true;}else{ _isCompanyOwner = false;}
  }
  */
   @override
  Widget build(BuildContext context) {

        final firebaseUser = context.watch<User>();

        if (firebaseUser != null) {

          return Container(
              child: _isCompanyOwner
                  ? Stack(
                  children: [
                    DrawerScreen2(),
                    HomeScreen(),
                  ]
              )
                  : Stack(
                  children: [
                    DrawerScreen(),
                    HomeScreen(),
                  ]

              )

          );
        }else {
          return SignInGoogle();
        }


   }


}

Future<bool> saveUserData(String email ) async {
  var dbRef = FirebaseDatabase.instance.reference()
      .child("Companies");

  await dbRef.orderByChild("email").equalTo(email).once().then((
      DataSnapshot snapshot) {
    if (snapshot.value.isNotEmpty) {
      _isCompanyOwner = true;}
    else{ _isCompanyOwner = false;
    }

});

}
