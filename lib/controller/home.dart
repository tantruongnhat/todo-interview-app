import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_interview/models/status_enum.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/usecases/todo.dart';
import 'package:todo_interview/view/todo_list_view.dart';

class HomePageController extends GetxController {
  final ToDoUseCase toDoUseCase;

  HomePageController(this.toDoUseCase);

  var tabIndex = 0.obs;

  final dataAllList = <TodoModel>[].obs;
  final dataCompleteList = <TodoModel>[].obs;
  final dataInCompleteList = <TodoModel>[].obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onReady() async {
    super.onReady();
    await _checkEmptyListAndCreateData();
    _loadTodoList();
  }

  List<TodoModel> getListData(TabType tabType) {
    switch (tabType) {
      case TabType.all:
        return dataAllList;
      case TabType.complete:
        return dataCompleteList;
      case TabType.inComplete:
        return dataInCompleteList;
    }
  }

  void changeTodoItemStatus(TodoModel todoModel, bool isCheck) async {
    final int status =
        isCheck ? TodoStatus.complete.value : TodoStatus.inComplete.value;
    await toDoUseCase.changeTodoItemStatus(todoModel, status);
    _loadTodoList();
  }

  _loadTodoList() async {
    _loadTodoAll();
    _loadTodoInComplete();
    _loadTodoComplete();
  }

  _loadTodoAll() async {
    final res = await toDoUseCase.getTodoItems();
    res?.fold((l) {
      Get.snackbar("Error", l.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }, (r) {
      dataAllList(r);
    });
  }

  _loadTodoInComplete() async {
    final res = await toDoUseCase.getTodoItemInComplete();
    res?.fold((l) {
      Get.snackbar("Error", l.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }, (r) {
      dataInCompleteList(r);
    });
  }

  _loadTodoComplete() async {
    final res = await toDoUseCase.getTodoItemComplete();
    res?.fold((l) {
      Get.snackbar("Error", l.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }, (r) {
      dataCompleteList(r);
    });
  }

  _checkEmptyListAndCreateData() async {
    final res = await toDoUseCase.getTodoItems();
    final list = res?.getOrElse(() => []);
    if (list == null || list.isEmpty) await toDoUseCase.dummyData();
  }
}
