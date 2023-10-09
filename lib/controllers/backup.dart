// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// export 'package:photomanager/data/model/response/user_model.dart';
// import 'package:http_parser/http_parser.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:photomanager/data/model/response/day_five_image_model.dart';
// import 'package:photomanager/data/model/response/day_four_image_model.dart';
// import 'package:photomanager/data/model/response/day_three_image_model.dart';
// import 'package:photomanager/data/model/response/day_two_image_model.dart';
// import 'package:photomanager/data/model/response/single_image_model.dart';
// import 'package:photomanager/data/model/response/user_model.dart';
// import '../utils/export_files.dart';
// import 'package:http/http.dart' as http;
// import 'dart:html' as html;

// class ProfileController extends GetxController implements GetxService {
//   final ProfileRepo profileRepo;
//   ProfileController({
//     required this.profileRepo,
//   });

//   UserModel? _userModel;
//   UserModel? get userInfo => _userModel;

//   DayImageModel? _dayImageModel;
//   DayImageModel? get dayImageModel => _dayImageModel;

//   DayTwoImageModel? _dayTwoImageModel;
//   DayTwoImageModel? get dayTwoImageModel => _dayTwoImageModel;

//   DayThreeImageModel? _dayThreeImageModel;
//   DayThreeImageModel? get dayThreeImageModel => _dayThreeImageModel;

//   DayFourImageModel? _dayFourImageModel;
//   DayFourImageModel? get dayFourImageModel => _dayFourImageModel;

//   DayFiveImageModel? _dayFiveImageModel;
//   DayFiveImageModel? get dayFiveImageModel => _dayFiveImageModel;

//   RxBool loading = false.obs;

//   RxBool imageuploading = false.obs;

//   RxList<File> selectedImages = <File>[].obs;

//   var commentController = TextEditingController();

//   final url = 'https://smb.inet.africa:8080/api/user/upload';

//   // void pickImages() async {
//   //   List<XFile>? imageFiles = await ImagePicker().pickMultiImage();
//   //   if (imageFiles != null) {
//   //     selectedImages.value =
//   //         imageFiles.map((imageFile) => File(imageFile.path)).toList();
//   //   }
//   // }

//   // EDIT-TEXT-CONTROLLER
//   var editFirstNameController = TextEditingController();
//   var editLastNameController = TextEditingController();
//   var editEmailNameController = TextEditingController();

//   fillEditControllers() {
//     editFirstNameController.text = userInfo!.firstName!;
//     editLastNameController.text = userInfo!.lastName!;
//     editEmailNameController.text = userInfo!.email!;
//   }

//   Future<void> profileData() async {
//     var userPhone = Get.find<AuthController>().getCustomerId();
//     Response response = await profileRepo.getProfileDataApi(userPhone);
//     if (response.statusCode == 200) {
//       _userModel = UserModel.fromJson(response.body);
//       debugPrint('USER INFO +++++++++++++++++++++>');
//       Get.find<AuthController>()
//           .setCustomerName('${_userModel!.firstName} ${_userModel!.lastName}');
//     } else {
//       debugPrint('TAKE ME TO OOPS SCREEN+++++++++++++++++++++>');
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> getDayImages(String day) async {
//     Response response = await profileRepo.getDayImages(day);
//     if (response.statusCode == 200) {
//       _dayImageModel = DayImageModel.fromJson(response.body);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> getDayImages2(String day) async {
//     Response response = await profileRepo.getDayImages(day);
//     if (response.statusCode == 200) {
//       _dayTwoImageModel = DayTwoImageModel.fromJson(response.body);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> getDayImages3(String day) async {
//     Response response = await profileRepo.getDayImages(day);
//     if (response.statusCode == 200) {
//       _dayThreeImageModel = DayThreeImageModel.fromJson(response.body);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> getDayImages4(String day) async {
//     Response response = await profileRepo.getDayImages(day);
//     if (response.statusCode == 200) {
//       _dayFourImageModel = DayFourImageModel.fromJson(response.body);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> getDayImages5(String day) async {
//     Response response = await profileRepo.getDayImages(day);
//     if (response.statusCode == 200) {
//       _dayFiveImageModel = DayFiveImageModel.fromJson(response.body);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     update();
//   }

//   Future<void> postEditedUserDetails({
//     bool reload = false,
//     bool isUpdate = false,
//   }) async {
//     loading(true);

//     Response response = await profileRepo.postProfileDataApi(
//       userId: _userModel!.id!,
//       userEmail: editEmailNameController.text.trim(),
//       userFName: editFirstNameController.text.trim(),
//       userLName: editLastNameController.text.trim(),
//     );
//     if (response.statusCode == 200) {
//       await profileData();
//       MyStyles().showSnackBarGreen(messageText: Constants.accountUpdated);
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     loading(false);
//     update();
//   }

//   Future<void> postLikeImage(String imageId) async {
//     loading(true);

//     Response response = await profileRepo.likeImage(imageId: imageId);
//     if (response.statusCode == 200) {
//       await profileData();
//       MyStyles().showSnackBarGreen(messageText: 'Liked Successfully');
//     } else {
//       ApiChecker.checkApi(response);
//     }

//     loading(false);
//     update();
//   }

//   void clearProfileData() {
//     _userModel = null;
//     Get.find<AuthController>().loading(false);
//     update();
//   }

//   Future<void> uploadFile(List<int> fileBytes, String comment) async {
//     final request = http.MultipartRequest('POST', Uri.parse(url));

//     // Add file part
//     request.files.add(
//       http.MultipartFile.fromBytes(
//         'image',
//         fileBytes,
//         filename: 'image.jpg',
//       ),
//     );

//     // Add comment part
//     request.fields['comment'] = comment;

//     final response = await request.send();
//     if (response.statusCode == 200) {
//       // Upload successful
//       print('Image uploaded successfully!');
//       MyStyles().showSnackBarGreen(messageText: 'Image uploaded successfully!');
//     } else {
//       // Upload failed
//       print('Image upload failed. Status code: ${response.statusCode}');
//     }
//   }

//   Future<void> postImagesAndComment() async {
//     imageuploading(true);
//     late http.StreamedResponse response;
//     for (int i = 0; i < selectedImages.length; i++) {
//       var file = selectedImages[i];
//       String fieldName = 'fileUpload';
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           url,
//         ),
//       );

//       request.fields['user_id'] = userInfo!.id;

//       request.fields['comment'] = commentController.text;

//       request.files.add(
//         await http.MultipartFile.fromPath(
//           fieldName,
//           file.path,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );

//       response = await request.send();
//     }

//     if (response.statusCode == 200) {
//       debugPrint('Images and comment posted successfully!');
//       selectedImages.value = <File>[];
//       commentController.clear();
//       MyStyles().showSnackBarGreen(messageText: 'Image uploaded successfully!');
//     } else {
//       debugPrint(
//           'Failed to post images and comment. Error: ${response.statusCode}');
//       var responseBody = await response.stream.bytesToString();

//       var parsedData = json.decode(responseBody);
//       debugPrint('error message: ${parsedData}');
//       MyStyles().showSnackBar(messageText: parsedData);
//     }

//     imageuploading(false);
//   }

//   // FOR WEB
//   RxList<html.File> selectedImagesWeb = <html.File>[].obs;

//   void pickImages() {
//     html.InputElement uploadInput =
//         html.document.createElement('input') as html.InputElement;
//     uploadInput
//       ..type = 'file'
//       ..multiple = true;
//     uploadInput.click();

//     uploadInput.onChange.listen((e) {
//       final files = uploadInput.files;
//       if (files != null) {
//         selectedImagesWeb.value = files;
//       }
//     });
//   }

//   newFileUpload() {
//     imageuploading(true);
//     //late html.HttpRequest request;
//     for (int i = 0; i < selectedImagesWeb.length; i++) {
//       final formData = html.FormData();

//       formData.append('user_id', userInfo!.id);
//       formData.append('comment',
//           commentController.text.isEmpty ? '' : commentController.text);

//       // Append each selected file to the FormData object

//       final file = selectedImagesWeb[i];
//       formData.appendBlob('fileUpload', file);

//       // Send the FormData object to the server using an HTTP POST request
//       html.HttpRequest.request(
//         url, // Replace with your server URL
//         method: 'POST',
//         sendData: formData,
//       ).then((request) {
//         // Handle the response from the server
//         if (request.status == 200) {
//           // Upload successful

//           selectedImagesWeb.value = <html.File>[];
//           commentController.clear();
//           debugPrint('Images uploaded successfully!');
//           // MyStyles()
//           //     .showSnackBarGreen(messageText: 'Image uploaded successfully!');
//           profileData();
//           imageuploading(false);
//           Get.offNamed(RouteHelper.getLandingRoute());
//         } else {
//           // Upload failed

//           debugPrint('error status code: ${request.status}');
//           MyStyles().showSnackBar(messageText: 'Upload failed');
//           debugPrint('Error uploading images.');
//           imageuploading(false);
//         }
//       });
//     }
//     imageuploading(false);
//   }

//   void uploadImagesToServer() async {
//     // Create an input element of type 'file'
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
//       ..multiple = true;

//     // Trigger the file picker dialog
//     uploadInput.click();

//     // Listen for file selection
//     uploadInput.onChange.listen((event) {
//       // Retrieve selected files
//       final selectedImagesWeb = uploadInput.files;

//       // Create a FormData object
//       final formData = html.FormData();

//       formData.append('user_id', userInfo!.id);

//       formData.append('comment', commentController.text);

//       // Append each selected file to the FormData object
//       for (var i = 0; i < selectedImagesWeb!.length; i++) {
//         final file = selectedImagesWeb[i];
//         formData.appendBlob('fileUpload', file);
//       }

//       // Send the FormData object to the server using an HTTP POST request
//       html.HttpRequest.request(
//         url, // Replace with your server URL
//         method: 'POST',
//         sendData: formData,
//       ).then((html.HttpRequest request) {
//         // Handle the response from the server
//         if (request.status == 200) {
//           // Upload successful
//           debugPrint('Images uploaded successfully!');
//         } else {
//           // Upload failed

//           debugPrint('error status code: ${request.status}');
//           MyStyles().showSnackBar(messageText: 'Upload failed');
//           debugPrint('Error uploading images.');
//         }
//       });
//     });
//     await profileData();
//     await Get.offNamed(RouteHelper.getLandingRoute());
//   }
// }



// import 'package:photomanager/ui/base/widgets/custom_image.dart';
// import 'package:photomanager/utils/images.dart';

// import '../../../utils/export_files.dart';
// import 'package:intl/intl.dart';


// class EventTab extends StatelessWidget {

  
//   EventTab({super.key});
//     final EventController eventController = Get.put(EventController());
//     final now = DateTime.now();

//   @override
//   Widget build(BuildContext context) {

// //using a function to filter events
// List<Event> filterFeaturedEvents(List<Event> allEvents) {
//   final now = DateTime.now();
//   final startOfWeek = DateTime(now.year, now.month, now.day);
//   final endOfWeek = startOfWeek.add(Duration(days: 7));
//   // Filter the events that fall within the upcoming week
//   final featuredEvents = allEvents.where((event) {
//     final eventDate = DateTime.parse(event.eventStartDate); // Parse the event date
//     return eventDate.isAfter(startOfWeek) && eventDate.isBefore(endOfWeek);
//   }).toList();
//   return featuredEvents;
// }

//     return 
//     Obx(() =>
//     Scaffold(
//       backgroundColor: HexColor("F7F7F7"),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: 
//         SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:  [
//             //title my events
//             const Center(child: CustomText(headingStr: "My Events", fontSize: 16, weight: TextWeight.bold,)),
//             sizedHeight(10),

//             //featured events section
//             const CustomText(headingStr: 'Featured Events', fontSize: 16, weight: TextWeight.semiBold,),
//             sizedHeight(20),
//             filterFeaturedEvents(eventController.events).isEmpty
//               ?  Center(child:Container(
//                 width: 100,
//                 height: 190,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                     CustomText(headingStr: "Your featured events will appear here", fontSize: 15),
//                     sizedHeight(20),
//                     Image.asset(
//                       Images.featured,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.fill,
//                       )
//                   ],)
                 
//                   ))
//               :Container(
//                 height: 200,
//                child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: filterFeaturedEvents(eventController.events).length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final event = filterFeaturedEvents(eventController.events)[index];
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: eventTile(eventType: event.eventType,
//                     eventTitle: event.eventName,
//                     eventDate: '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
//                     eventId: event.id.toString(), 
//                     eventDescription: event.eventDescription),
                    
//                   );
//                 },
//                 ),
//              ),
//             sizedHeight(30),
//             //events section
//             Row(children: const [
//                CustomText(headingStr: 'Events', fontSize: 16, weight: TextWeight.semiBold,),
//               ],),
//             sizedHeight(20),

//             //all events come here
//            Container(
//   child: eventController.events.isEmpty
//       ? Center(
//         child: Container(
//                   height: 200,
//                     child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomText(headingStr: "You don't have any events created", fontSize: 15),
//                         sizedHeight(20),
//                          Image.asset(Images.empty,
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.fill,
//                          )
//                       ],
//                     )
//                     ),
//       )
//       : Wrap(
//           spacing: 24.0,
//           runSpacing: 24.0,
//           children: eventController.events.map((event) {
//             return  Container(
//               // width: Get.width * 0.195, // Set the desired width for each eventTile
//               child: eventTile(
//                 eventType: event.eventType,
//                 eventTitle: event.eventName,
//                 eventDate:'${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
//                 eventId: event.id.toString(), 
//                 eventDescription: event.eventDescription,//get each event id
//               ),
//             );
//           }).toList(),
//         ),
// )

//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           Get.to(CreateEvent());
//         },
//         child:const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     )
//     );
//   }
// }

// //event tile
// Widget eventTile({
//     required eventType,
//     required eventTitle,
//     required eventDate,
//     VoidCallback? onTap,
//     // required VoidCallback onEdit, // Add the onEdit callback
//     required String eventId,
//     required String eventDescription
  
//    }){
//     //map that maps event types to image paths
//     final Map<String, String> eventTypeToImage = {
//     'Technology': Images.technology,
//     'Education': Images.education,
//     'Business': Images.business,
//     'Food': Images.food,
//     'Wedding': Images.wedding,
//     'Sports': Images.sports,
//   };
//   final String imagePath = eventTypeToImage[eventType] ?? Images.event;//string that determine path based on event type
//    return
//     InkWell(
//     onTap: onTap,
//     child:
//    Container(
//     width: Get.width * .3,//.195,
//     height: Get.width * .15,//1
//     decoration: inputDecoration(),
//     child: Padding(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
//       child: 
//       Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Row(children: [
//           Row(children: [
//           CustomImage(image: imagePath, imageWidth: 24, imageHeight: 24),
//           sizedWidth(8),
//           CustomText(headingStr: eventType, fontSize: 16, weight: TextWeight.semiBold,)
//           ],),
//           const Spacer(),
//           Container(child: PopUpMenu(eventId: eventId.toString()))//onEdit: () => onEdit(),
//         ],),
//         //event title
//         Container(
//           height: 43,
//           child: CustomText(headingStr: eventTitle, fontSize: 15,)),

//           //event descsiption
//           Container(
//              height: 50,
//             child:  CustomText(headingStr: eventDescription, fontSize: 15,)
//           ,),
//         //date
//         Align(
//           heightFactor: 2,
//            alignment: Alignment.bottomLeft, 
//           child: CustomText(headingStr: eventDate, fontColor: HexColor("151515"), fontSize: 11,))
//       ]),
//       ),

// )
//     );
//    }

// //PopUPMenu
// Widget PopUpMenu({
//   // required VoidCallback onEdit, // Add the onEdit callback
//   required String eventId, // Add eventId parameter
// })=> PopupMenuButton<String>(
//       iconSize: 17,
//       splashRadius: 16,  
//       onSelected: (String choice) {
//         // Handle the choice selected from the menu
//         if (choice == 'Edit') {
//           // onEdit(eventId); 
//           Get.to(EditEvent(eventId: eventId));
          
//         } else if (choice == 'Update Status') {
          
//         }
//         else if (choice == 'Cancel Event') {
          
//         }
//       },
//       itemBuilder: (BuildContext context) {
//         return [
//           const PopupMenuItem<String>(
//             value: 'Edit',
//             child: Text('Edit'),
//           ),
//           const PopupMenuItem<String>(
//             value: 'Update Status',
//             child: Text('Update Status'),
//           ),
//             const PopupMenuItem<String>(
//             value: 'Cancel',
//             child: Text('Cancel'),
//           ),
//         ];
//       },
//     );

// String formatDateTime(String date) {
//   try {
//     final parsedDate = DateTime.parse(date);
//     final formattedDate = DateFormat('MMM dd yyyy HH:mm').format(parsedDate);
//     return formattedDate;
//   } catch (e) {
//     //unexpected date format
//     return 'Invalid Date ${date}';
//   }
// }