import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  
  @override
  void initState() {
   _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBFColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                        child: Center(
                          child: Text(
                            'To Do List',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      
                    ),
                    for (ToDo todo in _foundToDo.reversed) ToDoItem(todo: todo,
                    onToDoChanged : _handleToDoChange,
                    onDeleteItem :_handleToDeleteItem
                    )
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                    
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  
                  margin: EdgeInsets.only(bottom: 22,right: 20),
                  padding: EdgeInsets.zero,
                  child: ElevatedButton(
                    
                    child: Text('+',style: TextStyle(
                    fontSize: 43,
                    ),
                  ),
                  onPressed: (){
                        _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    minimumSize: Size(50, 10),
                    elevation: 10,
                    
                  )

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
  setState(() {
    todo.isDone = !todo.isDone;
  });
    
  }
  void _handleToDeleteItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String enteredKeyword){
      List<ToDo> result = [];
      if(enteredKeyword.isEmpty){
        result = todosList;
      }
      else{
        result = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      }
    setState(() {
      _foundToDo = result;
    });
  }
  void _addToDoItem(String toDo){
   setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo
    ));
   });
   _todoController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 24),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: tdBFColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/avatar.png')),
            )
          ],
        ));
  }
}
