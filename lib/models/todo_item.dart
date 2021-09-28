
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable{
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  int status;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status
  });

  @override
  List<Object> get props => [id];
}