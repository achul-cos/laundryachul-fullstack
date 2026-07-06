import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  String? _token;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  String? get errorMessage => _errorMessage;

  // Login dengan hardcoded credentials
  // Versi 1.0
  // Future<bool> login(String email, String password) async {
  //   // Simulasi delay API
  //   await Future.delayed(Duration(milliseconds: 500));

  //   // Hardcoded credentials
  //   if (email == 'admin@laundry.com' && password == 'password') {
  //     _user = User(
  //       id: '1',
  //       email: email,
  //       name: 'Mario Wicaksono',
  //       role: 'Owner',
  //     );
  //     _isLoggedIn = true;
  //     notifyListeners();
  //     return true;
  //   }
  //   return false;
  // }

  // Login dengan BACKEND (bukan hardcoded)
  Future<bool> login(String email, String password) async {
    try {
      // Panggil backend API
      final result = await ApiService.login(email, password);

      if (result['success']) {
        // Success - set user dan token
        _user = User(
          id: result['user']['id'].toString(),
          email: result['user']['email'],
          name: result['user']['name'],
          role: result['user']['role'],
        );
        _token = result['token']; // Simpan token
        _isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        // Error
        _errorMessage = result['error'] ?? 'Login gagal';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      notifyListeners();
      return false;
    }
  }

  // Logout
  void logout() {
    _user = null;
    _token = null;
    _isLoggedIn = false;
    _errorMessage = null;
    notifyListeners();
  }
}
