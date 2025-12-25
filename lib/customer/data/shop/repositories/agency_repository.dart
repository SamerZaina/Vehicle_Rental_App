import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/core/api_constants.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';

import '../../models/user/agency_model.dart';

class AgencyRepository extends GetxController {
  static AgencyRepository get instance => Get.find();


  Future<List<AgencyModel>> fetchAllAgencies() async{
    try{
      final response = await DioClient.dio.get(ApiConstants.fetchAgencies);
      if(response.data == null){
        throw Exception('لا توجد بيانات');
      }
      final data = response.data as Map<String, dynamic>;
      if(!data['success']){
        throw Exception(data['message']?? 'فشل في جلب البيانات');
      }
      final agenciesList = data['agencies'] as List<dynamic>;
      return agenciesList.map((e) => AgencyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e){
      print('خطأ في الاتصال: ${e.message}');
      print('تفاصيل الخطأ: ${e.response?.data}');
       return [];
    }catch (e) {
      print('خطأ غير متوقع: $e');
      throw Exception('حدث خطأ غير متوقع: $e');
    }

  }

   Future <List<Map<String, dynamic>>> fetchAgencyVehicles(int id) async{
    try{
      final response = await DioClient.dio.get('${ApiConstants.fetchAgencies}/$id/cars');
       if(response.data == null){
         throw Exception('لا توجد بيانات');
       }
       final data = response.data as Map<String , dynamic>;
       if(!data['success']){
         throw Exception(data['message'] ?? 'فشل في جلب البيانات');
       }
       final vehiclesList = data['agencyCars'] as List<dynamic>;
       return vehiclesList.map((e)=> Map<String, dynamic>.from(e as Map))
           .toList();
    }on DioException catch (e){
      print('خطأ في الاتصال: ${e.message}');
      print('تفاصيل الخطأ: ${e.response?.data}');
      return [];
    }catch (e) {
      print('خطأ غير متوقع: $e');
      throw Exception('حدث خطأ غير متوقع: $e');
    }
   }




}