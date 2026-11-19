import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../domain/entities/task.dart';
import 'tasks_model.dart';
import 'tasks_widget_model.dart';

class TasksWidget extends ElementaryWidget<ITasksWidgetModel> {
  const TasksWidget({
    super.key,
    required TasksModel model,
  }) : super((context) => TasksWidgetModel(model));

  @override
  Widget build(ITasksWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои задачи',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: wm.remainingCount,
            builder: (_, count, __) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(child: Text('Осталось: $count')),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: wm.isLoading,
        builder: (context, loading, _) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ValueListenableBuilder<List<Task>>(
            valueListenable: wm.tasks,
            builder: (context, tasks, _) {
              if (tasks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.task_alt, size: 64, color: Colors.black26),
                      SizedBox(height: 12),
                      Text('Пока нет задач. Добавьте первую!'),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => wm.toggleTask(task),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isCompleted ? Colors.grey : null,
                        ),
                      ),
                      trailing: IconButton(
                        tooltip: 'Удалить',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => wm.deleteTask(task.id),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(wm),
        icon: const Icon(Icons.add),
        label: const Text('Добавить задачу'),
      ),
    );
  }

  Future<void> _showAddDialog(ITasksWidgetModel wm) async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: wm.context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Новая задача'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Например, прочитать главу книги',
          ),
          onSubmitted: (_) {
            final value = controller.text.trim();
            if (value.isNotEmpty) {
              wm.addTask(value);
              Navigator.pop(dialogContext);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                wm.addTask(value);
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
    controller.dispose();
  }
}
