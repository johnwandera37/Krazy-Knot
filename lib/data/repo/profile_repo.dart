import '../../utils/export_files.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<Response> getProfileDataApi(String userPhone) async {
    return await apiClient.getWithParamData(
      Constants.baseUrl + Constants.userInfoUrl,
      queryParams: {
        Constants.phoneStr: userPhone,
      },
    );
  }

  Future<Response> postProfileDataApi({
    required String userId,
    required String userEmail,
    required String userFName,
    required String userLName,
  }) async {
    
    return await apiClient.putData(
      // TODO: BE CHANGED
      Constants.baseUrl + Constants.editUserInfoUrl,
      {
        Constants.userIdStr: userId,
        Constants.emailStr: userEmail,
        Constants.firstName: userFName,
        Constants.lastName: userLName,
      },
    );
  }
}
