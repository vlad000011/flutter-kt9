import 'package:flutter_test/flutter_test.dart';
import 'package:elementary_tasks_app/features/tasks/domain/entities/task.dart';

void main() {
  group('Task', () {
    test('copyWith changes completion status and keeps other fields', () {
      const task = Task(id: '1', title: 'Read', isCompleted: false);

      final completed = task.copyWith(isCompleted: true);

      expect(completed.id, '1');
      expect(completed.title, 'Read');
      expect(completed.isCompleted, isTrue);
    });

    test('serializes and restores task', () {
      const task = Task(id: '2', title: 'Study Flutter', isCompleted: true);

      final restored = Task.fromJson(task.toJson());

      expect(restored.id, task.id);
      expect(restored.title, task.title);
      expect(restored.isCompleted, task.isCompleted);
    });
  });
}
