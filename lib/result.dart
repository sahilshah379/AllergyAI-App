import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Result extends StatefulWidget {
  @override
  ResultState createState() => new ResultState();
}

class ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    var item = "Sandwich";
    var probability = "0.2672";
    return new Scaffold (
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          'Image Evaluation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 40.0),
            child: CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 12.0,
              percent: double.parse(probability),
              animation: true,
              center: new Text(
                  (double.parse(probability) * 100).toStringAsFixed(2) + "%",
                style: TextStyle(
                  fontSize: 21,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Detected Food: " + item,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  Text(
                    "Probability of Allergen: " + (double.parse(probability) * 100).toStringAsFixed(2) + "%",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
