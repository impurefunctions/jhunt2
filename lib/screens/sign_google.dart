import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhunt/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SignInGoogle extends StatefulWidget {

  @override
  _SignInGoogle createState() => _SignInGoogle();
}

class _SignInGoogle extends State<SignInGoogle> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  String userId;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Codesundar")),
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  Image.network(_userObj.photoUrl),
                  Text(_userObj.displayName),
                  Text(_userObj.email),
                  TextButton(
                      onPressed: () {
                        _googleSignIn.signOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        }).catchError((e) {});
                      },
                      child: Text("Logout"))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: Text("Login with Google"),
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      setState(() async {
                        _isLoggedIn = true;
                        _userObj = userData;
                         userId=_userObj.id;
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs?.setBool("isLoggedIn", true);
                      prefs.setString("key", userId);
                         Future<void> main() async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                         var status = prefs.getBool('isLoggedIn') ?? false;
                        print(status);
                        runApp(MaterialApp(
                            home: status == true ? Login() : HomeScreen()));
                         }

                      });
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ),
      ),
    );
  }
}
