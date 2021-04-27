import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:jhunt/theme/routes.dart';
import 'package:jhunt/screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhunt/theme/routes.dart';

class Registercompany extends StatefulWidget {
  @override
  _RegistercompanyState createState() => _RegistercompanyState();
}

class _RegistercompanyState extends State<Registercompany> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController _companynameController = new TextEditingController();
  TextEditingController _emailController= new TextEditingController();
  TextEditingController _companyownerController = new TextEditingController();
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

    final nameField = TextFormField(
      //enabled: isSubmitting,
      controller: _companyownerController,
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
        hintText: "Full names",
        labelText: "Enter names",
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
          companynameField,
          emailField,
          nameField,
        //  repasswordField,

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
            String email=_emailController.text;
            String company=_companynameController.text;
            String owner=_companyownerController.text;
            saveUserData(company,email,owner);
         //   User user = (await FirebaseAuth.instance
             //   .createUserWithEmailAndPassword(
         //     email: _emailController.text,
             //password: _passwordController.text,
        //    )).user;
/*
            if(user != null)
            {
              await FirebaseAuth.instance.currentUser.updateProfile(displayName: _companynameController.text);
             // Navigator.of(context).pushNamed(AppRoutes.home);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));
            }
            */
          } catch (e) {
            print(e);
            _companynameController.text = " ";
         //   _passwordController.text = " ";
          _companyownerController.text = " ";
            _emailController.text = " ";
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
            )
        ),
      ),
    );
  }
}

Future<bool> saveUserData(String company,String email,String owner ) async {
  await FirebaseDatabase.instance.reference().
  child("Companies")
      .push()
      .set(<String, Object>{
    "companyName": company,
    "email": email,
    "owner": owner,
  }).then((onValue) {
    return true;
  }).catchError((onError) {
    return false;
  });

}