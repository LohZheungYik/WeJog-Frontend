
import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/tabs/bloodPressureStatistic.dart';

class WeJogAppBars{
  static AppBar backBtnAppBar(BuildContext context, String titleText){
    return AppBar(
        backgroundColor: Colors.green[500],
        title: Text(titleText),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        
      );
  }

  static AppBar todoAppBar(BuildContext context, String titleText, Function function, String instruction){
    return AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Todo List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ), 
            onPressed: (){
              function(context, instruction);
            }
          )
        ],
      );
  }

  static AppBar calorieAppBar(BuildContext context, Function function){
    return AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Calorie Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              function();
            }
          )
        ],
      );
  }

   static AppBar bloodPressureAppBar(BuildContext context, Function addBpRecordNavFunc){
     return AppBar(
        backgroundColor: Colors.green,
        title: Text("Blood Pressure Tracker", style: 
          TextStyle(
            fontSize: 13
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.equalizer),
            onPressed: (){
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BloodPressureStatistic()),
            );
            },
          ),
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              addBpRecordNavFunc();
            }
          )
        ],
      );
   }
}