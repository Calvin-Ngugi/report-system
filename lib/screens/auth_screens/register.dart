import 'package:flutter/material.dart';
import 'package:report_system/services/auth/auth.dart';
import 'package:report_system/constants/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final Authenticate _auth = Authenticate();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String name = '';
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
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 50.0, 0.0),
                child: Text(
                  "Report System",
                  style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 50.0, 10.0),
                child: Text("Sign Up", style: TextStyle(fontSize: 32.0, color: Colors.black54, fontWeight: FontWeight.w600),),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0,),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Name'),
                            validator: (val) => val.isEmpty ? 'Enter your name' : null,
                            onChanged: (val){
                              setState(() => name = val);
                            },
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val){
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Password'),
                            validator: (val) => val.length < 6 ? 'Enter a password 6 characters long' : null,
                            obscureText: true,
                            onChanged: (val){
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 30.0,),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                            color: Colors.lightBlue,
                            splashColor: Color(0xFFf7418c),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white, fontSize: 25.0),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
                                if (result == null) {
                                  setState(() => error = 'please supply a valid email');
                                }
                              }
                            },
                          ),
                          SizedBox(height: 12.0),
                          Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
                          FlatButton.icon(
                              onPressed: (){
                                widget.toggleView();
                              },
                              icon: Icon(Icons.person, color: Colors.black87,),
                              label: Text("Sign in here if you have an account", style: TextStyle(color: Colors.black, fontSize: 16),)),
                        ],
                      )
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
