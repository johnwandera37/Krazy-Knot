import '../../../utils/export_files.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get for Get.put

class FormValidator {
  final EventController eventController = Get.put(EventController());
    final MapPickerController mapPickerController = Get.put(MapPickerController());

  bool validateFields({
    required BuildContext context,
    required String? selectedDropdownValue,
  }) {
    bool isValid = true;

    // Validate Event Title
    if (eventController.eventTitle.text.isEmpty) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an event title.'),
        ),
      );
    }

    // Validate Event Type
    if (selectedDropdownValue == null || selectedDropdownValue.isEmpty) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an event type.'),
        ),
      );
    }

    // Validate Event Venue
    if (mapPickerController.address.value.isEmpty) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select event location.'),
        ),
      );
    }


    // Validate Event Description
    if (eventController.eventDescription.text.isEmpty) {
      isValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an event description.'),
        ),
      );
    }

    return isValid;
  }
}
