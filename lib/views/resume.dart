import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhunt/views/menu.dart';
void main() => runApp(Resume());

class Resume extends StatefulWidget {

  @override
  _ResumeState createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {

  final referenceDatabase = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _surnameController= new TextEditingController();

  TextEditingController _emailController= new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController= new TextEditingController();
  TextEditingController _educationController= new TextEditingController();
  TextEditingController _skillController = new TextEditingController();
  TextEditingController _experienceController= new TextEditingController();
  TextEditingController _referenceController = new TextEditingController();




  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
   final ref = referenceDatabase.reference();
    //final cvUpdate  = "UPDATE CV" ;




    final surnameField = TextFormField(
      // enabled: isSubmitting,
      controller: _surnameController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: "Surname",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );



    final emailField = TextFormField(
      // enabled: isSubmitting,
      controller: _emailController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );


    final addressField = TextFormField(
      // enabled: isSubmitting,
      controller: _addressController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: "Physical Address",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final phoneField = TextFormField(
      // enabled: isSubmitting,
      controller: _phoneController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: "Phone",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );



    final educationField = TextFormField(
      // enabled: isSubmitting,

      maxLines: 4,
      minLines: 2,

      controller: _educationController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        labelText: "Education",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final skillField = TextFormField(
      // enabled: isSubmitting,
      maxLines: 4,
      minLines: 3,


      controller: _skillController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        labelText: "Skills",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final experienceField = TextFormField(
      // enabled: isSubmitting,
      maxLines: 4,
      minLines: 3,


      controller: _experienceController,
      style: TextStyle(
          color: Colors.white
      ),


      cursorColor: Colors.white,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        labelText: "Experience",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final referenceField = TextFormField(
      // enabled: isSubmitting,
      maxLines: 4,
      minLines: 2,


      controller: _referenceController,
      style: TextStyle(
          color: Colors.white
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        labelText: "References",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
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
          "Update",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          ref.child("cv's").push().set({
            "surname":_surnameController.text,
          "email": _emailController.text,
          "address":  _addressController .text,
          "phone": _phoneController.text,
          "education" :_educationController.text,
          "skills" :_skillController .text,
          "experience": _experienceController.text,
          "reference": _referenceController .text,

          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Resume updated')));
          if(ref !=null) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Menu()));
          }
        }
       )
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




    final fields = Padding(

      padding: EdgeInsets.all( 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
      Padding(
      padding: EdgeInsets.all(15)
     ),
         surnameField,
        //  firstnameField,
          emailField,
          addressField,
          phoneField,
          educationField,
          skillField,
          experienceField,
          referenceField ,

        ],
      ),
    );



    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(36),
            child: Container(
              height: mq.size.height,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

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




