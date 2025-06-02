import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simanpro_v03/services/api_connection.dart';
import 'package:simanpro_v03/services/local_storage.dart';

class ApiUser {
  // Endpoints
  static const String loginEndpoint = '/user/login.php';
  static const String registerEndpoint = '/user/register.php';
  static const String usersEndpoint = '/user/users.php';
  static const String userEndpoint = '/user/user.php';

  // Common headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  // Timeout duration
  static const Duration timeout = Duration(seconds: 15);

  static Future<Map<String, String>> getAuthHeaders() async {
    final authData = await LocalStorage.getAuthData();
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      if (authData['token'] != null)
        'Authorization': 'Bearer ${authData['token']}',
    };
  }

  // Register user
  static Future<Map<String, dynamic>> registerUser(
    String name,
    String email,
    String password, {
    String roleId = '6',
  }) async {
    // Input validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return {'success': false, 'message': 'All fields are required'};
    }

    try {
      final response = await http
          .post(
            Uri.parse('${ApiConnection.baseUrl}$registerEndpoint'),
            headers: headers,
            body: {
              'name': name,
              'email': email,
              'password': password,
              'role_id': roleId,
            },
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      print('Register Exception: $e');
      return {
        'success': false,
        'message': 'Failed to register. Please try again.',
      };
    }
  }

  // Login user
  static Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConnection.baseUrl}$loginEndpoint'),
            headers: headers,
            body: {'email': email, 'password': password},
          )
          .timeout(timeout);

      print('Login Response: ${response.body}'); // Add this for debugging
      print('Status Code: ${response.statusCode}'); // Add this for debugging

      final result = _handleResponse(response);

      if (result['success'] == true) {
        // Check different possible token locations in response
        result['token'] =
            result['token'] ??
            result['data']['token'] ??
            result['access_token'] ??
            '';
        result['status'] = 1; // Ensure status is set
      }
      return result;
    } catch (e) {
      print('Login Exception: $e');
      return {
        'success': false,
        'message': 'Failed to login. Please check your credentials.',
        'status': 0,
      };
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    try {
      // Attempt to clear both auth and user data
      await Future.wait([
        LocalStorage.clearAuthData().catchError((e) {
          print('Error clearing auth data: $e');
        }),
        LocalStorage.clearUserData().catchError((e) {
          print('Error clearing user data: $e');
        }),
      ]);

      return {
        'success': true,
        'message': 'Logout berhasil',
        'status': 1, // Ensure consistent status code
      };
    } catch (e, stackTrace) {
      print('Logout error: $e');
      print('Stack trace: $stackTrace');

      // Even if error occurs, try to clear data
      await LocalStorage.clearAuthData().catchError((_) {});
      await LocalStorage.clearUserData().catchError((_) {});

      return {
        'success': false,
        'message': 'Gagal logout lengkap. Data lokal telah dihapus.',
        'status': 0,
      };
    }
  }

  // Get all users
  static Future<List<dynamic>> getAllUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConnection.baseUrl}$usersEndpoint'),
            headers: headers,
          )
          .timeout(timeout);

      final result = _handleResponse(response);
      if (result['success'] == true) {
        return result['data'] ?? [];
      }
      return [];
    } catch (e) {
      print('Get Users Exception: $e');
      return [];
    }
  }

  // Get user by ID
  static Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConnection.baseUrl}$userEndpoint'),
            headers: headers,
            body: {'id': userId},
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      print('Get User Exception: $e');
      return {'success': false, 'message': 'Failed to fetch user details.'};
    }
  }

  // Update user
  static Future<Map<String, dynamic>> updateUser(
    String userId,
    String name,
    String email, {
    String? password,
    String? roleId,
  }) async {
    try {
      final body = {'id': userId, 'name': name, 'email': email};

      if (password != null && password.isNotEmpty) {
        body['password'] = password;
      }
      if (roleId != null && roleId.isNotEmpty) {
        body['role_id'] = roleId;
      }

      final response = await http
          .post(
            Uri.parse('${ApiConnection.baseUrl}$userEndpoint'),
            headers: headers,
            body: body,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      print('Update User Exception: $e');
      return {'success': false, 'message': 'Failed to update user.'};
    }
  }

  // Delete user
  static Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConnection.baseUrl}$userEndpoint'),
            headers: headers,
            body: {'id': userId, '_method': 'DELETE'},
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      print('Delete User Exception: $e');
      return {'success': false, 'message': 'Failed to delete user.'};
    }
  }

  // Unified response handler
  static Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final responseData = jsonDecode(response.body);
      print('Parsed Response Data: $responseData');

      if (response.statusCode == 200) {
        // Handle your specific API response structure
        if (responseData['status'] == 1) {
          // Your API uses status:1 for success
          return {
            'success': true,
            'status': responseData['status'],
            'message': responseData['msg'] ?? 'Login berhasil',
            'data': responseData['user'] ?? {},
            // Add user data to the response
            'user': responseData['user'],
            // For apps that expect a token
            'token':
                responseData['token'] ??
                'dummy_token', // Replace with actual token if available
          };
        } else {
          return {
            'success': false,
            'status': responseData['status'] ?? 0,
            'message': responseData['msg'] ?? 'Login failed',
          };
        }
      } else {
        return {
          'success': false,
          'status': 0,
          'message': responseData['msg'] ?? 'Server error occurred',
        };
      }
    } catch (e) {
      print('Error parsing response: $e');
      return {
        'success': false,
        'status': 0,
        'message': 'Invalid server response format',
      };
    }
  }
}
