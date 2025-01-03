import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import '../../models/task_model.dart';

class TaskDao {
  final AppDatabase _appDatabase;

  TaskDao(this._appDatabase);

  static const String _tableName = 'tasks';

  /// Obtém todas as tarefas
  Future<List<TaskModel>> getAllTasks() async {
    final db = await _appDatabase.database;
    final result = await db.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  /// Adiciona uma nova tarefa
  Future<int> addTask(TaskModel task) async {
    final db = await _appDatabase.database;
    return await db.insert(
      _tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Atualiza uma tarefa existente
  Future<int> updateTask(TaskModel task) async {
    final db = await _appDatabase.database;
    return await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Deleta uma tarefa pelo ID
  Future<int> deleteTask(int id) async {
    final db = await _appDatabase.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Deleta todas as tarefas (para debug/teste)
  Future<int> deleteAllTasks() async {
    final db = await _appDatabase.database;
    return await db.delete(_tableName);
  }
}
