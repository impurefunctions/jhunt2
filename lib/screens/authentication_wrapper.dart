import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:jhunt/screens/screens.dart';
import 'package:jhunt/widgets/widgets.dart';


class AuthenticationWrapper extends StatelessWidget {

 static const authWrapper = 'auth-wrapper';

  @override
  Widget build(BuildContext context) {

    var routeArgs = ModalRoute.of(context).settings.arguments as Map<String, bool>;

   final bool _isCompanyOwner = routeArgs['isCompanyOwner'];

      return Scaffold(
        body: Container(
            child: _isCompanyOwner
                ? Stack(children: [
              DrawerScreen2(),
              HomeScreen(),
            ])
                : Stack(children: [
              DrawerScreen(),
              HomeScreen(),
            ])),
      );
    }
  }


