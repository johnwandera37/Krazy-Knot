import 'dart:convert';

import '../utils/export_files.dart';
import 'package:photomanager/data/model/response/user_model.dart';

class EventController extends GetxController {
  final events = <Event>[].obs;
   final MapPickerController mapPickerController = Get.put(MapPickerController());//for location
   final DateTimeController dateTimeController = Get.put(DateTimeController()); //for the dates
   final EventIdController eventIdController = Get.put(EventIdController()); //for the PUT request data

  //  late final ApiClient apiClient;
   
   String? ownerID;
 
   // Capture values from input fields
      var eventTitle = TextEditingController();
      var eventDescription = TextEditingController();
      var selectType = TextEditingController();


   @override
  void onInit() {
    super.onInit();
    fetchEvents(); // Fetch data when the controller is initialized
    // getOwnerId();
  }


  //getEvents
  Future<void> fetchEvents() async {
    final data = await ApiService().fetchEventsData();
    print(data);
    // Convert the JSON data into Event objects using the model
    final eventList = (data['events'] as List)
        .map((eventData) => Event.fromJson(eventData))
        .toList();
    events.value = eventList;// Update the 'events' observable list with the fetched data
  }

//create event process
Future<void> createEvent() async {
// Access the selectedDateTime
final DateTime startTime = dateTimeController.selectedDateTime.value;
final DateTime endTime = dateTimeController.selectedEndDateTime.value;

    final event = Event(
      id: "",
      eventOwner: "65080d2a44dbbead5990e351",
      eventName: eventTitle.text,
      eventType:  selectType.text,
      eventVenue: mapPickerController.address.value, 
      eventDescription: eventDescription.text,
      eventStartDate: startTime.toString(),
      eventEndDate: endTime.toString(),
      eventStatus: 'Pending',//by default
    );

    try {
      await ApiService().addEvent(event);
      fetchEvents();
    } catch (e) {
      print('Failed to create event: $e');
    }
}


Future<void> editEvent() async {
  // final eventId = "651e7f3125aecdf0cb978d54";
   String eventId = eventIdController.eventId.value;

  final DateTime startTime = dateTimeController.selectedDateTime.value;
  final DateTime endTime = dateTimeController.selectedEndDateTime.value;
  print("/////////////////////////////////////////this is my event id");
  print(eventId);
  // Create an instance of the Event model to encapsulate the updated data
  final updatedEventData = PutEvent (
    eventId: eventId,
    eventName: eventTitle.text,
    eventOwner: "65080d2a44dbbead5990e351",
    eventType: selectType.text,
    eventVenue: mapPickerController.address.value,
    eventDescription: eventDescription.text,
    eventStatus: "pending",
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
     fetchEvents();
    print('Event updated successfully');
  } catch (e) {
    print('Failed to update event: $e');
  }
}


//update status
Future<void> updateStatus({
  required String eventId,
  required String eventTitle,
  required String eventType,
  required String eventVenue,
  required String eventDescription,
  required String eventStatus,
  required String eventStartDate,
  required String eventEndDate,
}) async {
  
  // Create an instance of the Event model to encapsulate the updated data
  final updatedEventData = PutEvent(
    eventId: eventId,
    eventName: eventTitle,
    eventOwner: "65080d2a44dbbead5990e351",
    eventType: eventType,
    eventVenue: eventVenue,
    eventDescription: eventDescription,
    eventStatus: eventStatus,
    eventStartDate: eventStartDate,
    eventEndDate: eventEndDate,
  );

  try {
    // Convert the Event object to a map before sending it in the request body
    final requestBody = {
      "eventId": updatedEventData.eventId,
      "updatedEventData": updatedEventData.toMap(),
    };

    await ApiService().updateEvent(requestBody);
    fetchEvents();
    print('Event updated successfully');
  } catch (e) {
    print('Failed to update event: $e');
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
//   print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[Event updated successfully');
// } catch (e) {
//   print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[Failed to update event: $e');
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
//       print({"==================================================>>>>>>>>>OWNERID"});
//       print(ownerID);
//       print({"==================================================>>>>>>>>>OWNERID"});
//     }
//     return response;
//   }