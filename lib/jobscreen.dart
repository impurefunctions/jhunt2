import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhunt/screen2.dart';
//import 'package:jhunt/views/companyhome_screen.dart';

void main() => runApp(Jobscreen());

class Jobscreen extends StatefulWidget {

  @override
  _JobscreenState createState() => _JobscreenState();
}

class _JobscreenState extends State<Jobscreen> {

  final referenceDatabase = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _companynameController= new TextEditingController();
  TextEditingController _locationController= new TextEditingController();
  TextEditingController _jobvacancyController = new TextEditingController();
  TextEditingController _requirementsController= new TextEditingController();
  TextEditingController _contactsController= new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final ref = referenceDatabase.reference();




    final companynameField = TextFormField(
      // enabled: isSubmitting,
      controller: _companynameController,
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
        labelText: "Company name",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );



    final locationField = TextFormField(
      // enabled: isSubmitting,
      controller: _locationController,
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
        labelText: "Location",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );


    final jobvacancyField = TextFormField(
      // enabled: isSubmitting,
      controller: _jobvacancyController,
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
        labelText: "Job Vacancy",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final contactsField = TextFormField(
      // enabled: isSubmitting,
      controller: _contactsController,
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
        labelText: "Contacts",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );



    final categoryField = TextFormField(
      // enabled: isSubmitting,

      maxLines: 4,
      minLines: 2,

      controller: _categoryController,
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
        labelText: "Job Category",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final requirementsField = TextFormField(
      // enabled: isSubmitting,
      maxLines: 4,
      minLines: 3,


      controller: _requirementsController,
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
        labelText: "Job Requirements",
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
              "Post job",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              ref.child("jobs").push().set({
                   "companyname":_companynameController.text,
                   "location": _locationController.text,
                   "jobvacancy": _jobvacancyController .text,
                   "contacts": _contactsController.text,
                   "category" :_categoryController.text,
                   "requirements" :_requirementsController .text,

              }

              );

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Job Successfully Posted')));
              if(ref !=null) {
                //company home route deleted
               // Navigator.push(context,
                 //   new MaterialPageRoute(builder: (context) => new CompanyHomePage()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));










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
          companynameField,
          locationField,
          jobvacancyField,
          contactsField,
          categoryField,
          requirementsField,


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




