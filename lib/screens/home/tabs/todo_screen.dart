import 'package:flutter/material.dart';
import 'package:wejog1/model/todo.dart';
import 'package:wejog1/services/todo_data_service.dart';
import 'package:wejog1/widgets/loading_screen.dart';
import 'package:wejog1/widgets/todo_widgets.dart';

class TodoScreen extends StatefulWidget {
  final userId;
  TodoScreen({this.userId});
  
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todoList = List<Todo>();
  TodoDataService t = TodoDataService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: t.getTodoList(userId: widget.userId),
      builder: (context, snapshot){
        if(snapshot.hasData){
          todoList = snapshot.data;
          return WillPopScope(
              onWillPop: ()async => false,
                  child: Scaffold(
              appBar: AppBar(
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
              onPressed: () async{
                Todo returnTodo = await showAddDialog(context, "Add new note");
                setState(() {
                  todoList.add(returnTodo);
                });
              }
            )
        ],
            ),
            body: TodoList(todoList: todoList,),
        ),
          );
       }
    
       return LoadingScreen();
      }
    );
  }

  Future <Todo> showAddDialog(BuildContext context, String instruction){
    TextEditingController titleController = new TextEditingController();
    TextEditingController noteController = new TextEditingController();
    
    return showDialog(context: context, builder: (context){
      
      return AlertDialog(
        title: Text(instruction),
        content: SizedBox(
          height: 150,
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
          onPressed: () async{
            Todo newTodo = new Todo(
              title: titleController.text,
              shortNotes: noteController.text,
              userId: widget.userId,
              completed: false
            );

            TodoDataService todoDataService = new TodoDataService();
            Todo returnTodo = await todoDataService.createTodo(todo: newTodo);
           
            Navigator.of(context).pop(returnTodo);
            //setState(() {});
          }
         )
       ],
     );
   });
  }
}



