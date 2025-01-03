import 'package:get/get.dart';

import 'presentation/bindings/task_binding.dart';
import 'presentation/screens/main_screen.dart';

class AppRoutes {
  static const String main = '/main';

  static final List<GetPage> pages = [
    GetPage(
      name: main,
      page: () => MainScreen(),
      binding: TaskBinding(),
    ),
  ];
}
