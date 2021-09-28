import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_interview/controller/home.dart';
import 'package:todo_interview/models/status_enum.dart';
import 'package:todo_interview/models/todo_item.dart';

enum TabType {
  all,
  complete,
  inComplete,
}

class TodoListView extends StatefulWidget {
  final TabType tabType;

  const TodoListView(this.tabType, {Key? key}) : super(key: key);

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final HomePageController controller = Get.find();

  late List<TodoModel> listItem;

  @override
  void initState() {
    super.initState();
    listItem = controller.getListData(widget.tabType);
  }

  @override
  Widget build(BuildContext context) {
    final listVIew = _buildContentView();
    return Container(child: listVIew);
  }

  _buildContentView() {
    return Obx(
      () => _buildListView(),
    );
  }

  _buildListView() {
    if(listItem.isEmpty) {
      return const Center(
        child: Icon(
          Icons.hourglass_empty,
          size: 50,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => Slidable(
          key: Key(listItem[index].key.toString()), //set key
          actionPane: const SlidableDrawerActionPane(),

          child: Card(
            key: ValueKey(listItem[index].key.toString()),
            child: ListTile(
              title: Text(listItem[index].title),
              subtitle: Text(listItem[index].description),
              trailing: Checkbox(
                value: _getCheckBoxValue(listItem[index].statusEnum),
                onChanged: (bool? value) {
                  controller.changeTodoItemStatus(
                      listItem[index], value ?? false);
                },
              ),
            ),
          ),
        ),
        itemCount: listItem.length,
      );
    }
  }

  _getCheckBoxValue(TodoStatus status) {
    if (status == TodoStatus.complete) return true;
    return false;
  }
}
