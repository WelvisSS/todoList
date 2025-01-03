import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskController extends GetxController {
  final TaskRepository _taskRepository;

  TaskController(this._taskRepository);

  var tasks = <TaskModel>[].obs;
  var filteredTasks = <TaskModel>[].obs;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void searchTasks(String query) {
    filteredTasks.value = tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final result = await _taskRepository.getTasks();
      tasks.assignAll(result);
      filteredTasks.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(TaskModel task) async {
    await _taskRepository.addTask(task);
    fetchTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskRepository.updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTask(id);
    fetchTasks();
  }

  Future<void> deleteAllDoneTasks() async {
    for (var task in tasks) {
      if (task.isDone) {
        await _taskRepository.deleteTask(task.id!);
      }
    }
    fetchTasks();
  }
}
