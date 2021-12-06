import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:report_system/constants/const.dart';
import 'package:report_system/screens/home_screen/home.dart';
import 'package:report_system/services/auth/auth.dart';
import 'package:report_system/services/firestore_services.dart';

class Police extends StatefulWidget {
  @override
  _PoliceState createState() => _PoliceState();
}

class _PoliceState extends State<Police> {
  var selectedCounty, selectedType;
  final Authenticate _auth = Authenticate();
  final _policeKey = GlobalKey<FormState>();

  //text field state
  String cases = '';
  String password = '';
  String error = '';
  String idNo = "";
  String location = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffa1c1f6),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffa1c1f6),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 30.0, 15.0),
                child: Text(
                  "Police department",
                  style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                child: Container(
                  height: MediaQuery.of(context).size.height - 150.0,
                  decoration: BoxDecoration(
                      color: Color(0xffeeeeef),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75.0))),
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
                  child: Form(
                      key: _policeKey,
                      autovalidate: true,
                      child: ListView(
                        children: [
                          Column(
                            children: <Widget>[
                              Text(
                                "Welcome to the police department report page. Please submit any cases of crimes that have occurred in your area here and we shall provide the necessary services",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'ID number'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter the id number' : null,
                                onChanged: (val) {
                                  setState(() => idNo = val);
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Incident'),
                                validator: (val) => val.isEmpty
                                    ? 'Enter the incident occurred'
                                    : null,
                                onChanged: (val) {
                                  setState(() => cases = val);
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("counties")
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    Text("Loading");
                                  } else {
                                    List<DropdownMenuItem> countyItems = [];
                                    for (int i = 0;
                                        i < snapshot.data.docs.length;
                                        i++) {
                                      DocumentSnapshot snap =
                                          snapshot.data.docs[i];
                                      countyItems.add(DropdownMenuItem(
                                        child: Text(
                                          snap.id,
                                        ),
                                        value: "${snap.id}",
                                      ));
                                    }
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: 0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 5, 125, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: DropdownButton(
                                            items: countyItems,
                                            onChanged: (countyValue) {
                                              final snackBar = SnackBar(
                                                  content: Text(
                                                'Selected County value is $countyValue',
                                                style: TextStyle(
                                                    color: Color(0xff11b719)),
                                              ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                              setState(() {
                                                selectedCounty = countyValue;
                                              });
                                            },
                                            value: selectedCounty,
                                            hint: new Text(
                                              "Choose your county",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return TextFormField(
                                    decoration:
                                    textInputDecoration.copyWith(hintText: 'Failed'),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Estate, road or building'),
                                validator: (val) => val.isEmpty
                                    ? 'Enter the specific location of the crime'
                                    : null,
                                onChanged: (val) {
                                  setState(() => location = val);
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0),
                                  ),
                                  onPressed: () {
                                    if (_policeKey.currentState.validate()) {
                                      FireStoreService().addReports(idNo, cases,
                                          selectedCounty, location);
                                    }
                                  }),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
