import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  /// ApiClient <~> set headers
  ApiClient() {
    _dio.options.baseUrl = AppConstants.getBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'accept': 'application/json',
      "content-type": "application/json"
    };
  }

  /// getHeader --
  Future<Map<String, dynamic>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return {
      'accept': 'application/json',
      "content-type": "application/json",
      'User-Agent': 'Dart/Flutter',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Get Response <~>
  Future<Response> getData(String endPath) async {
    try {
      // _dio.options.headers = await _getHeaders();
      Response response = await _dio.get(endPath,
          options: Options(responseType: ResponseType.json));
      log("${_dio.options.baseUrl + endPath}\n[DATA : ${response.statusCode}] --- ${response.data}",
          name: "response");
      return response;
    } catch (e) {
      log("$e", name: "API ERROR");
      throw Exception("Failed Get Data: $e");
    }
  }

  /// Post Response <~>
  Future<Response> post(String endPath, dynamic data) async {
    try {
      _dio.options.headers = await _getHeaders();
      Response response = await _dio.post(endPath, data: data);
      log("${_dio.options.baseUrl + endPath}\n[DATA : ${response.statusCode}] --- ${response.data}",
          name: "response");
      return response;
    } catch (e) {
      throw Exception("Failed Post Data: $e");
    }
  }

  /// Put Response <~>
  Future<Response> put(String endPath, dynamic data) async {
    try {
      _dio.options.headers = await _getHeaders();
      Response response = await _dio.put(endPath, data: data);
      log("${_dio.options.baseUrl + endPath}\n[DATA : ${response.statusCode}] --- ${response.data}",
          name: "response");
      return response;
    } catch (e) {
      throw Exception("Failed Put Data: $e");
    }
  }

  /// Delete Response <~>
  Future<Response> delete(String endPath) async {
    try {
      _dio.options.headers = await _getHeaders();
      Response response = await _dio.delete(endPath);
      log("${_dio.options.baseUrl + endPath}\n[DATA : ${response.statusCode}] --- ${response.data}",
          name: "response");
      return response;
    } catch (e) {
      throw Exception("Failed Delete Data: $e");
    }
  }
}
