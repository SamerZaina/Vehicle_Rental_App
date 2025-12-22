import 'package:dio/dio.dart';

class ApiService {
  ApiService._internal();

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late Dio dio;


  /// ✅ Initialize once (main.dart)
  void init({String? token}) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Check if initialized
  bool get isInitialized => dio != null;
}
