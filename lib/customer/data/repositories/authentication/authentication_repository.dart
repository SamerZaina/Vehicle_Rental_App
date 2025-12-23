import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_rental_app/core/api_constants.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/screens/on_boarding/onBoarding.dart';
import 'package:vehicle_rental_app/widgets/navigation_menu.dart';

import '../../../../agency/agency_bottom_navigation_item/bottom_navigation.dart';
import '../../controllers/user/user_controller.dart';
import '../../models/user/user_model.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final secureStorage = FlutterSecureStorage();

  // Function to show relevant screen
  @override
  void onInit() {
    super.onInit();
    //redirect();
  }

  Future<void> redirect() async {
    // check onboarding
    final isFirstTime = deviceStorage.read('isFirstTime') ?? true;
    if (isFirstTime) {
      Get.offAll(() => Onboarding());
      return;
    }
    final token = await secureStorage.read(key: 'token');
    print('$token');
    if (token != null && token.isNotEmpty) {
      // logged in
      final role = await secureStorage.read(key: 'role');
      if (role != null) {
        print('from redirect $role');
        if (role == 'customer') {
          Get.offAll(() => NavigationMenu());
        } else if (role == 'agency') {
          Get.offAll(() => BottomNavigation());
        } else {
          Get.offAll(() => LoginScreen());
        }
      }
    }else {
      Get.offAll(() => LoginScreen());
    }
  }
    // Register function for Customer
    Future<UserModel> registerCustomer({
      required String name,
      required String email,
      required String phone,
      required String password,
      required String passwordConfirmation,
      PlatformFile? drivingLicenseFile,
    }) async {
      try {
        MultipartFile? licenseFile;
        if (drivingLicenseFile != null && drivingLicenseFile.path != null) {
          licenseFile = await MultipartFile.fromFile(
            drivingLicenseFile.path!,
            filename: drivingLicenseFile.name,
          );
        }

        final formData = FormData.fromMap({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          if (licenseFile != null) 'driving_license': licenseFile,
          'password_confirmation': passwordConfirmation
        });
        final response = await DioClient.dio.post(
            ApiConstants.registerCustomer,
            data: formData,
            options: Options(
                contentType: 'multipart/form-data')
        );
        print('REGISTER CUSTOMER RESPONSE: ${response.data}');
        print('RAW TYPE: ${response.data.runtimeType}');


        if (response.data is! Map) {
          throw 'رد غير متوقع من السيرفر.';
        }
        final res = response.data as Map<String, dynamic>;
        final token = res['token'] as String?;
        if (token != null ) {
          await secureStorage.write(key: 'token', value: token);
        }
        Map<String, dynamic> userMap;

        if (res['data'] is Map) {
          userMap = Map<String, dynamic>.from(res['data'] as Map);
        } else {
          userMap = Map<String, dynamic>.from(res.cast<String, dynamic>());
        }

        final user = UserModel.fromJson(userMap);

        await secureStorage.write(key: 'role', value: user.role);
        await deviceStorage.write('user', user.toJson());

        return user;
      } on DioException catch (e) {
        print('REGISTER CUSTOMER DIO ERROR: ${e.response?.data}');
        final msg = e.response?.data is Map ? e.response?.data['message']
            ?.toString() : null;
        throw msg ?? 'خطأ اثناء الاتصال بالخادم';
      } catch (e) {
        print('REGISTER CUSTOMER UNK ERROR: $e');
        throw e.toString();
      }
    }


    // Register function for Agency
    Future<UserModel> registerAgency({
      required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required String passwordConfirmation,
      required String commercialRegisterNumber,
      PlatformFile? commercialLicenseFile,

    }) async {
      try {
        MultipartFile? licenseFile;
        if (commercialLicenseFile != null &&
            commercialLicenseFile.path != null) {
          licenseFile = await MultipartFile.fromFile(
            commercialLicenseFile.path!,
            filename: commercialLicenseFile.name,
          );
        }
        final formData = FormData.fromMap({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'address': address,
          'commercial_register_number': commercialRegisterNumber,
          'password_confirmation': passwordConfirmation,
          if (licenseFile != null) 'commercial_register': licenseFile,

        });
        final response = await DioClient.dio.post(
            ApiConstants.registerAgency,
            data: formData,
            options: Options(
                contentType: 'multipart/form-data')
        );
        print('REGISTER AGENCY RESPONSE: ${response.data}');
        print('RAW TYPE: ${response.data.runtimeType}');

        final data = response.data['data'] ?? response.data['user'];
        final token = response.data['token'];

        if (data == null || token == null) {
          throw Exception('Invalid login response from server');
        }
        // convert the data to user model
        final user = UserModel.fromJson(data);

        UserController.instance.setUser(user);
        // store the token
        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'role',value:  user.role);

        return user;
      } on DioException catch (e) {
        print('REGISTER CUSTOMER DIO ERROR: ${e.response?.data}');
        final msg = e.response?.data is Map ? e.response?.data['message']
            ?.toString() : null;
        throw msg ?? 'خطأ اثناء الاتصال بالخادم';
      } catch (e) {
        print('REGISTER CUSTOMER UNK ERROR: $e');
        throw e.toString();
      }
    }

    // function to login user
    Future<UserModel> loginWithEmail({
      required String email,
      required String password,
    }) async {
      try {
        final body = {
          'email': email,
          'password': password
        };
        final response = await DioClient.dio.post(
            ApiConstants.login,
            data: body
        );
        print('LOGIN RESPONSE: ${response.data}');
        final data = response.data['data'] ?? response.data['user'];
        final token = response.data['token'];

        if (data == null || token == null) {
          throw Exception('Invalid login response from server');
        }
        // convert the data to user model
        final user = UserModel.fromJson(data);

        UserController.instance.setUser(user);
        // store the token
        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'role',value:  user.role);


        return user;
      } on DioException catch (e) {
        print('LOGIN DIO ERROR: ${e.response?.data ?? e.message}');
        final serverMsg = e.response?.data['message'];
        throw Exception(serverMsg ?? 'فشل تسجيل الدخول، حاول مرة أخرى');
      } catch (e) {
        print('LOGIN UNKNOWN ERROR: $e');
        throw Exception('حدث خطأ غير متوقع أثناء تسجيل الدخول');
      }
    }


    Future<String?> refreshToken() async {
      try {
        final oldToken = await secureStorage.read(key: 'token');
        print('OLD TOKEN: $oldToken');
        final response = await DioClient.dio.post(ApiConstants.refreshToken);
        print('REFRESH STATUS: ${response.statusCode}');
        print('REFRESH DATA: ${response.data}');
        final newToken = response.data['token'] ??
            response.data['data']?['token'];

        if (newToken != null && newToken
            .toString()
            .isNotEmpty) {
          await secureStorage.write(
              key: 'new_token', value: newToken.toString());
          return newToken.toString();
        }
        final saved = await secureStorage.read(key: 'new_token');
        print('SAVED TOKEN: $saved');


        return newToken;
      } catch (e) {
        return null;
      }
    }

    //

    // function to logout user
    Future<void> logout() async {
      try {
        await secureStorage.delete(key: 'token');
        await deviceStorage.remove('role');
        Get.offAll(() => const LoginScreen());
      } catch (e) {
        print('LOGOUT ERROR: $e');
        Get.offAll(() => const LoginScreen());
      }
    }

}
