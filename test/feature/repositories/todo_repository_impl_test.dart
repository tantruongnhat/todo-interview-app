import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_interview/datasource/todo_local_data_source.dart';
import 'package:todo_interview/error/failures.dart';
import 'package:todo_interview/repositories/todo_repository_impl.dart';
import 'package:todo_interview/utils/generate_data.dart';

class MockLocalDataSource extends Mock implements TodoLocalDataSource {}

void main() {
  late TodoRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = TodoRepositoryImpl(mockLocalDataSource);
  });

  group("TodoRepositoryImpl", () {
    final dataList = MockData.generateData();
    test(
      'should return cache failure when the call method throw exception',
      () async {
        when(mockLocalDataSource.getToDoItems()).thenThrow(CacheFailure());
        final result = await repository.getTodoItems();
        expect(result, equals(Left(CacheFailure())));
      },
    );

    test(
      'should return list data from cache ',
      () async {
        when(mockLocalDataSource.getToDoItems())
            .thenAnswer((_) async => dataList);
        final result = await repository.getTodoItems();
        expect(result, equals(Right(dataList)));
      },
    );
  });
}
