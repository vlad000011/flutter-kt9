import 'package:flutter/material.dart';

import 'features/tasks/data/datasources/tasks_local_data_source.dart';
import 'features/tasks/data/repositories/tasks_repository_impl.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/toggle_task.dart';
import 'features/tasks/presentation/tasks_model.dart';
import 'features/tasks/presentation/tasks_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ElementaryTasksApp());
}

class ElementaryTasksApp extends StatelessWidget {
  const ElementaryTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = TasksLocalDataSource();
    final repository = TasksRepositoryImpl(dataSource);

    final model = TasksModel(
      getTasks: GetTasks(repository),
      addTask: AddTask(repository),
      toggleTask: ToggleTask(repository),
      deleteTask: DeleteTask(repository),
    );

    return MaterialApp(
      title: 'Мои задачи',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5367D5)),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F7FB),
          centerTitle: false,
        ),
      ),
      home: TasksWidget(model: model),
    );
  }
}
