import 'package:flutter/material.dart';

class TotalCalorie extends StatefulWidget {
  
  final calorieSum;
  TotalCalorie({this.calorieSum});

  @override
  _TotalCalorieState createState() => _TotalCalorieState();
}

class _TotalCalorieState extends State<TotalCalorie> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(widget.calorieSum.toString() + " kCal",style:
                TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )
              ),
              Text("Consumed Today",style:
                TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            ]
          ),
        ),
      );
  }
}

class BlueInstructionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 60,
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.white,),
        title: Text("Foot Eaten Today", style: 
        TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text("tap '+' to add, long tap to remove",
      style: TextStyle(
      color: Colors.white,
      )),
     )
   );
  }
}

