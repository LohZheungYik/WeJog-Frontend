import 'package:flutter/material.dart';
import 'package:wejog1/model/Food.dart';
import 'package:wejog1/model/mockData.dart';
import 'package:wejog1/screens/home/app_bar.dart';

List<Food> newDataList = List.from(foodDataList);

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  TextEditingController _textController = TextEditingController();
  onItemChanged(String value) {
    setState(() {
      newDataList = foodDataList
          .where((food) => food.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
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
            onChanged: onItemChanged,
          ),
          Expanded(
            child: ListView(
              
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data.name),
                  subtitle: Text(data.calories.toString() + " kcal per serving"),
                  onTap: (){
                    Navigator.of(context).pop(data);
                    
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
  }


