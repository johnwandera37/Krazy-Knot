import 'package:photomanager/ui/home/landingScreen.dart';
import 'package:photomanager/ui/profile/preview_screen.dart';

import '../utils/export_files.dart';

class RouteHelper {
  static const String splash = Constants.splashRoute;
  static const String login = Constants.loginRoute;
  static const String signup = Constants.signUpRoute;
  static const String home = Constants.homeRoute;
  static const String forgotPassword = Constants.forgotRoute;
  static const String phoneOtp = Constants.enterPhoneOtpRoute;
  static const String enterOtp = Constants.enterOtpRoute;
  static const String forgotOtp = Constants.forgotOtpRoute;
  static const String newPassword = Constants.newPasswordRoute;
  static const String oops = Constants.oopsRoute;
  static const String profile = Constants.profileRoute;
  static const String enterPhone = Constants.enterPhoneRoute;
  static const String landing = Constants.landingRoute;
  static const String preview = Constants.previewRoute;

  static getSplashRoute() => Constants.splashStr;
  static getLoginRoute() => Constants.loginStr;
  static getLandingRoute() => Constants.landingStr;
  static getSignUpRoute() => Constants.signUp2Str;
  static getHOmeRoute() => Constants.homeStr;
  static getForgotPassRoute() => Constants.forgotPasswordStr;
  static getEnterPhoneRoute() => Constants.enterPhoneOtpStr;
  static getEnterOtpRoute() => Constants.enter_OtpStr;
  static getForgotOtpRoute() => Constants.forgotOtpStr;
  static getNewPasswordRoute() => Constants.newPasswordStr;
  static getOopsRoute() => Constants.oops;
  static getProfileRoute() => Constants.profileStr;
  static getPreviewRoute() => Constants.previewStr;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignUpScreen()),
    GetPage(name: enterOtp, page: () => const EnterOtpScreen()),
    GetPage(name: enterPhone, page: () => const EnterPhoneScreen()),
    GetPage(name: landing, page: () => const LandingPage()),
    GetPage(name: preview, page: () =>  PreviewScreen()),
  ];
}
