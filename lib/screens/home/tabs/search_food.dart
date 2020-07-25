import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wejog1/model/food.dart';
import 'package:wejog1/model/serving.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/services/foodApi_search_data_service.dart';

List<Food> foodList = [Food("", [])];
List<Food> dispList = [Food("", [])];


class Search extends StatefulWidget {
  final userId;
  Search({this.userId});
  
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  TextEditingController _textController = TextEditingController();
  
  Serving addFood(Food food) {
    Serving serving = Serving();
    serving.name = food.name;
    var dateTime = DateTime.now();
    serving.date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    serving.userId = widget.userId;
    serving.calorie = food.calories;
    serving.servingId = serving.userId + serving.date;
    
    return serving;
  }
  
  //search Food API
  search(String value) async{
    createSavingDialog(context);
    FoodApiSearchDataService fs = FoodApiSearchDataService();
    foodList = await fs.getFoodSearchResults(value.toUpperCase());

    setState((){
      //load food calorie value
      for(int i=0; i<foodList.length; i++){
        for(int j=0; j<(foodList[i].nutritions).length; j++){
          if((foodList[i].nutritions[j]['unitName']) == "KCAL"){
            foodList[i].calories = foodList[i].nutritions[j]['value'];
          }
        }
      }

      dispList = foodList.toList();

    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WeJogAppBars.backBtnAppBar(context, "Add a consumed food"),
        body: Column(
    children: <Widget>[
      TextField(
        controller: _textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0,0,0),
          hintText: 'Type here to search',
        ),
      ),
      MaterialButton(
        color: Colors.blueAccent,
        onPressed: (){
          search(_textController.text);
        },
        child: Text("Search", style: TextStyle(
          color: Colors.white
        ),),
      ),
      Expanded(
        child: SizedBox(
        height: 340,
        child: ListView.builder(
                      
        itemCount: dispList.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(dispList[index].name),
            subtitle: dispList[index].name != ""? 
              Text(dispList[index].calories.toString() + " kCal per serving"): 
              Text(""),
            onTap: (){
              Serving s = addFood(dispList[index]);
              Navigator.of(context).pop(s);
            },
          );
        }
      ),
    ),
        )
      ],
  ),
);
}

Future <String> createSavingDialog(BuildContext context){
    Timer(
      Duration(seconds: 2),
      () async{
         Navigator.of(context).pop();
      },
    );
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              CircularProgressIndicator(),
              Text("Searching... Please Wait")
            ]
          ),
        ),
      );

    });
  }


}


