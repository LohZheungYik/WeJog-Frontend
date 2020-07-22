
import 'package:flutter/material.dart';
import 'package:wejog1/model/serving.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/screens/home/tabs/search_food.dart';
import 'package:wejog1/services/calorie_data_service.dart';
import 'package:wejog1/widgets/calorie_tracker_widgets.dart';
import 'package:wejog1/widgets/loading_screen.dart';


class CalorieTracker extends StatefulWidget {
  final userId;
  CalorieTracker ({this.userId});

  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  CalorieDataService c = CalorieDataService();
  List<Serving>eatenFood = [];

  void navigateToSearch() async{
    Serving returnFood = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Search(userId: widget.userId)
      ));
    
    bool exist = false;
    Serving existingFood = Serving();
    int existingIndex = 0; 

    if(returnFood != null){
      for(int i=0; i<eatenFood.length; i++){
        if(eatenFood[i].name == returnFood.name){
          existingFood = eatenFood[i];
          existingIndex = i;
          exist = true;
        }else{
          continue;
        }
      }
      Serving postResponse = Serving();
      
      if(!exist){
        setState(() {
          returnFood.number = 1;
        });
        
        postResponse = await c.createServingRecord(serving: returnFood);

        setState(() {
          returnFood.id = postResponse.id;
          print(postResponse.id);
          eatenFood.add(returnFood);
          calculateTotalCalorie();
        });
          
      }else{
        showDialog(context: context, builder: (context){
          return FoodExistedDialog();
        });
      }
    }
  }

  double calculateTotalCalorie(){
    double total = 0;
    for(int i=0; i<eatenFood.length; i++){
      total += eatenFood[i].number*eatenFood[i].calorie;
    }
      
    return total;
  }

  double displayCalorie(){
    double total = 0;
    for(int i=0; i<eatenFood.length; i++){
      total += eatenFood[i].number*eatenFood[i].calorie;
    }
      
    return total;
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    return FutureBuilder<List<Serving>>(
      future: c.getAllServings(userId: widget.userId, date: date),
      builder: (context, snapshot){
        if(snapshot.hasData){
          eatenFood = snapshot.data;
         return WillPopScope(
          onWillPop: ()async => false,
                    child: Scaffold(
      appBar: WeJogAppBars.calorieAppBar(context, navigateToSearch),
       body: TotalCalorie(calorieSum: displayCalorie(),),
      bottomNavigationBar: SizedBox(
        height: 400,
        child: Container(   
            child: Column(
              children: <Widget>[
                BlueInstructionBar(),
                Container(
                  height: 340,
                  child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey,
                  ),
                  itemCount: eatenFood.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(eatenFood[index].name),
                      subtitle: Text(eatenFood[index].number.toString()+ " serving(s) consumed"),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              onPressed: () async{
                                eatenFood[index].number++;
                                calculateTotalCalorie();
                                await c.updateServingRecord(id: eatenFood[index].id, serving: eatenFood[index]);
                                setState(() {});
                              },
                              icon: Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: () async{
                                if (eatenFood[index].number > 0) eatenFood[index].number--;
                                calculateTotalCalorie();
                                await c.updateServingRecord(id: eatenFood[index].id, serving: eatenFood[index]);
                                setState(() {});
                              },
                              icon: Icon(Icons.remove),
                            ),
                        ],
                      ),
                      onLongPress: () async{
                        await c.deleteServingRecord(id: eatenFood[index].id);
                        eatenFood.removeAt(index);
                         setState(() {
                          
                         });
                      },     
                    );
                  },
                )
                )
              ]
            ),
        )
      ),
    ),
         );
  }
  return LoadingScreen();
});
}}

