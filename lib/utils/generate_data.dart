import 'package:todo_interview/models/status_enum.dart';
import 'package:todo_interview/models/todo_item.dart';

class MockData {
  MockData._internal();

  static List<TodoModel> generateData() {
    return List.generate(
      10,
      (index) => TodoModel(
          title: "$index",
          description: "description $index",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: TodoStatus.inComplete.value),
    );
  }
}
