import '../../../utils/export_files.dart';

bool _validateFields({
  required BuildContext context,
    required String? selectedDropdownValue,
}) {
bool isValid = true;
 final EventController eventController = Get.put(EventController()); 
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
if (selectedDropdownValue == null || selectedDropdownValue!.isEmpty) {
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

