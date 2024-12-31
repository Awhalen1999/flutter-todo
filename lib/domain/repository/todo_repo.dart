// define app functions here

import 'package:todo_flutter/domain/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo newTodo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}
