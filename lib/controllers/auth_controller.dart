import 'dart:async';

import 'package:photomanager/controllers/profile_controller.dart';

import '../utils/export_files.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
    required sharedPreferences,
  });

  // BOOL
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RxBool loading = false.obs;

  /// ********** TEXT EDITING CONTROLLERS

  // LOGIN
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  // SIGN-UP
  var signUpFullNameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpPhoneController = TextEditingController();
  var signUpOtpController = TextEditingController();
  var newPasswordController = TextEditingController();
  var changePassOtpController = TextEditingController();

  /// ********* END

  var counter = 60.obs;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // LOGIN PROCESS
  void initLoginProcess() {
    // Login Validation
    if (loginEmailController.text.isEmpty ||
        !GetUtils.isEmail(loginEmailController.text)) {
      MyStyles().showSnackBar(messageText: Constants.validEmailError);
      return;
    }
    if (loginPasswordController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validPassError);
      return;
    }
    loading(true);
    if (kDebugMode) {
      print('*************************************Init Login Process');
    }
    login(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
    );
  }

  String removeCountryCode(String phoneNumber) {
    final countryCodePrefixes = [
      Constants.defaultCountryCode,
    ];

    for (final prefix in countryCodePrefixes) {
      if (phoneNumber.startsWith(prefix)) {
        return phoneNumber.replaceFirst(prefix, '');
      }
    }

    return phoneNumber;
  }

  void initEnterPhone() async {
    // Enter Phone Validation

    if (signUpPhoneController.text.isEmpty ||
        !GetUtils.isPhoneNumber(signUpPhoneController.text)) {
      MyStyles().showSnackBar(messageText: Constants.validPhoneError);
      return;
    }
    loading(true);
    Response response = await getOtpData();
    debugPrint(
        "SEND OTP RESPONSE STATUS CODE ::::::::: ${response.statusCode}");
    debugPrint("SEND OTP RESPONSE BODY ::::::::: ${response.body}");
    if (response.statusCode == 200) {
      loading(false);
      Get.toNamed(RouteHelper.getEnterOtpRoute());
    } else {
      loading(false);
      ApiChecker.checkApi(response);
    }
    loading(false);
  }

  void initChangePassword() async {
    // Change Password Validation
    if (loginEmailController.text.isEmpty ||
        !GetUtils.isEmail(loginEmailController.text)) {
      MyStyles().showSnackBar(messageText: Constants.validEmailError);
      return;
    }
    if (newPasswordController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validPassError);
      return;
    }
    String strongPassword =
        MyUtils().isStrongPassword(newPasswordController.text.trim());
    if (strongPassword.isNotEmpty) {
      MyStyles().showSnackBar(messageText: strongPassword);
      return;
    }
    loading(true);
    Response response = await getChangeUserPassword();
    if (response.statusCode == 200) {
      // Get.to(const PasswordChangeSuccess());
      Get.snackbar(
        'Success',
        'Password updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(
        'Error',
        'Failed to change password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    loading(false);
  }

  void initEnterOtp() async {
    // Otp Form Validation
    if (signUpOtpController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validOtpError);
      return;
    }
    loading(true);
    Response response = await getOtpPhoneData();
    if (response.statusCode == 200) {
      loading(false);
      // CREATE ACCOUNT
      registration();
    } else {
      ApiChecker.checkApi(response);
      loading(false);
    }
  }



  void initChangeUserPassword() async {
    // Form Validation
    if (newPasswordController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validPassError);
      return;
    }
    loading(true);
    Response response = await getChangeUserPassword();
    if (response.statusCode == 200) {
      loading(false);
      Get.to(const PasswordChangeSuccess());
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }

  // LOGIN
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    loading(true);
    update();
    Response response = await authRepo.login(
      email: email,
      password: password,
    );

    if (response.statusCode == 200) {
      loginPasswordController.clear();
      authRepo.saveUserToken(response.body[Constants.token]);
      setCustomerEmail(response.body[Constants.emailStr]);
      setCustomerId(response.body['id']);
      //setCustomerPhone(response.body[Constants.phoneStr]);
      await Get.find<SplashController>().initUserInfo();
      Get.offAllNamed(RouteHelper.getHOmeRoute());

      _isLoading = false;
    } else {
      loginPasswordController.clear();
      _isLoading = false;
      loading(false);
      ApiChecker.checkApi(response);
    }
    loading(false);
    update();
    return response;
  }

  // SIGN-UP PROCESS
  void initSignUpProcess() {
    // Login Validation
    if (signUpFullNameController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validNameError);
      return;
    }
    if (!signUpFullNameController.text.trim().contains(' ')) {
      MyStyles().showSnackBar(messageText: Constants.addFirstAndLastNameError);
      return;
    }
    if (signUpEmailController.text.isEmpty ||
        !GetUtils.isEmail(signUpEmailController.text)) {
      MyStyles().showSnackBar(messageText: Constants.validEmailError);
      return;
    }
    if (signUpPasswordController.text.isEmpty) {
      MyStyles().showSnackBar(messageText: Constants.validPassError);
      return;
    }
    String strongPassword =
        MyUtils().isStrongPassword(signUpPasswordController.text.trim());
    if (strongPassword.isNotEmpty) {
      MyStyles().showSnackBar(messageText: strongPassword);
      return;
    }
    registration();
  }

  // REGISTRATION
  Future<Response> registration() async {
    _isLoading = true;
    loading(true);
    update();
    Map<String, String> customerInfo = {
      Constants.emailStr: signUpEmailController.text.trim(),
      Constants.firstName:
          signUpFullNameController.text.trim().split(' ').first,
      Constants.lastName: signUpFullNameController.text.trim().split(' ').last,
      Constants.passwordStr: signUpPasswordController.text.trim(),
    };

    Response response = await authRepo.registration(customerInfo);
    if (response.statusCode == 201) {
      Get.offNamed(RouteHelper.getLoginRoute());
      MyStyles()
          .showSnackBarGreen(messageText: response.body[Constants.messageStr]);
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getOtpData() async {
    loading(true);
    Response response = await authRepo.getOtpDataApi(
      MyUtils().processPhoneNumber(
          removeCountryCode(signUpPhoneController.text.trim())),
      signUpEmailController.text.trim(),
    );
    if (response.statusCode == 200) {
      loading(false);
      return response;
    } else {
      loading(false);
      ApiChecker.checkApi(response);
    }
    loading(false);
    return response;
  }

  Future<Response> getForgotOtpData() async {
    loading(true);
    Response response = await authRepo.getForgetOtpDataApi(
      MyUtils().processPhoneNumber(
          removeCountryCode(signUpPhoneController.text.trim())),
      signUpEmailController.text.trim(),
    );
    if (response.statusCode == 200) {
      loading(false);
      return response;
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
    return response;
  }

  Future<Response> getOtpForgotPassData() async {
    Response response = await authRepo.getOtpFogortPassApi(
      removeCountryCode(
          MyUtils().processPhoneNumber(signUpPhoneController.text.trim())),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      ApiChecker.checkApi(response);
    }
    return response;
  }

  Future<Response> postPhoneAndPassword() async {
    Response response = await authRepo.postOtpAndPasswordApi(
      MyUtils().processPhoneNumber(signUpPhoneController.text.trim()),
      newPasswordController.text.trim(),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      ApiChecker.checkApi(response);
    }
    return response;
  }

  Future<Response> getOtpPhoneData() async {
    Response response = await authRepo.checkIfOtpPhoneIsVerifiedApi(
      MyUtils().processPhoneNumber(
          removeCountryCode(signUpPhoneController.text.trim())),
      signUpOtpController.text.trim(),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      ApiChecker.checkApi(response);
    }
    return response;
  }

 

  Future<Response> getChangeUserPassword() async {
    loading(true);
    Response response = await authRepo.postOtpAndPasswordApi(
      loginEmailController.text.trim(),
      newPasswordController.text.trim(),
    );
    if (response.statusCode == 200) {
      loading(false);
      return response;
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
    return response;
  }

  void setCustomerEmail(String email) {
    authRepo.saveUserEmail(email);
  }

  void setCustomerId(String id) {
    authRepo.saveUserId(id);
  }

  void setCustomerPhone(String phone) {
    authRepo.saveUserPhone(phone);
  }

  String getCustomerEmail() {
    return authRepo.getCustomerEmail();
  }

  String getCustomerId() {
    return authRepo.getUserId();
  }

  String getCustomerPhone() {
    return authRepo.getCustomerPhone();
  }

  void setCustomerName(String name) {
    authRepo.saveCustomerName(name);
  }

  bool isFormValid(var key) {
    return authRepo.isFormValid(key);
  }

  String getAuthToken() {
    return authRepo.getUserToken();
  }

  void removeCustomerToken() {
    authRepo.removeCustomerToken();
  }

  void logOut() {
    authRepo.removeCustomerToken();

    // Clear user profile data
    Get.offAll(() => const LoginScreen());
    Get.find<ProfileController>().clearProfileData();
  }
}
