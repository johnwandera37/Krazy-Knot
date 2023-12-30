import '../../../utils/export_files.dart';

class FormValidator {
  final EventsController eventcontroller = Get.find<EventsController>();
  final MapPickerController mapPickerController = Get.put(MapPickerController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());

  bool validateFields({
    required BuildContext context,
    required String? selectedDropdownValue,
  }) {
    bool isValid = true;
    DateTime currentTime = DateTime.now();
    final DateTime startTime = dateTimeController.selectedDateTime.value;
    final DateTime endTime = dateTimeController.selectedEndDateTime.value;
    //All empty
    if(eventcontroller.title.text.isEmpty && (selectedDropdownValue == null || selectedDropdownValue.isEmpty) && mapPickerController.address.value.isEmpty && eventcontroller.description.text.isEmpty){
       isValid = false;
     MyStyles().showSnackBar(messageText: 'Please fill all the event details.\nSelect the type\nConfirm location\nEnter your event description');
    }
    // Validate Event Title
    else if (eventcontroller.title.text.isEmpty) {
      isValid = false;
      MyStyles().showSnackBar(messageText: 'Please enter event title');
    }
    // Validate Event Type
    else if (selectedDropdownValue == null || selectedDropdownValue.isEmpty) {
      isValid = false;
      MyStyles().showSnackBar(messageText: 'Please select an event type');
    }

    // Validate Event Venue
    else if (mapPickerController.address.value.isEmpty) {
      isValid = false;
      MyStyles().showSnackBar(messageText: 'Please select event location');
    }
        // Validate Date and Time
    else if(startTime.isBefore(currentTime)){
       isValid = false;
      MyStyles().showSnackBar(messageText: 'Select a future date');
    }    
    else if (startTime.isAfter(endTime)) {
      isValid = false;
      MyStyles().showSnackBar(messageText: 'End date cannot be before the start date');
    }

    // Validate Event Description
    else if (eventcontroller.description.text.isEmpty) {
      isValid = false;
    MyStyles().showSnackBar(messageText: 'Please enter an event description');
    }

    return isValid;
  }


}
