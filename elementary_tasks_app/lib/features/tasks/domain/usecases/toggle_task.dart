import '../entities/task.dart';
import '../repositories/tasks_repository.dart';

class ToggleTask {
  const ToggleTask(this._repository);
  final TasksRepository _repository;

  Future<void> call(Task task) =>
      _repository.updateTask(task.copyWith(isCompleted: !task.isCompleted));
}
