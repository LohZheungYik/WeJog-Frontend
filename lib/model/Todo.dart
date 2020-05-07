class Todo{
  String _title;
  bool _completed;
  String _shortNotes;
  Todo(this._title, this._shortNotes, this._completed);
  
  set title(String t) => _title = t;
  set completed(bool c) => _completed = c;
  set shortNotes(String n) => _shortNotes = n;

  String get title{
    return _title;
  }

  bool get completed{
    return _completed;
  }
  
  String get shortNotes{
    return _shortNotes;
  }
  
}