import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task.dart';

class TasksLocalDataSource {
  static const _storageKey = 'elementary_tasks';

  Future<List<Task>> getTasks() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final preferences = await SharedPreferences.getInstance();
    final raw = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await preferences.setString(_storageKey, raw);
  }
}
