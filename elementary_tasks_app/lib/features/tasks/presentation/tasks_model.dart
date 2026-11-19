import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../domain/entities/task.dart';
import '../domain/usecases/add_task.dart';
import '../domain/usecases/delete_task.dart';
import '../domain/usecases/get_tasks.dart';
import '../domain/usecases/toggle_task.dart';

class TasksModel extends ElementaryModel {
  TasksModel({
    required GetTasks getTasks,
    required AddTask addTask,
    required ToggleTask toggleTask,
    required DeleteTask deleteTask,
  })  : _getTasks = getTasks,
        _addTask = addTask,
        _toggleTask = toggleTask,
        _deleteTask = deleteTask;

  final GetTasks _getTasks;
  final AddTask _addTask;
  final ToggleTask _toggleTask;
  final DeleteTask _deleteTask;

  Future<List<Task>> loadTasks() => _getTasks();

  Future<void> createTask(String title) {
    final task = Task(
      id: const Uuid().v4(),
      title: title.trim(),
      isCompleted: false,
    );
    return _addTask(task);
  }

  Future<void> changeTaskStatus(Task task) => _toggleTask(task);

  Future<void> removeTask(String id) => _deleteTask(id);
}
