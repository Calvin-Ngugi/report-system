import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white54, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0),
      ),
    );




//actions: <Widget>[
//   FlatButton.icon(
//       onPressed: () async {
//         await _auth.signOut();
//       },
//       splashColor: Colors.orange,
//       icon: Icon(
//         Icons.person,
//         color: Colors.black,
//       ),
//       label: Text(
//         "Logout",
//         style: TextStyle(color: Colors.black),
//       )),
//   FlatButton.icon(
//       onPressed: () => _showSettingsPanel(),
//       icon: Icon(
//         Icons.settings,
//         color: Colors.black,
//       ),
//       label: Text('')),
//],