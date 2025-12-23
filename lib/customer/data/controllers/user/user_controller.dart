import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/loader/loaders.dart';
import '../../../../utils/network/network_manager.dart';
import '../../models/user/user_model.dart';
import '../../repositories/user/user_repository.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get user => _user.value;
  RxString profileImageUrl = ''.obs;

  Future<void> fetchUserData() async {
    
    try{
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Loaders.errorSnackBar(
          title: 'لا يوجد انترنت',
          message: 'تحقق من اتصالك و اعد المحاولة ثانيةً!',
        );
        return;
      }
      // open loader
      RHelperFunctions.openLoadDialog(
       'جاري جلب بيانات المستخدم...',
        RImages.loader,
     );

       final role= await FlutterSecureStorage().read(key: 'role');
      print('from fetch :$role');

      if(role =='customer') {
        final fetchedUser = await userRepo.fetchCustomerData();
        _user.value = fetchedUser;
        setUser(fetchedUser);
        RHelperFunctions.stopLoading();
      } else if(role =='agency'){
        final fetchedUser = await userRepo.fetchAgencyData();
        _user.value = fetchedUser;
        setUser(fetchedUser);
        print('from fetch :${fetchedUser.name}');

        RHelperFunctions.stopLoading();
      } else {
        print('error not found role :${user!.role}');
      }

    } catch(e){
      Loaders.errorSnackBar(title: 'حدث خطأ ما', message: e.toString());
      RHelperFunctions.stopLoading();
      print('LOAD CURRENT USER ERROR: $e');
    }
  }

  void setUser(UserModel user) {
    _user.value = user;
    profileImageUrl.value = user.profilePhotoPath??'';
  }

  void clearUser() {
    _user.value = null;
  }

}