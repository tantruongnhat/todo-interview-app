
import 'package:get/get.dart';
import 'package:todo_interview/controller/home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}