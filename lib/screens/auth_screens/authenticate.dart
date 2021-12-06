import 'package:flutter/material.dart';
import 'package:report_system/screens/auth_screens/register.dart';
import 'file:///D:/Projects/report_system/lib/screens/auth_screens/sign_in.dart';

class AuthService extends StatefulWidget {
  @override
  _AuthServiceState createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {

  bool showSignIn = true;
  void toggleView(){
    setState(() =>showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    } else {
     return Register(toggleView: toggleView);
    }
  }
}
