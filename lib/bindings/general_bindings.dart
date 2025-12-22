import 'package:get/get.dart';
import 'package:vehicle_rental_app/data/controllers/user/user_controller.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../utils/network/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(UserController());
  }
}