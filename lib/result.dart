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
    var item = "Omelette";
    var allergen = "Egg";
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
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 72.0, 24.0, 0.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 10.0,
                        percent: double.parse(probability),
                        animation: true,
                        center: new Text(
                          (double.parse(probability) * 100).toStringAsFixed(0) + "%",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).accentColor,
                        backgroundColor: Color(0xffCCCCCC),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 50.0),
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.circle,
                                size: 16,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            TextSpan(
                              text: "  Probability that the image contains your allergen(s)",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0.0),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        TextSpan(
                          text: "  Detected Food: " + item,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        TextSpan(
                          text: "  Probability of Allergen: " + (double.parse(probability) * 100).toStringAsFixed(2) + "%",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
