import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todo_interview/models/status_enum.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final DateTime updatedAt;
  @HiveField(4)
  int status;

  TodoModel(
      {required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.status});

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        title: map["title"] ?? '',
        description: map["description"] ?? '',
        status: map["status"] ?? -1,
        createdAt: map["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(map["createdAt"]),
        updatedAt: map["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(map["updatedAt"]),
      );

  TodoStatus get statusEnum {
    switch (status) {
      case 0:
        return TodoStatus.none;
      case 1:
        return TodoStatus.inComplete;
      case 2:
        return TodoStatus.complete;
      case 3:
        return TodoStatus.edit;
      case 4:
        return TodoStatus.delete;
      default:
        return TodoStatus.none;
    }
  }
}
