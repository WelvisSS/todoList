import '../../data/models/task_model.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0, // Salva como inteiro (0 ou 1)
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        isDone: (map['isDone'] as int) == 1,
        createdAt: DateTime.parse(map['createdAt'] as String));
  }

  /// Comparação para garantir que duas tarefas são iguais (útil para testes e estado)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          isDone == other.isDone &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      isDone.hashCode ^
      createdAt.hashCode;
}
