import '../../../utils/export_files.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get for Get.put

class FormValidator {
  final EventController eventController = Get.put(EventController());

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
