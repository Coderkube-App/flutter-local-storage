import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/services/database_helper.dart';
import '../../core/storage/shared_pref_helper.dart';
import '../../core/storage/key_storage.dart';
import '../../data/models/task_model.dart';

class DashboardViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  String? _userEmail;
  String? get userEmail => _userEmail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((t) => t.isCompleted).length;

  // Track tasks that are being deleted after completion
  final Set<String> _pendingDeletions = {};

  DashboardViewModel() {
    _init();
  }

  Future<void> _init() async {
    _userEmail = SharedPrefHelper.getString(KeyStorage.userEmail);
    await fetchTasks();
  }

  Future<void> fetchTasks() async {
    if (_userEmail == null) return;
    
    setLoading(true);
    _tasks = await _dbHelper.getTasksByOwner(_userEmail!);
    setLoading(false);
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    if (_pendingDeletions.contains(task.id)) return;

    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await _dbHelper.updateTask(updatedTask);
    
    // Update local list
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }

    if (updatedTask.isCompleted) {
      _pendingDeletions.add(task.id);
      
      // Delete after 3-4 seconds
      Timer(const Duration(seconds: 4), () async {
        await _dbHelper.deleteTask(task.id);
        _tasks.removeWhere((t) => t.id == task.id);
        _pendingDeletions.remove(task.id);
        notifyListeners();
      });
    }
  }

  bool isOverdue(String dueDate) {
    try {
      final due = DateTime.parse(dueDate);
      final now = DateTime.now();
      // Only compare date part if needed, but the requirement says "if Date == Due Date"
      // and "once the due deadline has been reached". 
      // Usually "deadline reached" means now >= due.
      return now.isAfter(due);
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await SharedPrefHelper.remove(KeyStorage.userEmail);
    await SharedPrefHelper.remove(KeyStorage.token);
  }
}
