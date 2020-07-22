import 'package:flutter/material.dart';
import 'package:wejog1/model/todo.dart';
import 'package:wejog1/services/todo_data_service.dart';

class TodoList extends StatefulWidget {
  final todoList;
  TodoList({this.todoList});
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoDataService t = TodoDataService();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(widget.todoList[index].title),
              subtitle: Text(widget.todoList[index].shortNotes),
              onTap: ()async{
                Todo returnTodo = await showEditDialog(context, index, "Edit task");
                if(returnTodo != null){
                  setState(() {
                    widget.todoList[index] = returnTodo;
                  });
                }
              },
              onLongPress: (){
                t.deleteTodo(id: widget.todoList[index].id);
                widget.todoList.removeAt(index);
                setState(() {
                  
                });
              },
              trailing: widget.todoList[index].completed?Icon(Icons.check):Icon(Icons.error),
            )
          );
        }
      );
  }

  //edit todo popup box
  Future <Todo> showEditDialog(BuildContext context, int index, String instruction){
    TextEditingController titleController = new TextEditingController();
    TextEditingController noteController = new TextEditingController();
    titleController.text = widget.todoList[index].title;
    noteController.text = widget.todoList[index].shortNotes;
    bool status = widget.todoList[index].completed;
    TodoDataService t = TodoDataService();

    return showDialog(context: context, builder: (context){
      
      return AlertDialog(
        title: Text(instruction),
        content: SizedBox(
          height: 200,
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
              ListTile(
                title: Text("Completed"),
                trailing: Switch( 
                  value: widget.todoList[index].completed, 
                  onChanged: (value) {  
                    status = value;
                 }, 
                ),
              ), 

            ],   
          ),
        ),
      actions: <Widget>[
        MaterialButton(
          child: Text("Save"),
          color: Colors.blue,
          onPressed: () async {
            widget.todoList[index].title = titleController.text;
            widget.todoList[index].shortNotes = noteController.text;
            
            Todo updatedTodo = Todo(
              title: widget.todoList[index].title,
              shortNotes: widget.todoList[index].shortNotes,
              completed: status,
              id: widget.todoList[index].id
            );
            
            Todo todo = await t.updateTodo(todo: updatedTodo);
            Navigator.of(context).pop(todo);
          }
         )
       ],
     );
   });
  }
}