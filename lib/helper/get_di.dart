import 'package:photomanager/controllers/profile_controller.dart';

import '../utils/export_files.dart';

Future<void> init() async {
  // Core
  await Get.putAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: Constants.baseUrl,
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: Constants.baseUrl,
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

  // Repository
  Get.lazyPut<SplashRepo>(() => SplashRepo(
        sharedPreferences: Get.find<SharedPreferences>(),
      ));

  Get.lazyPut<AuthRepo>(() => AuthRepo(
        sharedPreferences: Get.find<SharedPreferences>(),
        apiClient: Get.find<ApiClient>(),
      ));

  Get.lazyPut<ProfileRepo>(() => ProfileRepo(
        apiClient: Get.find<ApiClient>(),
      ));

  // Controller
  Get.lazyPut<SplashController>(
    () => SplashController(
      splashRepo: Get.find<SplashRepo>(),
    ),
  );

  Get.lazyPut<AuthController>(
    () => AuthController(
      sharedPreferences: Get.find<SharedPreferences>(),
      authRepo: Get.find<AuthRepo>(),
    ),
  );

  Get.lazyPut<ProfileController>(() => ProfileController(
        profileRepo: Get.find<ProfileRepo>(),
      ));

  Get.lazyPut<ThemeController>(() => ThemeController());

  Get.lazyPut<EventController>(() => EventController());
}
