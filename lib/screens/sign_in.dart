import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/screens/home_screen.dart';
//import 'package:jhunt/theme/routes.dart';
import 'package:jhunt/screens/screen2.dart';
import 'package:jhunt/services/authentication_service.dart';
import 'package:jhunt/screens/authentication_wrapper.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static const signIn = '/sign-in';
  final bool _isLoggedIn = false;

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  bool _isSignIn = true;

  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
//  TextEditingController _companyownerController = new TextEditingController();
  // TextEditingController _repasswordController = new TextEditingController();

  // bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/j3.png",
      //fit: BoxFit.contain,
      height: mq.size.height / 6,
    );
/*
    final companynameField = TextFormField(
      // enabled: isSubmitting,
      controller: _companynameController,
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
        labelText: "Company name",
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );

*/

    final emailField = TextFormField(
      //enabled: isSubmitting,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
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
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: "Password",
        labelText: "Enter password",
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
    final confirmPasswordField = TextFormField(
      //enabled: isSubmitting,
      controller: _confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: "Password",
        labelText: "Confirm password",
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
          emailField,
          passwordField,
          if (!_isSignIn) confirmPasswordField,
        ],
      ),
    );

    final registerButton = ElevatedButton(
      child: Text(
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
          _saveUserData(_emailController.text, _emailController.text)
              .whenComplete(
                  () => Navigator.pushNamed(context, HomeScreen.homeScreen));
          User user =
              (await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          ))
                  .user;

          if (user != null) {
            //  await FirebaseAuth.instance.currentUser.updateProfile(displayName: _companynameController.text);
            // Navigator.of(context).pushNamed(AppRoutes.home);
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));
          }
        } catch (e) {
          print(e);
          _passwordController.text = " ";
          _emailController.text = " ";
        }
      },
    );

    final signInToggle = TextButton(
        onPressed: () {
          setState(() {
            if (_isSignIn) {
              _isSignIn = false;
            } else {
              _isSignIn = true;
            }
          });
        },
        child: Text(_isSignIn
            ? 'Have an Account? Sign In'
            : 'Have no Account? Sign Up'));

    final loginButton = ElevatedButton(
      child: Text(
        "Log in",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        context
            .read<AuthenticationService>()
            .signin(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ).then((value) {
             bool _isCompany;
              if(value == 'Individual'){
                _isCompany = false;
              }else{
                _isCompany = true;
              }

              return Navigator.of(context).pushNamed(AuthenticationWrapper.authWrapper,arguments: {
                'isCompanyOwner': _isCompany
              });
             print(value);
            });

        //context.read<AuthenticationService>().signIn

        /*
        try {
          String email=_emailController.text;
          String password=_passwordController.text;
          // String owner=_companyownerController.text;
          saveUserData(password,email);
          User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          )).user;

          if(user != null)
          {
            //  await FirebaseAuth.instance.currentUser.updateProfile(displayName: _companynameController.text);
            // Navigator.of(context).pushNamed(AppRoutes.home);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));
          }

        } catch (e) {
          print(e);
          _passwordController.text = " ";
          //   _passwordController.text = " ";
          //_companyownerController.text = " ";
          _emailController.text = " ";
        }
        */
      },
    );
    final bottom = Column(
      children: <Widget>[
        if (_isSignIn == false) registerButton,
        if (_isSignIn == true) loginButton,
        signInToggle
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
                ],
              ),
            )),
      ),
    );
  }

  Future<bool> _saveUserData(
    String password,
    String email,
  ) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Companies")
        .push()
        .set(<String, Object>{
      //  "email": email,
      //   "owner": owner,
    }).then((onValue) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }



}
