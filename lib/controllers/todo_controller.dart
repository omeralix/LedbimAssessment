import 'dart:convert';
import 'package:ledbim_assessment/models/todo_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class TodoController extends GetxController {
  final storage = FlutterSecureStorage();
  final todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await storage.read(key: 'todos');
    if (todoList != null) {
      final List<dynamic> jsonList = jsonDecode(todoList);
      todos.value = jsonList.map((json) => Todo.fromJson(json)).toList();
    }
  }

  Future<void> saveTodos() async {
    final jsonList = todos.map((todo) => todo.toJson()).toList();
    await storage.write(key: 'todos', value: jsonEncode(jsonList));
  }

  void addTodo({
    required String name,
    required String status,
  }) {
    final todo = Todo(
      id: Uuid().v4(),
      name: name,
      status: status,
    );
    todos.add(todo);
    saveTodos();
  }

  void removeTodo({
    required String id,
  }) {
    todos.removeWhere((todo) => todo.id == id);
    saveTodos();
  }
}