import 'package:flutter/material.dart';
import '../../core/services/database_helper.dart';
import '../../core/storage/shared_pref_helper.dart';
import '../../core/storage/key_storage.dart';
import '../../data/models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool validateInputs() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setErrorMessage('Please fill in all fields');
      return false;
    }
    
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(emailController.text)) {
      setErrorMessage('Please enter a valid email address');
      return false;
    }
    
    setErrorMessage(null);
    return true;
  }

  Future<bool> login() async {
    if (!validateInputs()) return false;

    setLoading(true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      UserModel? user = await _dbHelper.getUserByEmail(email);

      if (user == null) {
        // Auto-registration
        user = UserModel.create(email: email, password: password);
        await _dbHelper.insertUser(user);
      } else {
        // Check password
        if (user.password != password) {
          setErrorMessage('Invalid password');
          setLoading(false);
          return false;
        }
      }

      // Save session
      await SharedPrefHelper.setString(KeyStorage.userEmail, user.email);
      await SharedPrefHelper.setBool(KeyStorage.token, true); // Using token as a logged-in flag

      setLoading(false);
      return true;
    } catch (e) {
      setErrorMessage('An error occurred: ${e.toString()}');
      setLoading(false);
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
