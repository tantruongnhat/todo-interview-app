import 'package:get/get.dart';
import 'package:todo_interview/models/todo_item.dart';
import 'package:todo_interview/view/todo_list_view.dart';

class HomePageController extends GetxController {
  var tabIndex = 0.obs;

  final dataAllList = <TodoModel>[].obs;
  final dataCompleteList = <TodoModel>[].obs;
  final dataInCompleteList = <TodoModel>[].obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    dataAllList(dummyData());
    dataCompleteList(dataAllList.value.where((element) => element.status ==2).toList());
    dataInCompleteList(dataAllList.value.where((element) => element.status !=2).toList());
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<TodoModel> dummyData() {
    return List.generate(
        10,
        (index) => TodoModel(
            id: index,
            title: "$index",
            description: "description",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            status: 0));
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

  void changeTodoItemStatus(TodoModel listItem, bool isCheck) {
    int index = dataAllList.indexWhere((element) => element.id == listItem.id);
    if (index != -1) dataAllList[index] = listItem..status = isCheck ? 1 : 0;
    dataAllList(dataAllList.value);
    dataCompleteList(dataAllList.value.where((element) => element.status == 1).toList());
    dataInCompleteList(dataAllList.value.where((element) => element.status != 1).toList());
    // if (isCheck) {
    //   int indexComplete =
    //       dataCompleteList.indexWhere((element) => element.id == listItem.id);
    //   if (indexComplete == -1) {
    //     dataCompleteList.add(listItem..status = isCheck ? 2 : 1);
    //     dataCompleteList(dataCompleteList.value);
    //   }
    //
    //   int indexInComplete =
    //   dataInCompleteList.indexWhere((element) => element.id == listItem.id);
    //   if (indexInComplete != -1) {
    //     dataInCompleteList.removeAt(indexInComplete);
    //     dataInCompleteList(dataInCompleteList.value);
    //   }
    //
    // } else {
    //   int indexComplete =
    //   dataCompleteList.indexWhere((element) => element.id == listItem.id);
    //   if (indexComplete != -1) {
    //     dataCompleteList.removeAt(indexComplete);
    //     dataCompleteList(dataInCompleteList.value);
    //   }
    //
    //   int indexInComplete =
    //   dataInCompleteList.indexWhere((element) => element.id == listItem.id);
    //   if (indexInComplete == -1) {
    //     dataCompleteList.add(listItem..status = isCheck ? 1 : 2);
    //     dataCompleteList(dataCompleteList.value);
    //   }
    // }
  }
}
