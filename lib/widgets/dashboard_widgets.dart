import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

//dashboard screen step goal circle progress indicator
class CircleProgressIndicator extends StatefulWidget {
  final state, userData, stepCount;
  CircleProgressIndicator({this.state, this.userData, this.stepCount});

  @override
  _CircleProgressIndicatorState createState() => _CircleProgressIndicatorState();
}

class _CircleProgressIndicatorState extends State<CircleProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    
    int percentage = ((widget.stepCount/widget.userData.stepGoal)*100).round();
    double percentageDecimal = percentage/100;

    return CircularPercentIndicator(
      radius: 200.0,
      lineWidth: 30.0,
      percent: percentageDecimal > 1 || percentageDecimal < 0?1:percentageDecimal, //prevent error if the step number exceeded the goal 
      center: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(percentage.toString() + "%", //percentage text at the center of circle
              style: TextStyle(
                fontSize: 45,
                  fontWeight: FontWeight.bold,
                )
              ),
              //Text("7000/10000 steps")
              Text(widget.stepCount.toString() + "/${widget.userData.stepGoal} steps") //step progress text
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
        percent: percent > 1|| percent < 0?1:percent,
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

class UseDirection extends StatelessWidget {
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
            Text("Direction of use", style:
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
              child: Text("The step counter will update when jog with your accelerometer-enabled smartphone", 
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
