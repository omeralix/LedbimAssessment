import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledbim_assessment/controllers/todo_controller.dart';


class TodoListScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return ListTile(
              title: Text(todo.name),
              subtitle: Text(todo.status),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  todoController.removeTodo(id: todo.id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTodoDialog(context);
        },
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Task Status'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final name = nameController.text;
                final status = statusController.text;
                if (name.isNotEmpty && status.isNotEmpty) {
                  todoController.addTodo(name: name, status: status);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}