import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/core/constants.dart';

class ApiService {
  static const _storage = FlutterSecureStorage();
  
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (auth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  /// GET con soporte para paginación (page, limit)
  Future<dynamic> get(String path, {bool auth = true, int? page, int? limit}) async {
    var uri = Uri.parse('$apiBaseUrl$path');
    if (page != null || limit != null) {
      final queryParams = <String, String>{};
      if (page != null) queryParams['page'] = page.toString();
      if (limit != null) queryParams['limit'] = limit.toString();
      uri = uri.replace(queryParameters: queryParams);
    }
    
    final response = await http
        .get(uri, headers: await _headers(auth: auth))
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body, {bool auth = true}) async {
    final response = await http
        .post(
          Uri.parse('$apiBaseUrl$path'),
          headers: await _headers(auth: auth),
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Error en la petición');
  }
}
