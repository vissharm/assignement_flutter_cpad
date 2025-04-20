import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/hr_user.dart';

class AuthService {
  Future<ParseResponse> signUp(String email, String password) async {
    final user = HRUser(
      username: email,
      password: password.trim(),
      emailAddress: email,
    );

    return await user.signUp();
  }

  Future<ParseResponse> login(String email, String password) async {
    try {
      final user = ParseUser(email, password, email);
      final response = await user.login();
      
      if (!response.success) {
        throw Exception(response.error?.message ?? 'Login failed');
      }
      
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      final user = await ParseUser.currentUser();
      if (user != null) {
        await user.logout();
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final user = await ParseUser.currentUser();
      if (user != null) {
        //Validate session token
        final response = await ParseUser.getCurrentUserFromServer(user.sessionToken);
        if (response != null) {
          return response.success;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}


