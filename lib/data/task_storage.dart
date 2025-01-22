import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/task.dart';

class TaskStorage {
  static const String _taskKey = 'tasks';

  // Сохранение списка заданий
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = tasks.map((task) => task.toJson()).toList();
    final taskListString = jsonEncode(taskListJson);
    await prefs.setString(_taskKey, taskListString);
  }

  // Получение списка заданий
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListString = prefs.getString(_taskKey);

    if (taskListString == null) {
      return [];
    }

    final List<dynamic> taskListJson = jsonDecode(taskListString);
    return taskListJson.map((json) => Task.fromJson(json)).toList();
  }

  // Добавление нового задания
  static Future<void> addTask(Task task) async {
    final tasks = await loadTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  // Удаление задачи по id
  static Future<void> deleteTask(String taskId) async {
    final tasks = await loadTasks();
    // Оставляем только задачи, у которых id не совпадает с taskId
    final updatedTasks = tasks.where((task) => task.id != taskId).toList();
    await saveTasks(updatedTasks);
  }

  // Обновление задачи по id
  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await loadTasks();
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      await saveTasks(tasks);
    }
  }
}
