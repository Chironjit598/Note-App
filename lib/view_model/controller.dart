import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/model.dart';

class TaskViewModel extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;
  final TextEditingController controller = TextEditingController();
  int currentPriorty = 0;

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList("tasks");
    if (taskList != null) {
      tasks.assignAll(
          taskList.map((jsonString) => Task.fromJson(jsonDecode(jsonString))));
    }
  }

  void saveTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> taskList =
        tasks.map((task) => task.toJson()).toList();
    prefs.setStringList(
        "tasks", taskList.map((json) => jsonEncode(json)).toList());
  }

  void addTask({required String taskTitle}) {
    currentPriorty++;

    if (taskTitle.isNotEmpty) {
      tasks.add(Task(title: taskTitle, priorty: currentPriorty));
      controller.clear();
      saveTask();
    }
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTask();
  }

  void toggleTaskCompletion(int index) {
    Task task = tasks[index];

    if (task.dueDate != null && task.dueDate!.isBefore(DateTime.now())) {
      task.isCompleted = true;
    } else {
      task.isCompleted = !task.isCompleted;
    }

    tasks[index] = task;
    saveTask();
  }

  void toggleTaskImportance(int index) {
    Task task = tasks[index];
    task.isImportant = !task.isImportant;
    tasks[index] = task;
    saveTask();
  }

  void setTaskDueDate(int index, DateTime? dueDate) {
    Task task = tasks[index];
    task.dueDate = dueDate;
    tasks[index] = task;
    saveTask();
  }

  void setTaskPriorty(int index, int priorty) {
    Task task = tasks[index];
    task.priorty = priorty;
    tasks[index] = task;
    saveTask();
  }

  Future<void> showDatePickerDialog(BuildContext context, int index) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (picked != null) {
      setTaskDueDate(index, picked);
    }
  }

  Future<void> toggleThemeAndSave() async {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", Get.isDarkMode);
    saveTask();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTasks();
  }
}
