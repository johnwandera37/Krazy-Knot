// import 'dart:convert';

// import 'package:photomanager/controllers/profile_controller.dart';

import '../utils/export_files.dart';
// import 'package:photomanager/data/model/response/user_model.dart';

class EventController extends GetxController {
  final events = <Event>[].obs; //capture events data
  final attendees = <Attendees>[].obs; //capture attendees data
  final MapPickerController mapPickerController =
      Get.put(MapPickerController()); //for location
  final DateTimeController dateTimeController =
      Get.put(DateTimeController()); //for the dates
  final EventIdController eventIdController =
      Get.put(EventIdController()); //for the PUT request data

  String? ownerID; //to get owner ID

  // Capture values events inputs
  var eventTitle = TextEditingController();
  var eventDescription = TextEditingController();
  var selectType = TextEditingController();

  //capture vattendees details
  var attendeeNameStr = TextEditingController();
  var attendeePhoneNo = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchEvents(
        '65081b6f44dbbead5990e40a'); // Fetch data when the controller is initialized
  }

  //getEvents
  Future<void> fetchEvents(event_owner) async {
    final data = await ApiService().fetchEventsData(event_owner);
    debugPrint('$data');
    // Convert the JSON data into Event objects using the model
    final eventList = (data['events'] as List)
        .map((eventData) => Event.fromJson(eventData))
        .toList();
    events.value =
        eventList; // Update the 'events' observable list with the fetched data
  }

//create event process
  Future<void> createEvent(event_owner) async {
  final DateTime startTime = dateTimeController.selectedDateTime.value;
  final DateTime endTime = dateTimeController.selectedEndDateTime.value;
  debugPrint('================> my id is: $event_owner');
  final event = Event(
    id: "",
    eventOwner: event_owner,
    eventName: eventTitle.text,
    eventType: selectType.text,
    eventVenue: mapPickerController.address.value,
    eventDescription: eventDescription.text,
    eventStartDate: startTime.toString(),
    eventEndDate: endTime.toString(),
    eventStatus: 'Pending', //by default
  );

  try {
    await ApiService().addEvent(event);
    Get.delete<MapPickerController>();
    Get.delete<DateTimeController>();
    Get.delete<EventController>();
    Get.back();
    fetchEvents(event_owner);

    // Show success message as a snackbar
    Get.snackbar(
      'Success',
      'Event created successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  } catch (e) {
    debugPrint('$e');
    
    // Show error message as a snackbar
    Get.snackbar(
      'Error',
      '$e',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}


//edit event process
  Future<void> editEvent(event_owner) async {
    String eventId = eventIdController.eventId.value;

    final DateTime startTime = dateTimeController.selectedDateTime.value;
    final DateTime endTime = dateTimeController.selectedEndDateTime.value;

    debugPrint("/////////////////////////////////////////this is my event id");
    debugPrint(eventId);
    // Create an instance of the Event model to encapsulate the updated data
    final updatedEventData = PutEvent(
      eventId: eventId,
      eventName: eventTitle.text,
      eventOwner: event_owner,
      eventType: selectType.text,
      eventVenue: mapPickerController.address.value,
      eventDescription: eventDescription.text,
      eventStatus: "Pending", //default
      eventStartDate: startTime.toString(),
      eventEndDate: endTime.toString(),
    );

    try {
      // Convert the Event object to a map before sending it in the request body
      final requestBody = {
        "eventId": updatedEventData.eventId,
        "updatedEventData": updatedEventData.toMap(),
      };

      await ApiService().updateEvent(requestBody);
      Get.delete<MapPickerController>();
      Get.delete<DateTimeController>();
      Get.delete<EventController>();
      Get.back();
      fetchEvents(event_owner);
      debugPrint('Event updated successfully');
    } catch (e) {
      debugPrint('$e');
    }
  }

//update status alone process
  Future<void> updateStatus({
    required String eventId,
    required String eventStatus
  }) async {
    // Create an instance of the Event model to encapsulate the updated data
    var event_owner = '65081b6f44dbbead5990e40a';
    final updatedEventStatus = PutEventStatus(
      eventId: eventId,
      eventStatus: eventStatus,
    );

    try {
      // Convert the Event object to a map before sending it in the request body
      final requestBody = {
        "eventId": updatedEventStatus.eventId,
        "updatedEventStatus": updatedEventStatus.toMap(),
      };

      await ApiService().updateEventStatus(requestBody);
      fetchEvents(event_owner);
      debugPrint('Event status updated successfully');
    } catch (e) {
      debugPrint('Failed to update event status: $e');
    }
  }

  //getEvents
  Future<void> fetchMembers() async {
    final data = await ApiService().fetchAttendeesData();
    debugPrint(
        '=======================================================Attendees data');
    debugPrint('$data');
    // Convert the JSON data into Event objects using the model
    final attendeesList = (data['guest'] as List)
        .map((attendeestData) => Attendees.fromJson(attendeestData))
        .toList();
    attendees.value =
        attendeesList; // Update the 'attendees' observable list with the fetched data
  }

//add attendess to database process
  Future<void> addAttendeesData() async {
    //should come from form
    final attendee = Attendees(
      eventId: "0701643848", //should be come from the event
      attendeeName: attendeeNameStr.text, //attendeeNameStr.text
      attendeePhone: attendeePhoneNo.text, //wants as int //attendeePhoneNo.text
    );

    try {
      await ApiService().addPeople(attendee);
      fetchMembers();
    } catch (e) {
      debugPrint('Failed to add attendee code error: $e');
    }
  }
}















// {
//   "eventId": "651e7f3125aecdf0cb978d54",
//   "updatedEventData": {
//     "eventName": "Business matters second update testing",
//     "eventOwner":"65080d2a44dbbead5990e351",
//     "eventType": "Business",
//     "eventVenue":"The Mid Hole update",
//     "eventDescription": "Business network update",
//     "eventStatus": "pending",
//     "eventStartDate": "2023-10-29T06:00:00.000+00:00",
//      "eventEndDate": "2023-10-31T11:50:00.000+00:00"
   
//   }
// }


// final updatedEventData = Event(
//   id: "651e7f3125aecdf0cb978d54",
//   eventName: "Business matters actual test",
//   eventOwner: "65080d2a44dbbead5990e351",
//   eventType: "Business",
//   eventVenue: "The Mid Hole update",
//   eventDescription: "Business network update",
//   eventStatus: "pending",
//   eventStartDate: "2023-10-29T06:00:00.000+00:00",
//   eventEndDate: "2023-10-31T11:50:00.000+00:00",
// );


// //Update the event
// Future<void> editEvent() async {
// final eventId = "651e7f3125aecdf0cb978d54";

// final Map<String, dynamic> requestBody = {
//   "eventId": "651e7f3125aecdf0cb978d54",
//   "updatedEventData": {
//     "eventName": "Business matters second update testing 6",
//     "eventOwner": "65080d2a44dbbead5990e351",
//     "eventType": "Business",
//     "eventVenue": "The Mid Hole update",
//     "eventDescription": "Business network update",
//     "eventStatus": "pending",
//     "eventStartDate": "2023-10-29T06:00:00.000+00:00",
//     "eventEndDate": "2023-10-31T11:50:00.000+00:00"
//   }
// };

// //eventId,
// try {
//   // final updatedEventDataMap = requestBody;
//   await ApiService().updateEvent(requestBody);
//   debugPrint('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[Event updated successfully');
// } catch (e) {
//   debugPrint('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[Failed to update event: $e');
// }
// }




//  Future<Response> getOwnerId() async {
//     final response = await apiClient.getWithParamData(
//       Constants.baseUrl + Constants.userInfoUrl,
//       queryParams: {
//       Constants.userIdStr: "user_id",
//       },
//     );
//      if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       ownerID = data['user_id'] as String;
//       debugPrint({"==================================================>>>>>>>>>OWNERID"});
//       debugPrint(ownerID);
//       debugPrint({"==================================================>>>>>>>>>OWNERID"});
//     }
//     return response;
//   }