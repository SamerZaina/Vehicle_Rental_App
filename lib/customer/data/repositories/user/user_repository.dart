import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:vehicle_rental_app/core/api_constants.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';

import '../../models/user/user_model.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  // function to fetch customer data fron the api
   Future<UserModel> fetchCustomerData() async {
  try {
    final response = await DioClient.dio.get(ApiConstants.customerProfile);
    print('FETCH CURRENT USER RESPONSE: ${response.data}');

    final data = response.data['user'] ?? response.data?? response.data['data'];
    final userJson = Map<String, dynamic>.from(data as Map);
    final user = UserModel.fromJson(userJson);
    print('from repo  ${user.role}');
    return user;
  }
  on DioException catch (e){
    print('FETCH CURRENT USER DIO ERROR: ${e.response?.data} ');
    rethrow;
  } catch (e){
    print('FETCH CURRENT USER UNKNOWN ERROR: $e');
    rethrow;
  }

     }

  // function to fetch agency data fron the api
  Future<UserModel> fetchAgencyData() async {
    try {
      final response = await DioClient.dio.get(ApiConstants.agencyProfile);
      final data = response.data['agency'] ?? response.data?? response.data['data'];
      final userJson = Map<String, dynamic>.from(data as Map);
      final user = UserModel.fromJson(userJson);
      print("RAW USER JSON => $userJson");
      print('from repo  ${user.role}');
      return user;
    }
    on DioException catch (e){
      print('FETCH CURRENT USER DIO ERROR: ${e.response?.data} ');
      rethrow;
    } catch (e){
      print('FETCH CURRENT USER UNKNOWN ERROR: $e');
      rethrow;
    }

  }

     //Function to update customer profile
   Future<void> updateCustomerProfile({
     String? name,
      String? phone,
     PlatformFile? drivingLicense,
     File? profileImageFile,

   }) async{
     MultipartFile? license;
     if(drivingLicense!= null && drivingLicense.path!= null){
       license = await MultipartFile.fromFile(
         drivingLicense.path!,
         filename: drivingLicense.name
       );
       print('{$drivingLicense}');
     }
     final formData = FormData.fromMap({
       '_method' : 'PATCH',
       'name': name,
       'phone': phone,
       if (license != null) 'driving_license': license,
       if (profileImageFile != null) 'photo': await MultipartFile.fromFile(
         profileImageFile.path,
         filename: profileImageFile.path.split('/').last,
       ),

     });
     await DioClient.dio.post(
       ApiConstants.customerProfile,
       data : formData,
         options: Options(
             contentType: 'multipart/form-data')
     );
   }

  //Function to update Agency profile
  Future<void> updateAgencyProfile({
     String? name,
     String ? phone,
    String ? address,
    String ? commercialRegisterNum,
    PlatformFile? commercialRegister,
    File? profileImageFile,

  }) async{
    MultipartFile? license;
    if(commercialRegister!= null && commercialRegister.path!= null){
      license = await MultipartFile.fromFile(
          commercialRegister.path!,
          filename: commercialRegister.name
      );
      print('{$commercialRegister}');
    }
    final formData = FormData.fromMap({
      '_method' : 'PATCH',
      'name': name,
      'phone': phone,
      'address': address,
      'commercial_register_number': commercialRegisterNum,
      if (license != null) 'commercial_register': license,
      if (profileImageFile != null)  'photo': profileImageFile
    });
    await DioClient.dio.post(
        ApiConstants.agencyProfile,
        data : formData,
        options: Options(
            contentType: 'multipart/form-data')
    );
  }
  Future<bool> uploadProfileImageOnly({
    required File profileImage,
    required String role,
  }) async {
    try {

      FormData formData = FormData.fromMap({
        '_method' :'PATCH',
        'photo': await MultipartFile.fromFile(
          profileImage.path,
        ),
      });
      final response = await DioClient.dio.post(
        '/$role/profile/updatePhoto',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return response.statusCode == 200;

    } catch (e) {
      print('Upload profile image only error: $e');
      return false;
    }
  }
}