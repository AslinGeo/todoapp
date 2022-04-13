

import 'package:todoo/repo.dart';
import 'package:todoo/todomodal.dart';

class TodoService{
 late Repo _repo;
 TodoService(){
   _repo=Repo();
 }

 saveTodo(Todo todo) async{
  //  print(todo);
   return await _repo.insertData('Todo', todo.todoMap());

 }

 readAllTodo() async{
   return await _repo.readData('Todo');
 }
//  deleteTodo(todoId) async{
//   return await _repo.deleteData('Todo', todoId);
//  }
updateTodo(Todo todo) async{
  return await _repo.updateData('Todo', todo.todoMap());
}
}