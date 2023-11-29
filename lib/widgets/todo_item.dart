import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  final onDeleteItem;
     ToDoItem({super.key,required this.todo, required this.onToDoChanged,required this.onDeleteItem});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
         onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        leading: Icon( todo.isDone?  Icons.check_box :Icons.check_box_outline_blank,color: Colors.blue,),
        title: Text(todo.todoText!,style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          decoration: todo.isDone? TextDecoration.lineThrough : null
          
        ),
       ),
       trailing: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(horizontal: 7,vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4)
        ),
        child: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.delete_forever),
          iconSize: 18,
          onPressed: (){
              onDeleteItem(todo.id);
          },
        ),
       ),

      ),
      
    );
  }
}
