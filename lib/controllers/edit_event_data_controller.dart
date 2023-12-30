import '../utils/export_files.dart';

class EventIdController extends GetxController {
  RxString eventId = ''.obs;
  var numberOfAttendees = 0.obs;

  void setEventId(String newEventId) {
    eventId.value = newEventId;
  }

   void updateTotalUsers(int value) {
    numberOfAttendees.value = value;
  }

}