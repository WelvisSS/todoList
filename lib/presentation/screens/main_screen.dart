import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../controllers/task_controller.dart';
import '../widgets/create_task_widget.dart';
import 'done_screen.dart';
import 'search_screen.dart';
import 'todo_screen.dart';

class MainScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  final List<Widget> _pages = [
    TodoScreen(),
    Container(),
    SearchScreen(),
    DoneScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFF007FFF),
                ),
                Text(
                  "Task",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0XFF3F3D56),
                  ),
                ),
                Spacer(),
                Text(
                  "John",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0XFF3F3D56),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 42,
                  width: 42,
                  child: Image.asset('assets/images/avatar.png'),
                ),
              ],
            ),
          ),
          body: _pages[taskController.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: taskController.selectedIndex.value,
            onTap: (index) {
              if (index == 1) {
                showAddTaskDialog(context, taskController);
              } else {
                taskController.changePage(index);
              }
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.checklist,
                  color: taskController.selectedIndex.value == 0
                      ? Color(0XFF007FFF)
                      : Color(0XFFC6CFDC),
                ),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.add_box_outline_rounded,
                  color: taskController.selectedIndex.value == 1
                      ? Color(0XFF007FFF)
                      : Color(0XFFC6CFDC),
                ),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  Ri.search_line,
                  color: taskController.selectedIndex.value == 2
                      ? Color(0XFF007FFF)
                      : Color(0XFFC6CFDC),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.check_box_outline_rounded,
                  color: taskController.selectedIndex.value == 3
                      ? Color(0XFF007FFF)
                      : Color(0XFFC6CFDC),
                ),
                label: 'Done',
              ),
            ],
            selectedItemColor: Color(0XFF007FFF),
            unselectedItemColor: Color(0XFFC6CFDC),
          ),
        );
      },
    );
  }
}
