import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:jhunt/services/services.dart';
import 'screens/screens.dart';
import 'models/models.dart';
import 'services/services.dart';
import 'widgets/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var dbRef;
  // bool _isCompanyOwner = false;
  final bool _isCompanyOwner = false;
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    Firebase.initializeApp().whenComplete(() {
      print("Firebase Initialized");
    });
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Job Finder',
            theme: ThemeData(primaryColor: Colors.blueGrey),

            /* FutureBuilder(
              future: _fbApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('You have an error ${snapshot.error.toString()}');
                  return Text('Something wrong');
                } else if (snapshot.hasData) {
                  return HomePage();
                  AuthenticationWrapper();
                  // ;
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),*/
          routes: {

          SplashScreen.routeName: (context) => SplashScreen(),
            AuthenticationWrapper.authWrapper:(context)=> AuthenticationWrapper(),
            SignIn.signIn: (context) => SignIn(),
            HomeScreen.homeScreen : (context) => HomeScreen(),
            Login.authLogin: (context) => Login(),
            Register.authRegister: (context) => Register(),
            Registercompany.company: (context) => Registercompany(),
            Resume.resume: (context) => Resume(),
              
          },


        ));
  }
}

/*class HomePage extends StatelessWidget {
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


  Future<bool> _saveUserData(String email) async {
    var dbRef = FirebaseDatabase.instance.reference().child("Companies");
    var _isCompanyOwner = true;

    await dbRef
        .orderByChild("email")
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value.isNotEmpty) {
        _isCompanyOwner = true;
      } else {
        _isCompanyOwner = false;
      }
    });
  }
}*/









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