import 'dart:convert';

import 'package:photomanager/controllers/profile_controller.dart';

import '../utils/export_files.dart';
import 'package:photomanager/data/model/response/user_model.dart';

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
    events.value =
        eventList; // Update the 'events' observable list with the fetched data
        
    // Filter out cancelled events and update the 'cancelledEvents' observable list
    cancelledEvents.value = events.where((event) => event.eventStatus.toLowerCase() == 'cancelled').toList();
  }

//create event process
  Future<void> createEvent() async {
// Access the selectedDateTime
    final DateTime startTime = dateTimeController.selectedDateTime.value;
    final DateTime endTime = dateTimeController.selectedEndDateTime.value;

    var event_owner = '65080d2a44dbbead5990e351';

    final ProfileRepo _profileRepo = ProfileRepo(apiClient: Get.find());
    final ProfileController _profileController =
        ProfileController(profileRepo: _profileRepo);
    // var event_owner = _profileController.userInfo!.id;
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
      fetchEvents();
    } catch (e) {
      debugPrint('Failed to create event: $e');
    }
  }

//edit event process
  Future<void> editEvent() async {
    String eventId = eventIdController.eventId.value;

    final DateTime startTime = dateTimeController.selectedDateTime.value;
    final DateTime endTime = dateTimeController.selectedEndDateTime.value;
    var event_owner = '65080d2a44dbbead5990e351';

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
      eventStatus: "Pending",
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
      debugPrint('Event updated successfully');
    } catch (e) {
      debugPrint('Failed to update event: $e');
    }
  }

//update status alone process
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
    var event_owner = '65080d2a44dbbead5990e351';
    final updatedEventData = PutEvent(
      eventId: eventId,
      eventName: eventTitle,
      eventOwner: event_owner,
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
       fetchEvents();
    } catch (e) {
      debugPrint('Failed to add attendee code error: $e');
    }
  }
}