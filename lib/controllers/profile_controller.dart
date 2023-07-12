

import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../utils/export_files.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({
    required this.profileRepo,
  });

  UserModel? _userModel;
  UserModel? get userInfo => _userModel;

  RxBool loading = false.obs;

  RxList<File> selectedImages = <File>[].obs;

  void pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      selectedImages.value = files;
    }
  }

  // EDIT-TEXT-CONTROLLER
  var editFirstNameController = TextEditingController();
  var editLastNameController = TextEditingController();
  var editEmailNameController = TextEditingController();

  fillEditControllers() {
    editFirstNameController.text = userInfo!.firstName;
    editLastNameController.text = userInfo!.lastName;
    editEmailNameController.text = userInfo!.email;
  }

  Future<void> profileData({
    bool reload = false,
    bool isUpdate = false,
  }) async {
    if (reload || _userModel == null) {
      _userModel = null;
      if (isUpdate) {
        update();
      }
    }

    if (_userModel == null) {
      var userPhone = Get.find<AuthController>().getCustomerPhone();
      Response response = await profileRepo.getProfileDataApi(userPhone);
      if (response.statusCode == 200) {
        _userModel = UserModel.fromJson(response.body);
        Get.find<AuthController>().setCustomerName(
            '${_userModel!.firstName} ${_userModel!.lastName}');
      } else {
        debugPrint('TAKE ME TO OOPS SCREEN+++++++++++++++++++++>');
        ApiChecker.checkApi(response);
        debugPrint(
          'TAKE ME TO OOPS SCREEN+++++++++++++++++++++>',
        );
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> postEditedUserDetails({
    bool reload = false,
    bool isUpdate = false,
  }) async {
    loading(true);

    Response response = await profileRepo.postProfileDataApi(
      userId: _userModel!.id,
      userEmail: editEmailNameController.text.trim(),
      userFName: editFirstNameController.text.trim(),
      userLName: editLastNameController.text.trim(),
    );
    if (response.statusCode == 200) {
      await profileData(reload: true);
      MyStyles()
          .showSnackBarGreen(messageText: Constants.accountUpdated);
    } else {
      ApiChecker.checkApi(response);
    }

    loading(false);
    update();
  }

  void clearProfileData() {
    _userModel = null;
    Get.find<AuthController>().loading(false);
    update();
  }
}
