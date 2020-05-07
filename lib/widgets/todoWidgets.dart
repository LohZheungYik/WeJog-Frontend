import 'package:flutter/material.dart';
import 'package:wejog1/model/mockData.dart';

class TodoList extends StatefulWidget {
  
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mockTodo.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(mockTodo[index].title),
              subtitle: Text(mockTodo[index].shortNotes),
              onTap: (){
                showEditDialog(context, index, "Edit task");
              },
              onLongPress: (){
                mockTodo.removeAt(index);
                setState(() {
                  
                });
              },
              trailing: mockTodo[index].completed?Icon(Icons.check):Icon(Icons.error),
            )
          );
        }
      );
  }

  Future <String> showEditDialog(BuildContext context, int index, String instruction){
    TextEditingController titleController = new TextEditingController();
    TextEditingController noteController = new TextEditingController();
    titleController.text = mockTodo[index].title;
    noteController.text = mockTodo[index].shortNotes;
    

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
              ListTile(
                title: Text("Completed"),
                trailing: Switch( 
                  value: mockTodo[index].completed, 
                  onChanged: (value) { 
                  setState(() { 
                    mockTodo[index].completed = value; 
                  }); 
                 }, 
                ),
              ), 

            ],   
          ),
        ),
      actions: <Widget>[
        MaterialButton(
          child: Text("OK"),
          color: Colors.blue,
          onPressed: (){
            mockTodo[index].title = titleController.text;
            mockTodo[index].shortNotes = noteController.text;
            
            Navigator.of(context).pop();
            setState(() {});
          }
         )
       ],
     );
   });
  }
}