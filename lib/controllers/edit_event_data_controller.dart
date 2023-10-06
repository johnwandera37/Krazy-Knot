import '../utils/export_files.dart';

class EventIdController extends GetxController {
  RxString eventId = ''.obs;

  void setEventId(String newEventId) {
    eventId.value = newEventId;
  }
}