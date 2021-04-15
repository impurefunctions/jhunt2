import 'package:flutter/material.dart';
import 'package:jhunt/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController= new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  //bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);


    final logo = Image.asset(
      "assets/j3.png",
      //fit: BoxFit.contain,
      height: mq.size.height/6,
    );

    final emailField = TextFormField(
      // enabled: isSubmitting,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color:  Colors.black
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
          color: Colors.white,
        ),
      ),
    );


    final passwordField = Column(


      children: <Widget>[

        TextFormField(
          //enabled: isSubmitting,
          controller: _passwordController,
          obscureText: true,
          style: TextStyle(
              color:  Colors.black
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
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(
              color: Colors.white,
            ),

          ),
        ),

        Padding(
            padding: EdgeInsets.all(2.0)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.blue)
                ),

                onPressed: (){
                  //TODO: CREAT FORGOT
                }

            )
          ],
        )
      ],
    );



    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton =  Material(

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

        onPressed: ()  async {
          try {
            User user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,)).user;

            if(user != null)
            {

              Navigator.of(context).pushNamed(AppRoutes.menu);
            }


          } catch (e) {
            print(e);
            _passwordController.text = " ";
            _emailController.text = " ";

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login unsuccessful')));
          }

        },


      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(0.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(
              "Do not have account?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.blue,
              ),
            ),

            MaterialButton(
                onPressed: ()
                {
                  Navigator.of(context).pushNamed(AppRoutes.authRegister);
                },
                child: Text(
                  "Signup",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
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
              child:  Column(
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
