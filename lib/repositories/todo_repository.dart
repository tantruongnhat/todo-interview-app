import 'package:dartz/dartz.dart';
import 'package:todo_interview/error/failures.dart';
import 'package:todo_interview/models/todo_item.dart';

abstract class TodoRepository {
 Future<Either<Failure, bool>>? dummyData();
 Future<Either<Failure, bool>> addTodoItem(Map<String, dynamic> params);
 Future<Either<Failure, List<TodoModel>>>? getTodoItems();
 Future<Either<Failure, void>>? changeTodoItemStatus(TodoModel todoModel, int status);

}