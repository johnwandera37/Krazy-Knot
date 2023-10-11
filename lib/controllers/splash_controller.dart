import 'dart:async';

import 'package:photomanager/controllers/profile_controller.dart';

import '../utils/export_files.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  var authController = Get.find<AuthController>();
  var profileController = Get.find<ProfileController>();
  final LocationController locationController = Get.put(LocationController());

  @override
  void onInit() {
    route();
    initSharedData();
    fetchLongLat();
    super.onInit();
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData(); 
  }

  void route() {
    Timer(
      const Duration(seconds: 1),
      () {
        (authController.getAuthToken().isEmpty)
            ? Get.offNamed(RouteHelper.getLoginRoute())
            : initUserInfo();
      },
    );
  }

  Future initUserInfo() async {
    await Future.doWhile(() async {
      await profileController.profileData();
      return profileController.userInfo == null;
    });
    await Get.offNamed(RouteHelper.getLandingRoute());
  }

  String getCustomerEmail() {
    return Get.find().getString(Constants.emailStr) ?? '';
  }

  //await location data
   fetchLongLat() {
    locationController.fetchLocation();
    print('1111111111111111111111111111111111111111111111111111111111111111111Mydata location is now read');

  }

}
