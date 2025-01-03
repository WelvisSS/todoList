import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() => _instance;

  /// Método para obter o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Método chamado ao criar o banco de dados
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  /// Método chamado ao atualizar o banco de dados
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar lógicas de migração se necessário.
  }

  /// Método para limpar o banco de dados (apenas para debug/teste)
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('tasks');
  }

  /// Método para fechar a conexão com o banco de dados
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
    _database = null;
  }
}
