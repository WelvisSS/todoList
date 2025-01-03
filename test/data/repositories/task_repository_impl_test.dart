import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todolist/data/models/task_model.dart';
import 'package:todolist/data/repositories/task_repository_impl.dart';
import 'package:todolist/data/sources/local/task_dao.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TaskDao>()])
void main() {
  late TaskRepositoryImpl taskRepository;
  late MockTaskDao mockTaskDao;

  setUp(() {
    mockTaskDao = MockTaskDao();
    taskRepository = TaskRepositoryImpl(mockTaskDao);
  });

  group('TaskRepository', () {
    test('Deve adicionar uma tarefa chamando addTask no DAO', () async {
      // Arrange
      final task = TaskModel(
        id: 1,
        title: 'Teste Tarefa',
        description: 'Descrição da tarefa',
        isDone: false,
        createdAt: DateTime.now(),
      );

      // Configurar o mock para retornar um valor
      when(mockTaskDao.addTask(task)).thenAnswer((_) async => 1);

      // Act
      final result = await taskRepository.addTask(task);

      // Assert
      expect(result, 1);
      verify(mockTaskDao.addTask(task)).called(1);
    });

    test('Deve retornar uma lista de tarefas chamando getAllTasks no DAO',
        () async {
      // Arrange
      final tasks = [
        TaskModel(
          id: 1,
          title: 'Task 1',
          description: 'Description 1',
          isDone: false,
          createdAt: DateTime.now(),
        ),
        TaskModel(
          id: 2,
          title: 'Task 2',
          description: 'Description 2',
          isDone: true,
          createdAt: DateTime.now(),
        ),
      ];
      when(mockTaskDao.getAllTasks()).thenAnswer((_) async => tasks);

      // Act
      final result = await taskRepository.getTasks();

      // Assert
      expect(result, tasks);
      verify(mockTaskDao.getAllTasks()).called(1);
    });

    test('Deve atualizar uma tarefa chamando updateTask no DAO', () async {
      // Arrange
      final task = TaskModel(
        id: 1,
        title: 'Tarefa Atualizada',
        description: 'Nova descrição',
        isDone: true,
        createdAt: DateTime.now(),
      );
      when(mockTaskDao.updateTask(task)).thenAnswer((_) async => 1);

      // Act
      final result = await taskRepository.updateTask(task);

      // Assert
      expect(result, 1);
      verify(mockTaskDao.updateTask(task)).called(1);
    });

    test('Deve deletar uma tarefa chamando deleteTask no DAO', () async {
      // Arrange
      const taskId = 1;
      when(mockTaskDao.deleteTask(taskId)).thenAnswer((_) async => 1);

      // Act
      final result = await taskRepository.deleteTask(taskId);

      // Assert
      expect(result, 1);
      verify(mockTaskDao.deleteTask(taskId)).called(1);
    });

    // Teste de exceções
    test('Deve lançar uma exceção quando addTask falhar', () async {
      // Arrange
      final task = TaskModel(
        id: 1,
        title: 'Task Error',
        description: 'Description Error',
        isDone: false,
        createdAt: DateTime.now(),
      );
      when(mockTaskDao.addTask(task)).thenThrow(Exception('Database error'));

      expect(() => taskRepository.addTask(task), throwsException);
    });

    test('Deve lançar uma exceção quando getAllTasks falhar', () async {
      when(mockTaskDao.getAllTasks()).thenThrow(Exception('Database error'));

      expect(() => taskRepository.getTasks(), throwsException);
    });

    // Teste para lista vazia
    test('Deve retornar uma lista vazia quando não houver tarefas', () async {
      when(mockTaskDao.getAllTasks()).thenAnswer((_) async => []);

      // Act
      final result = await taskRepository.getTasks();

      expect(result, []);
      verify(mockTaskDao.getAllTasks()).called(1);
    });

    // Teste para adicionar tarefa com ID duplicado
    test('Não deve adicionar uma tarefa com ID duplicado', () async {
      // Arrange
      final task = TaskModel(
        id: 1, // ID já existente
        title: 'Task Duplicated',
        description: 'Duplicated Task Description',
        isDone: false,
        createdAt: DateTime.now(),
      );
      when(mockTaskDao.addTask(task))
          .thenAnswer((_) async => 0); // Supondo que 0 indique falha

      final result = await taskRepository.addTask(task);

      expect(result, 0);
      verify(mockTaskDao.addTask(task)).called(1);
    });

    // Teste para atualização de uma tarefa inexistente
    test('Deve retornar 0 quando tentar atualizar uma tarefa que não existe',
        () async {
      // Arrange
      final task = TaskModel(
        id: 999, // ID inexistente
        title: 'Non-existing Task',
        description: 'Description of non-existing task',
        isDone: false,
        createdAt: DateTime.now(),
      );
      when(mockTaskDao.updateTask(task))
          .thenAnswer((_) async => 0); // Retorna 0 indicando falha

      final result = await taskRepository.updateTask(task);

      expect(result, 0);
      verify(mockTaskDao.updateTask(task)).called(1);
    });

    // Teste para exclusão de uma tarefa inexistente
    test('Deve retornar 0 quando tentar deletar uma tarefa inexistente',
        () async {
      // Arrange
      const taskId = 999; // ID inexistente
      when(mockTaskDao.deleteTask(taskId))
          .thenAnswer((_) async => 0); // Retorna 0 indicando falha

      final result = await taskRepository.deleteTask(taskId);

      expect(result, 0);
      verify(mockTaskDao.deleteTask(taskId)).called(1);
    });

    // Teste para adicionar tarefa com dados inválidos
    test(
        'Deve lançar uma exceção ao tentar adicionar uma tarefa com dados inválidos',
        () async {
      final invalidTask = TaskModel(
        id: 1,
        title: '', // Título inválido
        description: 'Descricao',
        isDone: false,
        createdAt: DateTime.now(),
      );
      when(mockTaskDao.addTask(invalidTask))
          .thenThrow(FormatException('Invalid task data'));

      expect(() => taskRepository.addTask(invalidTask), throwsFormatException);
    });
  });
}
