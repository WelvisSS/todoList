import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      body: Obx(() {
        if (taskController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final doneTasks =
            taskController.tasks.where((task) => task.isDone).toList();

        if (doneTasks.isEmpty) {
          return Center(
            child: Text(
              'No result found.',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0XFF8D9CB8),
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completed Tasks',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0XFF3F3D56),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      taskController.deleteAllDoneTasks();
                    },
                    child: Text(
                      'Delete all',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0XFFFF5E5E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: doneTasks.length,
                  itemBuilder: (context, index) {
                    final task = doneTasks[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0XFFF5F7F9),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isDone,
                          activeColor: Color(0XFFDDE3EA),
                          onChanged: (value) {},
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                task.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0XFF8D9CB8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: Color(0XFFFF5E5E),
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            taskController.deleteTask(task.id!);
                          },
                        ),
                        onLongPress: () {
                          taskController.deleteTask(task.id!);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
