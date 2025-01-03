import '../models/task_model.dart';

abstract class TaskRepository {
  Future<int> addTask(TaskModel task);
  Future<List<TaskModel>> getTasks();
  Future<int> updateTask(TaskModel task);
  Future<int> deleteTask(int taskId);
}
