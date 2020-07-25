import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wejog1/model/daily_data.dart';
import 'package:wejog1/model/user.dart';
import 'package:wejog1/screens/home/menu_drawer.dart';
import 'package:wejog1/services/dailyData_data_service.dart';
import 'package:wejog1/services/user_data_service.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:wejog1/widgets/dashboard_widgets.dart';

class Dashboard extends StatefulWidget {
  final userId, userData;
  Dashboard({this.userId, this.userData});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final userDataService = UserDataService();

  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  int _stepCountValue = 0;
  int _distanceValue = 0;
  int _calorieBurnt = 0;
  int yesterdayCount;

  get stepCount => _stepCountValue;

  int todayFootstep = 0;
  static final dateFormat = new DateFormat('yyyy-MM-dd');
  static var dateTime = DateTime.now();
  String date = dateFormat.format(dateTime);

  //User userData = new User();
  
  @override
  void initState(){
    
    super.initState();
    //getUserData();
    initPlatformState();
    
    
  }

// void getUserData() async{
//     UserDataService u = UserDataService();
//     userData = await u.getUserDetail(userId: widget.userId);
// }

Future<void> initPlatformState() async {
  startListening();
}

void onData(int stepCountValue) {
  print(stepCountValue);
}

//initialize pedometer
void startListening() {
  _pedometer = new Pedometer();
  _subscription = _pedometer.pedometerStream.listen(_onData,
  onError: _onError, onDone: _onDone, cancelOnError: true);
    
}

void stopListening() {
  _subscription.cancel();
}

//this function will be called when flutter pedometer receive a new step value
void _onData(int newValue) async {
    
  DailyDataService d = DailyDataService();
  if(yesterdayCount == null){
    yesterdayCount = await d.getPreviousFootStep(userId: widget.userId, todayDate: date);
  }
    
  setState(() {
    _stepCountValue = (newValue - yesterdayCount);
    print("$_stepCountValue = $newValue - $yesterdayCount");
    _distanceValue = (_stepCountValue * 0.76).round();
    _calorieBurnt = (_stepCountValue * 0.04).round();
  });

  DailyData dailyData = DailyData(
    userId: widget.userId,
    date: date,
    footstep: FootSteps(
      date: date,
      count: _stepCountValue,
      cummulativeCount: newValue
    ),
    distance: Distance(
      date: date,
      distanceCount: _distanceValue
    ),
    calorie: Calories(
      date: date,
      calorieCount: _calorieBurnt
    )
  );

  DailyData returnDailyData = await d.checkDataExistence(
                            userId: widget.userId,
                            date: date
  );
      
  if(returnDailyData != null){
    d.updateDailyData(id: returnDailyData.id, dailyData: dailyData);
  }else{
    d.createDailyData(dailyData: dailyData);
  }
    
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // return FutureBuilder<User>(
    //     future: userDataService.getUserDetail(userId: widget.userId),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         userData = snapshot.data;
    
    return WillPopScope(
          onWillPop: ()async => false,
          child: Scaffold(
        //key: _scaffoldKey,
        drawer: NavDrawer(userId: widget.userId, user: widget.userData),
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          title: Text("WeJog"),
        ),
        body:  Container(
          color: Colors.blueGrey[200],
          child: Center(
      
          child: Column(
            children: <Widget>[
              CircleProgressIndicator(userData: widget.userData, stepCount: stepCount),
              UseDirection(),        
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
                      SizedBox(
                        height: 15
                      ),
                      ProgressText(
                        progressText: "$_distanceValue out of ${widget.userData.distanceGoal} m jogged",
                      ),
                      ProgressBar(
                        progressColor: Colors.teal,
                        percent: _distanceValue / widget.userData.distanceGoal,
                      ),
                      SizedBox(
                        height: 15
                      ),
                      ProgressText(
                        progressText: "$_calorieBurnt out of ${widget.userData.calorieGoal} kCal burnt through jogging",
                      ),
                      ProgressBar(
                        progressColor: Colors.pinkAccent,
                        percent: _calorieBurnt / widget.userData.calorieGoal,
                      ),
                      SizedBox(
                        height: 15
                      ),
                    ],
                  )
                )
              ]
            ),
          ),
         ],
        )
       ),
      ),
    );
  // }
  //   return _buildFetchingDataScreen();
  // });
  }

  Scaffold _buildFetchingDataScreen() {
    Timer(
      Duration(seconds: 10),
      () async{
        if(yesterdayCount != null){
          setState(() {
            
          });
        } 
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            yesterdayCount == null?Text('Fetching user data... Please wait'):Text("Updating step counter value... please wait"),
          ],
        ),
      ),
    );
  }
}

