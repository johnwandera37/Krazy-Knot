import '../../utils/export_files.dart';

class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({
    required this.sharedPreferences,
  });

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(Constants.theme)) {
      return sharedPreferences.setBool(Constants.theme, false);
    }

    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }

}
