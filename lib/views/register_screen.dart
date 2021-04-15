import 'package:flutter/material.dart';
import 'package:jhunt/theme/routes.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();



  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController= new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _repasswordController = new TextEditingController();



  // bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);


    final logo = Image.asset(
      "assets/j3.png",
      //fit: BoxFit.contain,
      height: mq.size.height / 6,
    );

    final usernameField = TextFormField(
      // enabled: isSubmitting,
      controller: _usernameController,
      style: TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        // hintText: "Thabo Thabo",
        labelText: "Username",
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );



    final emailField = TextFormField(
      //enabled: isSubmitting,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );


    final passwordField = TextFormField(
      //enabled: isSubmitting,
      controller: _passwordController,
      style: TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: "password",
        labelText: "Password",
        labelStyle: TextStyle(
            color: Colors.black
        ),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );


    final repasswordField = TextFormField(
      // enabled: isSubmitting,
      controller: _repasswordController,

      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: "password",
        labelText: "confirm Password",
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );



    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          emailField,
          passwordField,
          repasswordField,

        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child:  Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          try {
            User user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,)).user;

            if(user != null)
            {
              await FirebaseAuth.instance.currentUser.updateProfile(displayName: _usernameController.text);
              Navigator.of(context).pushNamed(AppRoutes.menu);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration Successful')));
            }
          } catch (e) {
            print(e);
            _usernameController.text = " ";
            _passwordController.text = " ";
            _repasswordController.text = " ";
            _emailController.text = " ";

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration failed')));
          }
        },
      ),
    );



    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(0.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(
              "Already have an account?",
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(
                color: Colors.blue,
              ),
            ),

            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.authLogin);
                },
                child: Text(
                  "Login",
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                )
            )

          ],
        ),
      ],
    );





    final contractor = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0.0),

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(
              "company?",
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(
                color: Colors.blue,
              ),
            ),

            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.company);
                },
                child: Text(
                  "Register here",
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                )
            )

          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(36),
            child: Container(
              height: mq.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  logo,
                  fields,
                  bottom,
                  contractor,
                ],
              ),
            )
        ),
      ),
    );
  }
}