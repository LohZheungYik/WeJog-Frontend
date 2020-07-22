//Todo class

class Todo{
  String title;
  bool completed;
  String shortNotes;
  String id, userId;
  Todo({this.title, this.shortNotes, this.completed, this.id, this.userId});
  
  Todo.fromJson(Map<String, dynamic> json)
      :this(
        title: json['title'],
        completed: json['completed'],
        shortNotes: json['shortNotes'],
        id: json['id'],
        userId: json['userId']
  );

  Map<String, dynamic> toJson() =>
      {
        'title': title, 
        'completed': completed, 
        'shortNotes': shortNotes,
        'userId': userId
      };
}