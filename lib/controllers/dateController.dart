import '../utils/export_files.dart';
class DateTimeController extends GetxController {
  var selectedDateTime = DateTime.now().obs;
  var selectedEndDateTime = DateTime.now().obs;

  void updateSelectedDateTimeStart(DateTime newDateTime) {
    selectedDateTime.value = newDateTime;
  }
  void updateSelectedDateTimeEnd(DateTime newDateTime) {
    selectedEndDateTime.value = newDateTime;
  }
}
