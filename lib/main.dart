import 'package:flutter/material.dart';
import 'package:todo_flutter/data/models/isar_todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_flutter/data/repository/isar_todo_repo.dart';
import 'package:todo_flutter/domain/repository/todo_repo.dart';
import 'package:todo_flutter/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  final isarTodoRepo = IsarTodoRepo(isar);

  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
