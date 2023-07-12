import '../../utils/export_files.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> login({
    required String phone,
    required String password,
  }) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.loginUrl,
      queryParams: {
        Constants.phoneStr: phone,
        Constants.passwordStr: password,
      },
    );
  }

  Future<Response> registration(Map<String, String> customerInfo) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.registerUrl,
      queryParams: customerInfo ?? {},
    );
  }

  Future<Response> getUserInfo() async {
    return await apiClient.getData(
      Constants.baseUrl,
      query: {},
      headers: {},
    );
  }

  Future<Response> getOtpDataApi(
    String userPhone,
    String userEmail,
  ) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.sendOtpUrl,
      queryParams: {
        Constants.phoneStr: Constants.defaultCountryCode + userPhone,
        Constants.emailStr: userEmail,
      },
    );
  }

  Future<Response> getForgetOtpDataApi(
    String userPhone,
    String userEmail,
  ) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.sendForgotOtpUrl,
      queryParams: {
        Constants.phoneStr: Constants.defaultCountryCode + userPhone,
        Constants.emailStr: userEmail,
      },
    );
  }

  Future<Response> getOtpFogortPassApi(String userPhone) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.changePasswordUrl,
      queryParams: {
        Constants.phoneStr: Constants.defaultCountryCode + userPhone,
      },
    );
  }

  Future<Response> postOtpAndPasswordApi(
      String userPhone, String password) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.changePasswordUrl,
      queryParams: {
        Constants.phoneStr: userPhone,
        Constants.passwordStr: password,
      },
    );
  }

  Future<Response> checkIfOtpPhoneIsVerifiedApi(
      String userPhone, String otp) async {
    return await apiClient.postWithParamsData(
      Constants.baseUrl + Constants.sendOtpUrl,
      queryParams: {
        Constants.phoneStr: Constants.defaultCountryCode + userPhone,
        Constants.otpStr: otp,    
      },                               
    );
  }          
  
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(Constants.token, token);
  } 

  Future<void> saveUserEmail(String email) async {         
    try {
      await sharedPreferences.setString(Constants.emailStr, email);
    } catch (e) { 
      rethrow;   
    }
  }

  Future<void> saveUserPhone(String phone) async {
    try {
      await sharedPreferences.setString(Constants.phoneStr, phone);
    } catch (e) {
      rethrow;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(Constants.token) ?? '';
  }

  String getCustomerEmail() {
    return sharedPreferences.getString(Constants.emailStr) ?? '';
  }

  String getCustomerPhone() {
    return sharedPreferences.getString(Constants.phoneStr) ?? '';
  }

  bool isFormValid(var key) {
    return key.currentState!.validate();
  }

  Future<void> saveCustomerName(String name) async {
    try {
      await sharedPreferences.setString(Constants.customerNameStr, name);
    } catch (e) {
      rethrow;
    }
  }

  String getCustomerName() {
    return sharedPreferences.getString(Constants.customerNameStr) ?? '';
  }

  void removeCustomerToken() async {
    await sharedPreferences.remove(Constants.token);
  }
}
