
import 'package:flutter/material.dart';
import 'package:wejog1/model/Food.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/screens/home/tabs/searchFood.dart';
import 'package:wejog1/widgets/calorieTrackerWidgets.dart';

List<Food>eatenFood = [];

class CalorieTracker extends StatefulWidget {
  
  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  void navigateToSearch() async{
    Food returnFood = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Search()
      ));
    
    bool exist = false;
    if(returnFood != null){
      
      for(int i=0; i<eatenFood.length; i++){
        if(eatenFood[i].name == returnFood.name){
          exist = true;
        }else{
          continue;
        }
      }

      
      if(!exist){
        setState(() {
          returnFood.serving = 1;
          
          eatenFood.add(returnFood);
          calculateTotalCalorie();
        });
      }else{
        returnFood.serving++;
      }
       
    }
  }

    double calculateTotalCalorie(){
      double total = 0;
      setState(() {
        for(int i=0; i<eatenFood.length; i++){
        total += eatenFood[i].calories*eatenFood[i].serving;
      }
      });
      
      return total;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeJogAppBars.calorieAppBar(context, navigateToSearch),
      body: TotalCalorie(calorieSum: calculateTotalCalorie(),),
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
                    subtitle: Text(eatenFood[index].serving.toString()+ " serving(s) consumed"),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                        children: <Widget>[
                          IconButton(
                            onPressed: (){
                              eatenFood[index].serving++;
                              calculateTotalCalorie();
                              setState(() {
                                
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: (){
                              if (eatenFood[index].serving > 0) eatenFood[index].serving--;
                              calculateTotalCalorie();
                              setState(() {});
                            },
                            icon: Icon(Icons.remove),
                          ),
                      ],
                    ),     
                  );
                },
              )
              )
            ]
          ),
        )
      ),
    );
  }
}