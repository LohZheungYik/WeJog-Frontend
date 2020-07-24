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
        itemCount: widget.todoList.length + 1,
        itemBuilder: (context, index){
          if(index == 0){
            return BlueInstructionBar();
          }else{
           return Card(
            child: InkWell(
                onDoubleTap: ()async{
                  Todo returnTodo = await showEditDialog(context, index - 1, "Edit task");
                  if(returnTodo != null){
                    setState(() {
                      widget.todoList[index - 1] = returnTodo;
                    });
                  }
                },
                child: ListTile(
                title: Text(widget.todoList[index - 1].title),
                subtitle: Text(widget.todoList[index - 1].shortNotes),
                onTap: ()async{
                  var newStatus;
                  widget.todoList[index - 1].completed? newStatus = false: newStatus = true;
                  Todo todo = Todo(
                    completed: newStatus,
                    id: widget.todoList[index - 1].id
                  );
                  Todo returnTodo = await t.updateTodoStatus(todo: todo);
                  if(returnTodo!= null){
                    setState(() {
                      widget.todoList[index - 1].completed = returnTodo.completed;
                    });
                  }
                },
                onLongPress: (){
                  t.deleteTodo(id: widget.todoList[index - 1].id);
                  widget.todoList.removeAt(index - 1);
                  setState(() {
                    
                  });
                },
                trailing: widget.todoList[index - 1].completed?Icon(Icons.check):Icon(Icons.error),
              ),
            )
          );
         }
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
          height: 170,
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

class BlueInstructionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 60,
      child: ListTile(
        leading: Icon(Icons.info, color: Colors.white,),
        
      subtitle: Text("tap to update status\ndouble tap to edit todo\nlong tap to remove",
      style: TextStyle(
      color: Colors.white,
      )),
     )
   );
  }
}