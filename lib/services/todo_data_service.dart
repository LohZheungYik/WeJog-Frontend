import 'package:wejog1/model/todo.dart';
import './rest_service.dart';

class TodoDataService {

  static final TodoDataService _instance = TodoDataService._constructor();
  factory TodoDataService() {
    return _instance;
  }

  TodoDataService._constructor();
  final rest = RestService();

  Future<Todo> createTodo({Todo todo}) async {
    final json = await rest.post('reminders', data: todo);
    return Todo.fromJson(json);
  }

  Future<Todo> getTodo({String id}) async{
    final todo = await rest.get('reminders/$id');

    return Todo.fromJson(todo);
  }

  Future<List<Todo>> getTodoList({String userId}) async {
    final listJson = await rest.get('reminders');
    List<Todo>userTodoList = List<Todo>();
    if(listJson != null){
      
      List<Todo> todoList = (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId))?Todo.fromJson(itemJson):null)
        .toList();

      

      for(int i=0; i<todoList.length; i++){
        if(todoList[i] != null){
          userTodoList.add(todoList[i]);
        }else{
          continue;
        }
      }

      
    }
    return userTodoList;
  }

  Future<Todo> updateTodo({Todo todo}) async {
    String id = todo.id;
    
    final json = await rest.patch('reminders/$id', data: {
      'shortNotes': todo.shortNotes,
      'title': todo.title
    });
    
    return Todo.fromJson(json);
  }

    Future<Todo> updateTodoStatus({Todo todo}) async {
    String id = todo.id;
    
    final json = await rest.patch('reminders/$id', data: {
      'completed': todo.completed
    });
    
    return Todo.fromJson(json);
  }

 void deleteTodo({String id}) async {
    final json = await rest.delete('reminders/$id');
    
  }

  
}
