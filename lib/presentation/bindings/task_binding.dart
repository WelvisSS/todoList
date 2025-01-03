import 'package:get/get.dart';

import '../../core/database/app_database.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/sources/local/task_dao.dart';
import '../controllers/task_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    // Instância única do AppDatabase
    final appDatabase = AppDatabase();

    // Criação do DAO e repositório
    final taskDao = TaskDao(appDatabase);
    final taskRepository = TaskRepositoryImpl(taskDao);

    // Injeção do TaskController com o TaskRepository
    Get.lazyPut<TaskController>(() => TaskController(taskRepository));
  }
}
