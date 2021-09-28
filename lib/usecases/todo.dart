import 'package:dartz/dartz.dart';
import 'package:todo_interview/error/failures.dart';
import 'package:todo_interview/models/status_enum.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/repositories/todo_repository.dart';
import 'package:todo_interview/utils/constant.dart';

class ToDoUseCase {
  final TodoRepository repository;

  ToDoUseCase(this.repository);

  Future<Either<Failure, bool>> addTodoItem(
      String title, String description) async {
    Map<String, dynamic> todoItem = {
      "title": title,
      "description": description,
      'status': 0
    };
    return await repository.addTodoItem(todoItem);
  }

  Future<Either<Failure, bool>?> dummyData() async {
    return await repository.dummyData();
  }

  Future<Either<Failure, List<TodoModel>>?> getTodoItems() async {
    return await repository.getTodoItems();
  }

  Future<Either<Failure, List<TodoModel>>?> getTodoItemInComplete() async {
    final res = await getTodoItems();
    if(res != null) {
      return res.fold((l) {
        return Left(l);
      }, (r) {
        if (r is List<TodoModel>) {
          final _todoInCompleteList =
          r.where((e) => e.statusEnum == TodoStatus.inComplete).toList();
          return Right(_todoInCompleteList);
        }
        return Left(ParseFailure(errorCommonMessage));
      });
    } else {
      return Left(NullException(errorCommonMessage));
    }

  }

  Future<Either<Failure, List<TodoModel>>?> getTodoItemComplete() async {
    final res = await getTodoItems();
    if(res != null) {
      return res.fold((l) {
        return Left(l);
      }, (r) {
        if (r is List<TodoModel>) {
          final _todoInCompleteList =
          r.where((e) => e.statusEnum == TodoStatus.complete).toList();
          return Right(_todoInCompleteList);
        }
        return Left(ParseFailure(errorCommonMessage));
      });
    } else {
      return Left(NullException(errorCommonMessage));
    }
  }

  Future<Either<Failure, void>?> changeTodoItemStatus(TodoModel todoModel, int status) async {
    return await repository.changeTodoItemStatus(todoModel, status);
  }
}
