import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CircleProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 200.0,
      lineWidth: 30.0,
      percent: 0.7,
      center: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("70%", 
              style: TextStyle(
                fontSize: 45,
                  fontWeight: FontWeight.bold,
                )
              ),
              Text("7000/10000 steps")
          ],
         ),
        ),
        progressColor: Colors.green,
      );
    }
}

class ProgressBar extends StatelessWidget {
  final percent, progressColor;
  ProgressBar({this.percent, this.progressColor});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children : <Widget>  [
      LinearPercentIndicator(
        width: 240.0,
        lineHeight: 14.0,
        percent: percent,
        backgroundColor: Colors.grey,
        progressColor: progressColor,
      ),
                      
     ]
    );
  }
}

class ProgressText extends StatelessWidget {
  final progressText;
  ProgressText({this.progressText});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(progressText),
      ],
    );
  }
}

class DailyTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        border: Border.all(
          width: 3,
          color: Colors.blue[900],   
        ),
        borderRadius: BorderRadius.all(
           Radius.circular(30),
        )
       ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Icon(
              Icons.lightbulb_outline, color: Colors.blue[900],
            ),
            Text("Daily Exercise Fact", style:
              TextStyle(
                color:  Colors.blue[900],
                fontWeight: FontWeight.bold,
               )
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text("Jogging can increase physical fitness and reduce stress", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[900],
              ),
            )
          ),
         ],
        )
      ],
     )
   );
  }
}

class LineGraph extends StatelessWidget {
  
  final dataSeries, lineData, title, color;
  LineGraph({this.dataSeries, this.lineData, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
                 
      constraints: BoxConstraints.expand(height:50),
      child: Container(
        color: color,
        child: charts.TimeSeriesChart(
          dataSeries,
          defaultRenderer: new charts.LineRendererConfig(
            includeArea: true, stacked: true
          ),
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
          //x axis text
          domainAxis: charts.DateTimeAxisSpec(
          tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
          [
            charts.TickSpec<DateTime>(lineData[0].date),
            charts.TickSpec<DateTime>(lineData[lineData.length-1].date),
          ]
         ),
         tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
         day: charts.TimeFormatterSpec(
            format: 'dd MMM',
            transitionFormat: 'dd MMM',
         )
        )
       ),
       animationDuration: Duration(seconds: 1),
       //chart labels
       behaviors: [
         new charts.ChartTitle(
           'Date',
           behaviorPosition: charts.BehaviorPosition.bottom,
           titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
          new charts.ChartTitle(
            title,
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
         ]
       ),
      ),
     ),
   );
  }
}