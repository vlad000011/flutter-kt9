import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../domain/entities/task.dart';
import 'tasks_model.dart';
import 'tasks_widget.dart';

abstract interface class ITasksWidgetModel implements IWidgetModel {
  ValueListenable<List<Task>> get tasks;
  ValueListenable<bool> get isLoading;
  ValueListenable<int> get remainingCount;
  BuildContext get context;
  Future<void> addTask(String title);
  Future<void> toggleTask(Task task);
  Future<void> deleteTask(String id);
}

class TasksWidgetModel extends WidgetModel<TasksWidget, TasksModel>
    implements ITasksWidgetModel {
  TasksWidgetModel(TasksModel model) : super(model);

  final ValueNotifier<List<Task>> _tasks = ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final ValueNotifier<int> _remainingCount = ValueNotifier(0);

  @override
  ValueListenable<List<Task>> get tasks => _tasks;

  @override
  ValueListenable<bool> get isLoading => _isLoading;

  @override
  ValueListenable<int> get remainingCount => _remainingCount;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      _setTasks(await model.loadTasks());
    } catch (error, stackTrace) {
      model.handleError(error, stackTrace: stackTrace);
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    try {
      await model.createTask(title);
      _setTasks(await model.loadTasks());
    } catch (error, stackTrace) {
      model.handleError(error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> toggleTask(Task task) async {
    try {
      await model.changeTaskStatus(task);
      _setTasks(await model.loadTasks());
    } catch (error, stackTrace) {
      model.handleError(error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await model.removeTask(id);
      _setTasks(await model.loadTasks());
    } catch (error, stackTrace) {
      model.handleError(error, stackTrace: stackTrace);
    }
  }

  void _setTasks(List<Task> value) {
    _tasks.value = List.unmodifiable(value);
    _remainingCount.value = value.where((task) => !task.isCompleted).length;
  }

  @override
  void dispose() {
    _tasks.dispose();
    _isLoading.dispose();
    _remainingCount.dispose();
    super.dispose();
  }
}

