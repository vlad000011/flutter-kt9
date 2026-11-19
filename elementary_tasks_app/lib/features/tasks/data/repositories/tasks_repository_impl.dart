import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_local_data_source.dart';

class TasksRepositoryImpl implements TasksRepository {
  TasksRepositoryImpl(this._dataSource);

  final TasksLocalDataSource _dataSource;

  @override
  Future<List<Task>> getTasks() => _dataSource.getTasks();

  @override
  Future<void> addTask(Task task) async {
    final tasks = await _dataSource.getTasks();
    tasks.insert(0, task);
    await _dataSource.saveTasks(tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = await _dataSource.getTasks();
    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    tasks[index] = task;
    await _dataSource.saveTasks(tasks);
  }

  @override
  Future<void> deleteTask(String id) async {
    final tasks = await _dataSource.getTasks();
    tasks.removeWhere((task) => task.id == id);
    await _dataSource.saveTasks(tasks);
  }
}
