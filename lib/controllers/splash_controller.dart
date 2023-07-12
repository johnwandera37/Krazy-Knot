import 'dart:async';

import '../utils/export_files.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  var authController = Get.find<AuthController>();
  var profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    route();
    initSharedData();
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
}
