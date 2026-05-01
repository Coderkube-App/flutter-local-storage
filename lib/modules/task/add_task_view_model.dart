import 'package:flutter/material.dart';
import '../../core/services/database_helper.dart';
import '../../core/storage/shared_pref_helper.dart';
import '../../core/storage/key_storage.dart';
import '../../data/models/task_model.dart';

class AddTaskViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  
  String _priority = 'Medium';
  String get priority => _priority;

  DateTime? _dueDate;
  DateTime? get dueDate => _dueDate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setPriority(String? value) {
    if (value != null) {
      _priority = value;
      notifyListeners();
    }
  }

  void setDueDate(DateTime? date) {
    _dueDate = date;
    notifyListeners();
  }

  bool get isFormValid {
    return titleController.text.trim().isNotEmpty && _dueDate != null;
  }

  // To trigger rebuild when text changes
  void onTitleChanged(String value) {
    notifyListeners();
  }

  Future<bool> saveTask() async {
    if (!isFormValid) return false;

    setLoading(true);
    try {
      final ownerEmail = SharedPrefHelper.getString(KeyStorage.userEmail);
      if (ownerEmail == null) throw Exception('User email not found');

      final task = TaskModel.create(
        title: titleController.text.trim(),
        details: detailsController.text.trim(),
        priority: _priority,
        dueDate: _dueDate!.toIso8601String(),
        ownerEmail: ownerEmail,
      );

      await _dbHelper.insertTask(task);
      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }
}
