import 'package:uuid/uuid.dart';

class TaskModel {
  final String id;
  final String title;
  final String details;
  final String priority;
  final String dueDate;
  final bool isCompleted;
  final String createdAt;
  final String ownerEmail;

  TaskModel({
    required this.id,
    required this.title,
    required this.details,
    required this.priority,
    required this.dueDate,
    required this.isCompleted,
    required this.createdAt,
    required this.ownerEmail,
  });

  factory TaskModel.create({
    required String title,
    required String details,
    required String priority,
    required String dueDate,
    required String ownerEmail,
  }) {
    return TaskModel(
      id: const Uuid().v4(),
      title: title,
      details: details,
      priority: priority,
      dueDate: dueDate,
      isCompleted: false,
      createdAt: DateTime.now().toIso8601String(),
      ownerEmail: ownerEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'priority': priority,
      'dueDate': dueDate,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt,
      'ownerEmail': ownerEmail,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      details: map['details'] ?? '',
      priority: map['priority'] ?? 'Low',
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: map['createdAt'],
      ownerEmail: map['ownerEmail'],
    );
  }

  TaskModel copyWith({
    String? title,
    String? details,
    String? priority,
    String? dueDate,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      details: details ?? this.details,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      ownerEmail: ownerEmail,
    );
  }
}
