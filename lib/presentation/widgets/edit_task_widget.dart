import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../controllers/task_controller.dart';

void showEditTaskDialog(
    BuildContext context, TaskController taskController, TaskModel task) {
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final heightFactor =
          MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9 : 0.5;
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 40, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'What\'s in your mind?',
                    prefixIcon: Checkbox(
                      value: false,
                      onChanged: (value) {},
                      side: BorderSide(
                        color: Color(0xFFC6CFDC),
                        width: 2,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Add note.',
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color(0xFFC6CFDC),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        if (titleController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Title cannot be empty'),
                            ),
                          );
                          return;
                        }
                        final updatedTask = TaskModel(
                          id: task.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          isDone: task.isDone,
                          createdAt: task.createdAt,
                        );
                        taskController.updateTask(updatedTask);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0XFF007FFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
