import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/presentation/todo_cubit.dart';
import 'package:todo_flutter/domain/models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoDialog(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoDialog(context),
      ),
      // Bloc builder
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get todo object
              final todo = todos[index];

              return ListTile(
                title: Text(todo.text),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
