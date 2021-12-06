import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_system/services/auth/auth.dart';
import 'package:report_system/constants/const.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authenticate _auth = Authenticate();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe1eeee),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(60.0, 30.0, 50.0, 0.0),
            child: Text(
              "Report System",
              style: TextStyle(
                  fontSize: 34.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.fromLTRB(60.0, 30.0, 50.0, 30.0),
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6 characters long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      color: Colors.lightBlue,
                      splashColor: Color(0xFFf7418c),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => error = 'Failed to sign in');
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    FlatButton.icon(
                        onPressed: () {
                          widget.toggleView();
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.black87,
                        ),
                        label: Text(
                          "To register click here",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
