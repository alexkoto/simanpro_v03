import 'package:http/http.dart' as http;

class ApiConnection {
  // Base URL for the API  
  // static const String baseUrl = 'http://192.168.7.69/simanpro';
  static const String baseUrl = 'http://192.168.100.14/simanpro';
  static const Duration timeout = Duration(seconds: 10);

  static Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(url, headers: headers).timeout(timeout);
      return response;
    } catch (e) {
      // Handle or log error appropriately
      rethrow;
    }
  }
}
