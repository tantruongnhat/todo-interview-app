import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_interview/controller/home.dart';
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
    return _buildView();
  }

  Widget _buildView() {
    final listVIew = _buildList();
    switch (widget.tabType) {
      case TabType.all:
        return Container(color: Colors.blue, child: listVIew);
      case TabType.complete:
        return Container(color: Colors.red, child: _buildList());
      case TabType.inComplete:
        return Container(
          color: Colors.yellow,
          child: _buildList(),
        );
    }
  }

  _buildList() {
    return Obx(
      () => ListView.builder(
        itemBuilder: (context, index) => Slidable(
          key: Key(listItem[index].id.toString()), //set key

          actionPane: const SlidableDrawerActionPane(),
          secondaryActions: [
            //action button to show in head
            ElevatedButton(
              child: const Icon(Icons.delete),
              onPressed: () {
                //action for phone call
              },
            ),
            //add more action buttons here
          ],
          child: Card(
            key: ValueKey(listItem[index].id.toString()),
            child: ListTile(
                title: Text(listItem[index].title),
                subtitle: Text(listItem[index].description),
                trailing: Checkbox(
                  value: getCheckBoxValue(listItem[index].status),
                  onChanged: (bool? value) {
                    controller.changeTodoItemStatus(listItem[index], value ?? false);
                  },
                )),
          ),
        ),
        itemCount: listItem.length,
      ),
    );
  }

  getCheckBoxValue(int status) {
    if (status == 1) return true;
    return false;
  }
}
