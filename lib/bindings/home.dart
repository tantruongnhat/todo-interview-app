import 'package:get/get.dart';
import 'package:todo_interview/controller/home.dart';
import 'package:todo_interview/datasource/todo_local_data_source.dart';
import 'package:todo_interview/repositories/todo_repository_impl.dart';
import 'package:todo_interview/usecases/todo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() {
      final datasource = TodoLocalDataSourceImpl();
      final repository = TodoRepositoryImpl(datasource);
      final toDoUseCase = ToDoUseCase(repository);
      return HomePageController(toDoUseCase);
    });
  }
}
