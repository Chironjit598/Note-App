import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/view_model/controller.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key});
  TaskViewModel taskViewModel = Get.put(TaskViewModel());

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kTextTabBarHeight + 20),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "TODO LIST",
              style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green])),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Add New Task",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              TextFormField(
                controller: taskViewModel.controller,
                onFieldSubmitted: (value) =>
                    taskViewModel.addTask(taskTitle: value),
                decoration: InputDecoration(
                    labelText: "Enter your task...",
                    labelStyle: const TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(25))),
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.blue,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pinkAccent, Colors.lightBlueAccent])),
                child: const Center(
                  child: Text(
                    "Task",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Expanded(
              //     child: Obx(() => ListView.builder(
              //         itemCount: 5,
              //         itemBuilder: (context, index) {
              //           return Text("HI");
              //         })))

              Expanded(
                  child: ListView.builder(
                      itemCount: taskViewModel.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskViewModel.tasks[index];
                        return ListTile(
                          title: Text(
                            task.isCompleted ? "✅${task.title}" : task.title,
                            style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: task.isCompleted
                                    ? Colors.green
                                    : Colors.blue,
                                fontWeight: task.isCompleted
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          subtitle: task.dueDate != null
                              ? Text(
                                  "Due Date: ${task.dueDate!.toLocal()}",
                                  style: const TextStyle(color: Colors.green),
                                )
                              : null,
                          trailing: Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    taskViewModel.toggleTaskCompletion(index),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => taskViewModel.showDatePickerDialog(
                                    context, index),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
