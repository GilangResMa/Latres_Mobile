import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/local_storage_service.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  var isLoading = false.obs;

  // Hardcoded credentials
  static const String _validUsername = 'harrypotter';
  static const String _validPassword = 'haripoah';

  Future<bool> login(String username, String password) async {
    try {
      isLoading.value = true;
      
      // Validate credentials
      if (username == _validUsername && password == _validPassword) {
        await LocalStorageService.setLoginSession(username);
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await LocalStorageService.logout();
      // Clear fields but don't dispose - let onClose() handle disposal
      usernameController.clear();
      passwordController.clear();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<bool> checkLoginStatus() async {
    return await LocalStorageService.isLoggedIn();
  }

  @override
  void onClose() {
    try {
      usernameController.dispose();
      passwordController.dispose();
    } catch (e) {
      debugPrint('Error disposing controllers: $e');
    }
    super.onClose();
  }
}
