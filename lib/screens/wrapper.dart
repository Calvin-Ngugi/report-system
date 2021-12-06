import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_system/models/user.dart';
import 'package:report_system/screens/auth_screens/authenticate.dart';
import 'package:report_system/screens/home_screen/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    //return home or auth
    if (user == null) {
      return AuthService();
    }  else{
      return Home();
    }
  }
}
