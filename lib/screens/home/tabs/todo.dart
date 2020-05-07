import 'package:flutter/material.dart';
import 'package:wejog1/model/Todo.dart';
import 'package:wejog1/model/mockData.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/widgets/todoWidgets.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: WeJogAppBars.todoAppBar(context, "Todo List", showAddDialog, "Add new task"),
      body: TodoList(),
    );
  }

  Future <String> showAddDialog(BuildContext context, String instruction){
    TextEditingController titleController = new TextEditingController();
    TextEditingController noteController = new TextEditingController();
    
    return showDialog(context: context, builder: (context){
      
      return AlertDialog(
        title: Text(instruction),
        content: SizedBox(
          
          child: Column(
            children: <Widget>[
              TextField(
                
                decoration: InputDecoration(
                  hintText: "name",
                ),
                controller: titleController,
                
              ),
              TextField(
                
                decoration: InputDecoration(
                  hintText: "side notes",
                ),
                controller: noteController,
                
                
              ),

            ],   
          ),
        ),
      actions: <Widget>[
        MaterialButton(
          child: Text("OK"),
          color: Colors.blue,
          onPressed: (){
            Todo newTodo = new Todo(null, null, false);
            newTodo.title = titleController.text;
            newTodo.shortNotes = noteController.text;
            mockTodo.add(newTodo);
            

            Navigator.of(context).pop();
            setState(() {});
          }
         )
       ],
     );
   });
  }
}

