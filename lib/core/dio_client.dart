import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/core/api_constants.dart';
import 'package:vehicle_rental_app/data/repositories/authentication/authentication_repository.dart';
import '../screens/login/login_screen.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept' : 'application/json',
      }
    )
  );

  static Dio get dio => _dio;


  static void setupInterceptors(){
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final secureStorage =  FlutterSecureStorage();
          final token = await secureStorage.read(key: 'token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print('Using token: ${token.substring(0, 20)}...');
          }
          return handler.next(options);
        },
        onError: (e , handler) async{
          final is401 = e.response?.statusCode == 401;
          if(!is401) return handler.next(e);

          final authRepo = AuthenticationRepository.instance;
          final newToken = await authRepo.refreshToken();

          if(newToken == null){
            await authRepo.logout();
            Get.offAll(() => const LoginScreen());

            return handler.next(e);

          }
          // update header and again the request
          final reqOptions = e.requestOptions;
          reqOptions.headers['Authorization'] = 'Bearer $newToken';

          try{

            final cloneResponse = await _dio.fetch(reqOptions);
            return handler.resolve(cloneResponse);
          } catch (err) {
            return handler.next(e);
          }

        }
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }

}
