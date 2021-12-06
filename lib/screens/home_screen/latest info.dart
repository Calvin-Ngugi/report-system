import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:report_system/animation/ScaleRoute.dart';

class News extends StatefulWidget {
  @override
  final Widget child;

   News({Key key, this.child}) : super(key: key);
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
    var piedata = [
      new Task('Nairobi', 34.8, Color(0xff3366cc)),
      new Task('Uasin Gishu', 8.3, Color(0xff990099)),
      new Task('Nakuru', 12.8, Color(0xff109618)),
      new Task('Mombasa', 15.6, Color(0xfffdbe19)),
      new Task('Kiambu', 18.2, Color(0xffff9900)),
      new Task('Kisumu', 10.3, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News"),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRect(
                    child: Image.asset("assets/virus.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus. Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.\n",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                      "The virus that causes COVID-19 is mainly transmitted through droplets generated when an infected person coughs, sneezes, or exhales.\n These droplets are too heavy to hang in the air, and quickly fall on floors or surfaces. You can be infected by breathing in the virus if you are within close proximity of someone who has COVID-19, or by touching a contaminated surface and then your eyes, nose or mouth.",
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1.0, 20.0, 3.0, 10.0),
            child: Container(
              height: 350,
              width: 300,
              child: Column(
                children: <Widget>[
                  Text(
                    'Crime rates in different counties',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  Expanded(
                    child: charts.PieChart(
                        _seriesPieData,
                        animate: true,
                        animationDuration: Duration(seconds: 5),
                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification: charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.MaterialPalette.purple.shadeDefault,
                                fontFamily: 'Georgia',
                                fontSize: 11),
                          )
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 100,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside
                              ),
                            ])),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            height: 300,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Mwl(),
                Expanded(
                  child: MostWanted(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Bounties extends StatelessWidget {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;

  Bounties(
      {Key key,
        @required this.name,
        @required this.imageUrl,
        @required this.rating,
        @required this.numberOfRating,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.topRight,
                              width: double.infinity,
                              padding: EdgeInsets.only(right: 5, top: 5),
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFfae3e2),
                                        blurRadius: 25.0,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.asset(
                                  'assets/' +
                                      imageUrl ,
                                  width: 130,
                                  height: 140,
                                )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(right: 5),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFfae3e2),
                                      blurRadius: 25.0,
                                      offset: Offset(0.0, 0.75),
                                    ),
                                  ]),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xFFfb3132),
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: Text(rating,
                                    style: TextStyle(
                                        color: Color(0xFF6e6e71),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3, left: 5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFFfb3132),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFFfb3132),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFFfb3132),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFFfb3132),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFF9b9b9c),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: Text("($numberOfRating)",
                                    style: TextStyle(
                                        color: Color(0xFF6e6e71),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class Mwl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Most Wanted List",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class MostWanted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Bounties(
            name: "Marshall D Teach",
            imageUrl: "marshall.jpg",
            rating: '4.9',
            numberOfRating: '200',

            ),
        Bounties(
            name: "Dracule Mihawk",
            imageUrl: "mihawk.jpg",
            rating: "4.9",
            numberOfRating: "100",
            ),
        Bounties(
            name: "Roronoa Zoro",
            imageUrl: "zoro.jpeg",
            rating: "4.0",
            numberOfRating: "50",
            ),
        Bounties(
            name: "Crocodile",
            imageUrl: "crocodile.jpeg",
            rating: "4.00",
            numberOfRating: "100",
            ),
      ],
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}