import 'package:flutter/material.dart';
import 'package:wejog1/model/Health.dart';
import 'package:wejog1/model/mockData.dart';
import 'package:wejog1/screens/home/menuDrawer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wejog1/widgets/dashboxIndexWidget.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
 //data list for line graph
  List<charts.Series<FootSteps, DateTime>> _seriesFootStepsLineData;
  List<charts.Series<ActiveMinutes, DateTime>> _seriesActiveMinutesLineData;
  List<charts.Series<Distance, DateTime>> _seriesDistanceLineData;
  List<charts.Series<Calories, DateTime>> _seriesCaloriesLineData;
   

  //load mock data to line graph data list
  _generateData(){
    
    _seriesFootStepsLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Foot Step',
        data: lineFootStepsData,
        domainFn: (FootSteps footSteps, _) => footSteps.date,
        measureFn: (FootSteps footSteps, _) => footSteps.count,
    )
  );
 
  _seriesActiveMinutesLineData.add(
     charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Active Minutes',
        data: lineActiveMinutesData,
        domainFn: (ActiveMinutes activeMinutes, _) => activeMinutes.date,
        measureFn: (ActiveMinutes activeMinutes, _) => activeMinutes.minutes,
    )
  );

  _seriesDistanceLineData.add(
     charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Distance',
        data: lineDistanceData,
        domainFn: (Distance distance, _) => distance.date,
        measureFn: (Distance distance, _) => distance.distanceCount,
    )
  );

  _seriesCaloriesLineData.add(
     charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Active Minutes',
        data: lineCaloriesData,
        domainFn: (Calories calories, _) => calories.date,
        measureFn: (Calories calories, _) => calories.calorieCount,
    )
  );
}

  
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Logged in successfully! Welcome!'))));
    _seriesFootStepsLineData = List<charts.Series<FootSteps, DateTime>>();
    _seriesActiveMinutesLineData = List<charts.Series<ActiveMinutes, DateTime>>();
    _seriesDistanceLineData = List<charts.Series<Distance, DateTime>>();
    _seriesCaloriesLineData = List<charts.Series<Calories, DateTime>>();
    
    _generateData();
    
}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("WeJog"),
      ),
      body:  Container(
        color: Colors.blueGrey[200],
        child: Center(
    
        child: Column(
          children: <Widget>[
            CircleProgressIndicator(),
            DailyTip(),        
          ],
        )
    ),
      ),
      bottomNavigationBar: SizedBox(
        height: 250.0,
        child: PageView(
        children: <Widget>[
          //daily summary progress bars
          Container(
                width: screenSize.width,
                height: 20,
                child: Column(
                  children: <Widget> [
                    Container(
                      height: 50,
                      color: Colors.blueAccent,
                      child: ListTile(
                        leading: Icon(Icons.accessibility_new, color: Colors.white,),
                        title: Text("Daily Excercise Summary", style: 
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                      ),
                    ),
                    Container(
                color: Colors.orange,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  
                    SizedBox(height: 25),
                    ProgressText(
                      progressText: "45 out of 120 minutes exercised",
                    ),
                    ProgressBar(
                      progressColor: Colors.blue,
                      percent: 0.38,
                    ),
                    SizedBox(
                      height: 15
                    ),
                    ProgressText(
                      progressText: "5000 out of 12000m jogged",
                    ),
                    ProgressBar(
                      progressColor: Colors.teal,
                      percent: 0.42,
                    ),
                    SizedBox(
                      height: 15
                    ),
                    ProgressText(
                      progressText: "500 out of 2500kcal calories burnt",
                    ),
                    ProgressBar(
                      progressColor: Colors.pinkAccent,
                      percent: 0.2,
                    ),
                    SizedBox(
                      height: 15
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios
                        ),
                        Text("Swipe to view statistics"),
                      ],
                    ),
                  ],
                )
              )
            ]
          ),
        ),
        LineGraph(
          dataSeries: _seriesFootStepsLineData,
          lineData: lineFootStepsData,
          title: "Footstep count",
          color: Colors.lime,
        ),
        LineGraph(
          dataSeries: _seriesActiveMinutesLineData,
          lineData: lineActiveMinutesData,
          title: "Active Minutes (min)",
          color: Colors.lightBlue,
        ),
        LineGraph(
          dataSeries: _seriesDistanceLineData,
          lineData: lineDistanceData,
          title: "Distance (m)",
          color: Colors.deepPurple[200],
        ), 
        LineGraph(
          dataSeries: _seriesCaloriesLineData,
          lineData: lineCaloriesData,
          title: "Calories burnt (kCal)",
          color: Colors.green[200],
        ),    
       ],
      )
     ),
    );
  }
}

