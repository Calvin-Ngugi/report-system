import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_system/screens/home_screen/about.dart';
import 'package:report_system/screens/home_screen/fire.dart';
import 'package:report_system/screens/home_screen/latest%20info.dart';
import 'package:report_system/screens/home_screen/police.dart';
import 'package:report_system/screens/home_screen/help.dart';
import 'package:report_system/services/auth/auth.dart';
import 'package:report_system/services/auth/database.dart';
import 'package:provider/provider.dart';
import 'package:report_system/models/repo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'hospital.dart';

class Home extends StatelessWidget {
  final Authenticate _auth = Authenticate();

  @override
  Widget build(BuildContext context) {
    String name = "Quinn";
    String email = "quinn@yahoo.com";
    return StreamProvider<List<Report>>.value(
      value: DatabaseService().reports,
      child: Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Report System",
              style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic)
          ),
          elevation: 0.0,
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text(name),
                  accountEmail: new Text(email),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://i.pravatar.cc/150?img=12"),
                ),
              ),
              AboutListTile(
                applicationName: "Report System",
                applicationVersion: "0.0.1",
                applicationIcon: Icon(
                    Icons.warning_amber_sharp,
                  color: Colors.red,
                ),
                child: Text("About"),
              ),
              new ListTile(
                title: new Text("News"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => News())
                  );
                },
              ),
              new ListTile(
                title: new Text("Help"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
                },
              ),
              new ListTile(
                title: new Text("Logout"),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Police()));
                },
                child: Container(
                  child: FittedBox(
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: myDetailsContainer1(),
                              ),
                            ),
                          Container(
                            width: 250,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child:
                              Image(
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/cop dep.png"),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hospital()));
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: myDetailsContainer4(),
                                ),
                              ),
                            Container(
                              width: 250,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topRight,
                                  image: AssetImage(
                                      "assets/hospital.jpg"),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Fire()));
                  },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: myDetailsContainer3(),
                                ),
                              ),
                            Container(
                              width: 250,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topRight,
                                  image: AssetImage(
                                      "assets/fire dep.jpg"
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Police",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.3",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(321) \u00B7 0.9 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Report cases of crime here",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
          ),
        ),),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Fire Brigade",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                "4.0",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(100) \u00B7 2.0 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Report in case of fire emergency",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget myDetailsContainer4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Hospital",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                "3.5",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(50) \u00B7 2.5 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Report cases of accidents",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),),
        Container(
            child: Text(
              "and disease outbreaks",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
      ],
    );
  }
}
