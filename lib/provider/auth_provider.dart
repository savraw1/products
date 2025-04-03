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
    if (username == "admin" && password == "admin@123") {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password!")),
      );
      return false;
    }
  }
}