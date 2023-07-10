


import '../utils/export_files.dart';

Future<void> init() async {
  // Core
  await Get.putAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: Environment.baseUrl,
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: Environment.baseUrl,
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

  // Repository
  Get.lazyPut<SplashRepo>(() => SplashRepo(
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

 
}
