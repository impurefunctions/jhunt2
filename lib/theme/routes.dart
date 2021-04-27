import 'package:flutter/material.dart';
import 'package:jhunt/companyregister_screen.dart';
import 'package:jhunt/login_screen.dart';
import 'package:jhunt/register_screen.dart';
//import 'package:jhunt/companyhome_screen.dart';
import 'package:jhunt/resume.dart';


class AppRoutes{
  AppRoutes._();
  static const String authLogin = "/auth-login";
  static const String authRegister = "auth-register";
  static const String menu = "/menu";
  static const String company = "/company-register";
  static const String home = "company-home";
  static const String resume = "/resume";

  static Map<String, WidgetBuilder> define(){
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
     // menu: (context) => Menu(),
      company: (context) => Registercompany(),
    //  home: (context) => CompanyHomePage(),
      resume: (context) => Resume(),
    };
  }
}