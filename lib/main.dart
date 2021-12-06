import 'package:flutter/material.dart';
import 'package:report_system/models/user.dart';
import 'package:report_system/services/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:report_system/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: Authenticate().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}