import 'package:dartz/dartz.dart';
import 'package:todo_interview/datasource/todo_local_data_source.dart';
import 'package:todo_interview/error/failures.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/repositories/todo_repository.dart';
import 'package:todo_interview/utils/generate_data.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, bool>> addTodoItem(Map<String, dynamic> params) async {
    try {
      TodoModel todoModel = TodoModel.fromMap(params);
      final res = await localDataSource.addTodoItem(todoModel);
      return Right(res);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getTodoItems() async {
    try {
      var res = await localDataSource.getToDoItems();
      return Right(res!);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> dummyData() async {
    try {
      var res = await localDataSource.addTodoItems(MockData.generateData(),
          isClearAll: true);
      return Right(res);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeTodoItemStatus(TodoModel todoModel, int status) async {
    try {
      var res = await localDataSource.changeTodoItemStatus(todoModel, status);
      return Right(res);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
