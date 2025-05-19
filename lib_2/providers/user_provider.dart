import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login(String role) {
    _user = User(id: "1", name: "Usuario", email: "user@example.com", role: role);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}