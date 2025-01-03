import '../models/task_model.dart';
import '../sources/local/task_dao.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDao _taskDao;

  TaskRepositoryImpl(this._taskDao);

  @override
  Future<List<TaskModel>> getTasks() => _taskDao.getAllTasks();

  @override
  Future<int> addTask(TaskModel task) => _taskDao.addTask(task);

  @override
  Future<int> updateTask(TaskModel task) => _taskDao.updateTask(task);

  @override
  Future<int> deleteTask(int taskId) => _taskDao.deleteTask(taskId);
}
