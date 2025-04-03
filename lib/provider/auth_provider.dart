import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isPasswordHidden = true;
  bool _isAuthenticated = false;

  bool get isPasswordHidden => _isPasswordHidden;

  bool get isAuthenticated => _isAuthenticated;

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  Future<bool> login(
      String username, String password, BuildContext context) async {
    if (username.isEmpty && password.isEmpty) {
      _showSnackBar(context, "Please enter your username and password");
      return false;
    } else if (username.isEmpty) {
      _showSnackBar(context, "Please enter your username");
      return false;
    } else if (password.isEmpty) {
      _showSnackBar(context, "Please enter your password");
      return false;
    } else if (username == "admin" && password == "admin@123") {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      _showSnackBar(context, "Invalid username or password");
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
