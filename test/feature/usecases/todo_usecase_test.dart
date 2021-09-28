
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_interview/models/status_enum.dart';
import 'package:todo_interview/repositories/todo_repository.dart';
import 'package:todo_interview/usecases/todo.dart';
import 'package:todo_interview/utils/generate_data.dart';

class MockTodoRepository extends Mock
    implements TodoRepository {}


void main() {
  late ToDoUseCase useCase;
  late MockTodoRepository mockTodoRepository;
  setUp(() async {
    mockTodoRepository = MockTodoRepository();
    useCase = ToDoUseCase(mockTodoRepository);
  });

  group("should return data list with status", () {
    final dataList = MockData.generateData();
    final todoItemFirst = dataList.first..status = TodoStatus.complete.value;

    test("should return all data includes incomplete and complete", () async {
      when(mockTodoRepository.getTodoItems())
          .thenAnswer((_) async => Right(dataList));

      final result = await useCase.getTodoItems();
      expect(result, Right(dataList));
    });

    test("should return todo list complete", () async {
      dataList.first = todoItemFirst;
      when(mockTodoRepository.getTodoItems())
          .thenAnswer((_) async => Right(dataList));

      final result = await useCase.getTodoItemComplete();
      final dataCompleteList = result?.getOrElse(() => []);
      expect(dataCompleteList?.length, 1);
    });

    test("should return todo list incomplete", () async {
      dataList.first = todoItemFirst;
      when(mockTodoRepository.getTodoItems())
          .thenAnswer((_) async => Right(dataList));

      final result = await useCase.getTodoItemInComplete();
      final dataCompleteList = result?.getOrElse(() => []);
      expect(dataCompleteList?.length, 9);
    });
  });

}