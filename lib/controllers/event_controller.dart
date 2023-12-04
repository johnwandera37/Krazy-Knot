// import 'dart:convert';

// import 'package:photomanager/controllers/profile_controller.dart';

import 'package:photomanager/ui/home/landingScreen.dart';

import '../utils/export_files.dart';
// import 'package:photomanager/data/model/response/user_model.dart';

class EventController extends GetxController {
  final events = <Event>[].obs; //capture events data
    final cancelledEvents = <Event>[].obs; // capture cancelled events data
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

  //capture attendees details
  var attendeeNameStr = TextEditingController();
  var attendeePhoneNo = TextEditingController();
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initUserId();
  }

  initUserId() async {
    var controller = Get.find<ProfileController>();
    var profileData = await controller.profileData();
    debugPrint('NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
    userId.value = controller.userInfo!.id;
    fetchEvents(userId.value);
  }

  //getEvents
  Future<void> fetchEvents(event_owner) async {

    debugPrint('EVENT ID :::::  $event_owner');
    try {
      //adfasdf
      final data = await ApiService().fetchEventsData(event_owner);
      debugPrint('$data');
      // Convert the JSON data into Event objects using the model
      final eventList = (data['events'] as List)
          .map((eventData) => Event.fromJson(eventData))
          .toList();
      events.value =
          eventList; // Update the 'events' observable list with the fetched data
         // Filter out cancelled events and update the 'cancelledEvents' observable list
    cancelledEvents.value = events.where((event) => event.eventStatus.toLowerCase() == 'cancelled').toList();

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

//create event process
  Future<void> createEvent(event_owner) async {
    final DateTime startTime = dateTimeController.selectedDateTime.value;
    final DateTime endTime = dateTimeController.selectedEndDateTime.value;
    debugPrint('================> my id is: $event_owner');
    final event = Event(
      id: "",
      eventOwner: userId.value,
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
      fetchEvents(userId.value);

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
      eventOwner: userId.value,
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
      fetchEvents(userId.value);
      debugPrint('Event updated successfully');

     Get.snackbar(
        'Success',
        'Updated successfully',
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

//update status alone process
  Future<void> updateStatus(
      {required String eventId, required String eventStatus}) async {
    // Create an instance of the Event model to encapsulate the updated data
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
      fetchEvents(userId.value);
      debugPrint('Event status updated successfully');
       Get.snackbar(
        'Success',
        'Updated successfully',
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

  //getEvents
  Future<void> fetchMembers(event_id) async {
    try {
      final data = await ApiService().fetchAttendeesData(event_id);
      debugPrint(
          '=======================================================Attendees data');
      debugPrint('$data');
      // Convert the JSON data into Attendees objects using the model
      final attendeesList = (data['guests'] as List)
          .map((attendeestData) => Attendees.fromJson(attendeestData))
          .toList();
      attendees.value =
          attendeesList; // Update the 'attendees' observable list with the fetched data
    } catch (e) {
      debugPrint('Error fetching attendees: $e');
 
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

//add attendess to database process
  Future<void> addAttendeesData(event_id) async {
    //should come from form
    final attendee = Attendees(
      eventId: event_id,
      attendeeName: attendeeNameStr.text,
      attendeePhone: attendeePhoneNo.text,
    );

    try {
      debugPrint('event_id is =========================> $event_id');
      await ApiService().addPeople(attendee);
      // Show success message as a snackbar
      Get.snackbar(
        'Success',
        'Joined successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.delete<EventController>();
      // Get.back();
      Get.to(EventTab());
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
}