// import '../controllers/profile_controller.dart';
// import 'export_files.dart';

// class RefreshLogic {
//  var controller = Get.find<ProfileController>();
//   final EventController eventController = Get.find<EventController>();

//   Future<void> refreshData() async {
//     var user = await initUserId();
//     eventController.fetchEvents(user);
//   }

//   Future<String> initUserId() async {
//     var profileData = await controller.profileData();
//     debugPrint('NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
//     var user_id = controller.userInfo!.id;
//     return user_id;
//   }
// }

import '../controllers/profile_controller.dart';
import 'export_files.dart';

class RefreshLogic {
  var controller = Get.find<ProfileController>();
  final EventController eventController = Get.find<EventController>();

  Future<void> refreshData() async {
    try {
      var user = await initUserId();
      eventController.fetchEvents(user);
    } catch (error) {
      print('Error during refresh: $error');
      // Handle the error as needed
    }
  }

  Future<String> initUserId() async {
    try {
      var profileData = await controller.profileData();
      debugPrint('NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
      var user_id = controller.userInfo!.id;
      return user_id;
    } catch (error) {
      print('Error during initialization: $error');
      // Handle the error as needed
      throw error; // Rethrow the error to signal the failure
    }
  }
}
