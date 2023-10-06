import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
export 'package:photomanager/data/model/response/user_model.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:photomanager/data/model/response/day_five_image_model.dart';
import 'package:photomanager/data/model/response/day_four_image_model.dart';
import 'package:photomanager/data/model/response/day_three_image_model.dart';
import 'package:photomanager/data/model/response/day_two_image_model.dart';
import 'package:photomanager/data/model/response/single_image_model.dart';
import 'package:photomanager/data/model/response/user_model.dart';
import '../utils/export_files.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({
    required this.profileRepo,
  });

  UserModel? _userModel;
  UserModel? get userInfo => _userModel;

  DayImageModel? _dayImageModel;
  DayImageModel? get dayImageModel => _dayImageModel;

  DayTwoImageModel? _dayTwoImageModel;
  DayTwoImageModel? get dayTwoImageModel => _dayTwoImageModel;

  DayThreeImageModel? _dayThreeImageModel;
  DayThreeImageModel? get dayThreeImageModel => _dayThreeImageModel;

  DayFourImageModel? _dayFourImageModel;
  DayFourImageModel? get dayFourImageModel => _dayFourImageModel;

  DayFiveImageModel? _dayFiveImageModel;
  DayFiveImageModel? get dayFiveImageModel => _dayFiveImageModel;

  RxBool loading = false.obs;

  RxBool imageuploading = false.obs;

  RxList<File> selectedImages = <File>[].obs;

  var commentController = TextEditingController();

  // void pickImages() async {
  //   List<XFile>? imageFiles = await ImagePicker().pickMultiImage();
  //   if (imageFiles != null) {
  //     selectedImages.value =
  //         imageFiles.map((imageFile) => File(imageFile.path)).toList();
  //   }
  // }

  // EDIT-TEXT-CONTROLLER
  var editFirstNameController = TextEditingController();
  var editLastNameController = TextEditingController();
  var editEmailNameController = TextEditingController();

  fillEditControllers() {
    editFirstNameController.text = userInfo!.firstName!;
    editLastNameController.text = userInfo!.lastName!;
    editEmailNameController.text = userInfo!.email!;
  }

  Future<void> profileData() async {
    var userPhone = Get.find<AuthController>().getCustomerId();
    Response response = await profileRepo.getProfileDataApi(userPhone);
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      debugPrint('USER INFO +++++++++++++++++++++>');
      Get.find<AuthController>()
          .setCustomerName('${_userModel!.firstName} ${_userModel!.lastName}');
    } else {
      debugPrint('TAKE ME TO OOPS SCREEN+++++++++++++++++++++>');
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getDayImages(String day) async {
    Response response = await profileRepo.getDayImages(day);
    if (response.statusCode == 200) {
      _dayImageModel = DayImageModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getDayImages2(String day) async {
    Response response = await profileRepo.getDayImages(day);
    if (response.statusCode == 200) {
      _dayTwoImageModel = DayTwoImageModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getDayImages3(String day) async {
    Response response = await profileRepo.getDayImages(day);
    if (response.statusCode == 200) {
      _dayThreeImageModel = DayThreeImageModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getDayImages4(String day) async {
    Response response = await profileRepo.getDayImages(day);
    if (response.statusCode == 200) {
      _dayFourImageModel = DayFourImageModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getDayImages5(String day) async {
    Response response = await profileRepo.getDayImages(day);
    if (response.statusCode == 200) {
      _dayFiveImageModel = DayFiveImageModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> postEditedUserDetails({
    bool reload = false,
    bool isUpdate = false,
  }) async {
    loading(true);

    Response response = await profileRepo.postProfileDataApi(
      userId: _userModel!.id!,
      userEmail: editEmailNameController.text.trim(),
      userFName: editFirstNameController.text.trim(),
      userLName: editLastNameController.text.trim(),
    );
    if (response.statusCode == 200) {
      await profileData();
      MyStyles().showSnackBarGreen(messageText: Constants.accountUpdated);
    } else {
      ApiChecker.checkApi(response);
    }

    loading(false);
    update();
  }

  Future<void> postLikeImage(String imageId) async {
    loading(true);

    Response response = await profileRepo.likeImage(imageId: imageId);
    if (response.statusCode == 200) {
      await profileData();
      MyStyles().showSnackBarGreen(messageText: 'Liked Successfully');
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

  Future<void> uploadFile(List<int> fileBytes, String comment) async {
    const url = 'https://smb.inet.africa:8080/api/user/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Add file part
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        fileBytes,
        filename: 'image.jpg',
      ),
    );

    // Add comment part
    request.fields['comment'] = comment;

    final response = await request.send();
    if (response.statusCode == 200) {
      // Upload successful
      print('Image uploaded successfully!');
      MyStyles().showSnackBarGreen(messageText: 'Image uploaded successfully!');
    } else {
      // Upload failed
      print('Image upload failed. Status code: ${response.statusCode}');
    }
  }

  Future<void> postImagesAndComment() async {
    imageuploading(true);
    late http.StreamedResponse response;
    for (int i = 0; i < selectedImages.length; i++) {
      var file = selectedImages[i];
      String fieldName = 'fileUpload';
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://smb.inet.africa:8080/api/user/upload',
        ),
      );

      request.fields['user_id'] = userInfo!.id;

      request.fields['comment'] = commentController.text;

      request.files.add(
        await http.MultipartFile.fromPath(
          fieldName,
          file.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      response = await request.send();
    }

    if (response.statusCode == 200) {
      debugPrint('Images and comment posted successfully!');
      selectedImages.value = <File>[];
      commentController.clear();
      MyStyles().showSnackBarGreen(messageText: 'Image uploaded successfully!');
    } else {
      debugPrint(
          'Failed to post images and comment. Error: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();

      var parsedData = json.decode(responseBody);
      debugPrint('error message: ${parsedData}');
      MyStyles().showSnackBar(messageText: parsedData);
    }

    imageuploading(false);
  }

  // FOR WEB
  RxList<html.File> selectedImagesWeb = <html.File>[].obs;

  void pickImages() {
    html.InputElement uploadInput =
        html.document.createElement('input') as html.InputElement;
    uploadInput
      ..type = 'file'
      ..multiple = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null) {
        selectedImagesWeb.value = files;
      }
    });
  }

  newFileUpload() {
    imageuploading(true);
    //late html.HttpRequest request;
    for (int i = 0; i < selectedImagesWeb.length; i++) {
      final formData = html.FormData();

      formData.append('user_id', userInfo!.id);
      formData.append('comment',
          commentController.text.isEmpty ? '' : commentController.text);

      // Append each selected file to the FormData object

      final file = selectedImagesWeb[i];
      formData.appendBlob('fileUpload', file);

      // Send the FormData object to the server using an HTTP POST request
      html.HttpRequest.request(
        'https://smb.inet.africa:8080/api/user/upload', // Replace with your server URL
        method: 'POST',
        sendData: formData,
      ).then((request) {
        // Handle the response from the server
        if (request.status == 200) {
          // Upload successful

          selectedImagesWeb.value = <html.File>[];
          commentController.clear();
          debugPrint('Images uploaded successfully!');
          // MyStyles()
          //     .showSnackBarGreen(messageText: 'Image uploaded successfully!');
          profileData();
          imageuploading(false);
          Get.offNamed(RouteHelper.getLandingRoute());
        } else {
          // Upload failed

          debugPrint('error status code: ${request.status}');
          MyStyles().showSnackBar(messageText: 'Upload failed');
          debugPrint('Error uploading images.');
          imageuploading(false);
        }
      });
    }
    imageuploading(false);
  }

  void uploadImagesToServer() async {
    // Create an input element of type 'file'
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
      ..multiple = true;

    // Trigger the file picker dialog
    uploadInput.click();

    // Listen for file selection
    uploadInput.onChange.listen((event) {
      // Retrieve selected files
      final selectedImagesWeb = uploadInput.files;

      // Create a FormData object
      final formData = html.FormData();

      formData.append('user_id', userInfo!.id);
      
      formData.append('comment', commentController.text);

      // Append each selected file to the FormData object
      for (var i = 0; i < selectedImagesWeb!.length; i++) {
        final file = selectedImagesWeb[i];
        formData.appendBlob('fileUpload', file);
      }

      // Send the FormData object to the server using an HTTP POST request
      html.HttpRequest.request(
        'https://smb.inet.africa:8080/api/user/upload', // Replace with your server URL
        method: 'POST',
        sendData: formData,
      ).then((html.HttpRequest request) {
        // Handle the response from the server
        if (request.status == 200) {
          // Upload successful
          debugPrint('Images uploaded successfully!');
        } else {
          // Upload failed

          debugPrint('error status code: ${request.status}');
          MyStyles().showSnackBar(messageText: 'Upload failed');
          debugPrint('Error uploading images.');
        }
      });
    });
    await profileData();
    await Get.offNamed(RouteHelper.getLandingRoute());
  }
}
