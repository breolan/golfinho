import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _apiService.postData('login', {
        'username': username,
        'password': password,
      });

      if (response['token'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final response = await _apiService.postData('register', {
        'username': username,
        'email': email,
        'password': password,
      });

      return response['success'] == true;
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }
}
