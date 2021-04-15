import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/views/opening_screen.dart';
import 'package:jhunt/theme/routes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Finder',

      routes: AppRoutes.define(),
      home:OpeningView(),

    );
  }
}
