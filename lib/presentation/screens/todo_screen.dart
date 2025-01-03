import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../controllers/task_controller.dart';
import '../widgets/create_task_widget.dart';
import '../widgets/edit_task_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30, top: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome, ',
                        style: TextStyle(
                          color: Color(0XFF3F3D56),
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: 'John',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          color: Color(0XFF8D9CB8),
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Obx(
                  () => Text(
                    'You’ve got ${taskController.tasks.where((task) => !task.isDone).length} tasks to do.',
                    style: TextStyle(
                      color: Color(0XFF8D9CB8),
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () {
              if (taskController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (taskController.tasks.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/image1.png'),
                        SizedBox(height: 16),
                        Text(
                          'You have no task listed.',
                          style: TextStyle(
                            color: Color(0XFF8D9CB8),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () =>
                              showAddTaskDialog(context, taskController),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0XFFE4F2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Create task',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      TaskModel task = taskController.tasks[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0XFFF5F7F9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Color(0XFF007FFF),
                            value: task.isDone,
                            onChanged: (value) {
                              TaskModel updatedTask =
                                  task.copyWith(isDone: value);
                              taskController.updateTask(updatedTask);
                            },
                            side: BorderSide(
                              color: Color(0xFFC6CFDC),
                              width: 2,
                            ),
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
                                    color: Color(0XFF3F3D56),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: task.description.isNotEmpty
                              ? Text(
                                  task.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0XFF8D9CB8),
                                  ),
                                )
                              : null,
                          trailing: task.description.isEmpty
                              ? PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      showEditTaskDialog(
                                          context, taskController, task);
                                    } else if (value == 'delete') {
                                      taskController.deleteTask(task.id!);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return {'Edit', 'Delete'}.map(
                                      (String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice.toLowerCase(),
                                          child: Text(choice),
                                        );
                                      },
                                    ).toList();
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
