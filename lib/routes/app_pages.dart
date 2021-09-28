import 'package:get/get.dart';
import 'package:todo_interview/bindings/home.dart';
import 'package:todo_interview/view/home_page.dart';

part 'app_routes.dart';

class AppPages {
  static const initial= Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),

  ];
}
