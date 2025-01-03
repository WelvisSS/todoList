import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../controllers/task_controller.dart';
import '../widgets/edit_task_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 48,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search tasks...',
              fillColor: Color(0xFFF5F7F9),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFF80BFFF), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFF80BFFF), width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFF80BFFF), width: 2.0),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0XFF007FFF),
              ),
              suffixIcon: IconButton(
                iconSize: 20,
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  taskController.searchTasks('');
                },
              ),
            ),
            onChanged: (value) {
              taskController.searchTasks(value);
            },
          ),
        ),
      ),
      body: Obx(
        () {
          if (taskController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (taskController.filteredTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/image1.png'),
                  SizedBox(height: 16),
                  Text(
                    'No result found.',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0XFF8D9CB8),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: taskController.filteredTasks.length,
            itemBuilder: (context, index) {
              final task = taskController.filteredTasks[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0XFFF5F7F9),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: task.isDone,
                    activeColor: Color(0XFF007FFF),
                    onChanged: (value) {
                      TaskModel updatedTask = task.copyWith(isDone: value);
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
                              showEditTaskDialog(context, taskController, task);
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
          );
        },
      ),
    );
  }
}
