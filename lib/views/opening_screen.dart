import 'package:flutter/material.dart';
import 'package:jhunt/theme/routes.dart';

class OpeningView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/j3.png",
      //fit: BoxFit.contain,
      height: mq.size.height/6,
    );

    final  loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color:  Colors.blue,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color:  Colors.white,
          ),
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(

      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color:  Colors.blue,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color:  Colors.white,
          ),
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.authRegister);

        },
      ),
    );

    final buttons =
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0,15,0,70),
          child: registerButton,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,


        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/welcome2.jpg"),
           fit: BoxFit.cover,
         ),
         ),

         child: Padding(
          padding: EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: logo,
              ),
              buttons,
            ],
          )
      ),
        ),
    );
  }
}

