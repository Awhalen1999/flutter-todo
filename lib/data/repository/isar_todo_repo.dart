import 'package:isar/isar.dart';
import 'package:todo_flutter/data/models/isar_todo.dart';
import 'package:todo_flutter/domain/repository/todo_repo.dart';
import 'package:todo_flutter/domain/models/todo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();

    return todos.map((TodoIsar) => TodoIsar.toDomain()).toList();
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    final todoIsar = TodoIsar.fromDomain(newTodo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
