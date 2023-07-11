

import 'package:photomanager/utils/export_files.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  ThemeData get themeData =>
      isDarkTheme.value ? ThemeData.dark() : ThemeData.light();

  @override
  void onInit() {
    super.onInit();
    getSavedTheme();
  }

  Future<void> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool('isDarkTheme');
    if (savedTheme != null) {
      isDarkTheme.value = savedTheme;
    } else {
      final Brightness currentBrightness =
          MediaQuery.of(Get.context!).platformBrightness;
      isDarkTheme.value = currentBrightness == Brightness.dark;
    }
  }

  void toggleTheme() {
    isDarkTheme.toggle();
    Get.changeThemeMode(
      isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
    );
    saveTheme();
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme.value);
  }

  // THEME COLORS
  Color get backgroundColor => const Color(
          0xFFE4E4E4,
        );

  Color get fontColor =>  const Color(
          0xFF222222,
        );

  Color get shadowDarkColor => const Color(
          0xFF757575,
        );

  Color get shadowLightColor => const Color(
          0xFFffffff,
        );
}
