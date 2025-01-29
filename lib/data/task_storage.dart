import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/task.dart';

class TaskStorage {
  static TaskStorage? _instance;
  static late SharedPreferences _preferences;
  static const String _taskKey = 'tasks';

  TaskStorage._();

  // Using a singleton pattern
  static Future<TaskStorage> getInstance() async {
    _instance ??= TaskStorage._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Save List Tasks
  static Future<void> saveTasks(List<Task> tasks) async {
    // final prefs = await SharedPreferences.getInstance();
    final taskListJson = tasks.map((task) => task.toJson()).toList();
    final taskListString = jsonEncode(taskListJson);
    await _preferences.setString(_taskKey, taskListString);
  }

  // Get List Tasks
  static Future<List<Task>> loadTasks() async {
    final taskListString = _preferences.getString(_taskKey);

    if (taskListString == null) {
      return [];
    }

    final List<dynamic> taskListJson = jsonDecode(taskListString);
    return taskListJson.map((json) => Task.fromJson(json)).toList();
  }

  // Add new tasks
  static Future<void> addTask(Task task) async {
    final tasks = await loadTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  // delete tasks by id
  static Future<void> deleteTask(String taskId) async {
    final tasks = await loadTasks();
    // We only leave tasks for which the id does not match the taskId.
    // tasks.removeAt(int.parse(taskId));
    final updatedTasks = tasks.where((task) => task.id != taskId).toList();
    await saveTasks(updatedTasks);
  }

  // Update tasks by id
  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await loadTasks();
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      await saveTasks(tasks);
    }
  }
}
