class ToDo{
  String? id;
  String? todoText;
  bool isDone;
  
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Eat',isDone: true),
      ToDo(id: '02', todoText: 'Sleep', isDone: true),
      ToDo(id: '03', todoText: 'Conquerer',),
      ToDo(id: '04', todoText: 'Repeat',),
      ToDo(id: '05', todoText: 'Mid-Night',)

    ];
  }









}