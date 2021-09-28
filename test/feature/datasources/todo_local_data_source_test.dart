
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_interview/datasource/todo_local_data_source.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/utils/constant.dart';
import 'package:todo_interview/utils/generate_data.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

const String hiveBoxNameTest = 'people_test';

Future<void> initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TodoModelAdapter());
  //Always starts from a clean box
  Hive.deleteBoxFromDisk(hiveBoxName);

  await Hive.openBox<TodoModel>(hiveBoxName);
}

void main()async{

  await initialiseHive();

  late TodoLocalDataSourceImpl dataSource;
  late List<TodoModel> dataList;

  setUp(() async {
    dataSource = TodoLocalDataSourceImpl();
    dataList = MockData.generateData();
  });

  group('TodoLocalDataSourceImpl', () {
    test("should return true when add all list data", () async {
      final result = await dataSource.addTodoItems(dataList, isClearAll: true);
      expect(result, true);

    });

    test('should return all list data from cache', () async {
      await dataSource.addTodoItems(dataList, isClearAll: true);
      final result = await dataSource.getToDoItems();
      expect(result.length, dataList.length);
    });

    test('should change todo item in cache', () async {
      await dataSource.addTodoItems(dataList, isClearAll: true);
      final todoItemFirst = dataList.first;
      await dataSource.changeTodoItemStatus(todoItemFirst, 2);
      Box<TodoModel> todoBox = Hive.box<TodoModel>(hiveBoxName);
      expect(todoBox.get(todoItemFirst.key)?.status, 2);
    });
  });

}