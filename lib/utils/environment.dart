

import 'export_files.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get baseUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
  static String get loginUrl => dotenv.env['LOGIN_URL'] ?? 'MY_FALLBACK';
  static String get userInfoUrl => dotenv.env['USER_INFO_URL'] ?? 'MY_FALLBACK';
  static String get editUserInfoUrl => dotenv.env['EDIT_USER_INFO_URL'] ?? 'MY_FALLBACK';
  static String get sendOtpUrl => dotenv.env['SEND_OTP_URL'] ?? 'MY_FALLBACK';
  static String get registerUrl => dotenv.env['REGISTER_URL'] ?? 'MY_FALLBACK';
  static String get changePasswordUrl => dotenv.env['CHANGE_PASSWORD_URL'] ?? 'MY_FALLBACK';
  static String get sendForgotOtpUrl => dotenv.env['SEND_FORGOT_OTP_URL'] ?? 'MY_FALLBACK';
  static String get speedTestUrl => dotenv.env['SPEED_TESTS_URL'] ?? 'MY_FALLBACK';
  static String get billsUrl => dotenv.env['BILLS_URL'] ?? 'MY_FALLBACK';
  static String get downloadBillUrl => dotenv.env['DOWNLOAD_BILL_URL'] ?? 'MY_FALLBACK';
}
