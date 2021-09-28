import 'package:hive/hive.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/utils/constant.dart';

abstract class TodoLocalDataSource {
 Future<bool> addTodoItem(TodoModel params);
 Future<bool> addTodoItems(List<TodoModel> params, {bool isClearAll = false});
 Future<List<TodoModel>>? getToDoItems();
 Future<void> changeTodoItemStatus(TodoModel todoModel, int status);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {

  @override
  Future<bool> addTodoItem(TodoModel params) async  {
    try{
      Box<TodoModel> todoBox = Hive.box<TodoModel>(hiveBoxName);
      final key = await todoBox.add(params);
      if(key != -1)  return true;
      return false;
    }catch(error){
      rethrow;
    }
  }

  @override
  Future<List<TodoModel>> getToDoItems() async {
    try{
      Box<TodoModel> todoBox = Hive.box<TodoModel>(hiveBoxName);
      return todoBox.values.toList();
    }catch(error){
      rethrow;
    }
  }

  @override
  Future<bool> addTodoItems(List<TodoModel> params, {bool isClearAll = false}) async{
    try{
      Box<TodoModel> todoBox = Hive.box<TodoModel>(hiveBoxName);
      if(isClearAll) await todoBox.clear();
      final res = await todoBox.addAll(params);
      if(res.isEmpty) return false;
      return true;
    }catch(error){
      rethrow;
    }
  }

  @override
  Future<void> changeTodoItemStatus(TodoModel todoModel, int status) async{
    Box<TodoModel> todoBox = Hive.box<TodoModel>(hiveBoxName);
    todoModel.status = status;
    todoModel.save();
    await todoBox.put(todoModel.key, todoModel);
  }

}