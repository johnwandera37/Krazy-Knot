import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:photomanager/controllers/backup.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/export_files.dart';

class ApiService {
  final String eventsBaseUrl = Constants.eventsUrl;
  var event_owner = '65080d2a44dbbead5990e351';
//Fetch events
  Future<Map<String, dynamic>> fetchEventsData() async {
  final uri = "$eventsBaseUrl/getEvents/?eventOwner=$event_owner";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    debugPrint("======================================> this is my data");
    debugPrint('$data');
      debugPrint("====================================> this is my data");
    return data;
  } else {
    debugPrint('Event API Error: ${response.statusCode}');
    return {'error': 'API Error: ${response.statusCode}'};
  }
}


Future<void> addEvent(Event event) async {
  final response = await http.post(
    Uri.parse('$eventsBaseUrl/addEvent'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(event.toJson()), //a 'toJson' method exists in the Event model
  );
  if (response.statusCode == 200) {
    debugPrint('=====================>Event created successfully');
  } else {
    debugPrint('Failded to add an event');
    throw Exception('Create event error code: ${response.statusCode}');
  }
}


//update events
Future<void> updateEvent(Map<String, dynamic> updatedEventData) async {
  final response = await http.put(
    Uri.parse('$eventsBaseUrl/updateEvent'), // Include the eventId in the URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedEventData), // Pass the updated data as the request body
  );
  if (response.statusCode == 200) {
    debugPrint('[[[[[[[[[[[[[[[[[[[[[[[[[[[=======================Event updated successfully');
  } else {
    debugPrint('Failed to update an event from api itself[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[===============');
    throw Exception('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[==================Update event error code: ${response.statusCode}');
  }
}

//fetch attendee data
  Future<Map<String, dynamic>> fetchAttendeesData() async {
  final uri = "$eventsBaseUrl/getPeople?eventId=0701643848";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    debugPrint("======================================> this is my attendees' data");
    debugPrint('$data');
      debugPrint("====================================> this is my attendees' data");
    return data;
  } else {
    debugPrint('Attendees fetch API Error: ${response.statusCode}');
    return {'error': 'API Error: ${response.statusCode}'};
  }
}


//Adding people
Future<void> addPeople(Attendees attendee) async {
  final response = await http.post(
    Uri.parse('$eventsBaseUrl/addPeople'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(attendee.toJson()), //a 'toJson' method exists in the Event model
  );
  if (response.statusCode == 200) {
    debugPrint('======================================================>Atteendee created successfully');
  } else {
    debugPrint('Failded to add an attendee');
    throw Exception('Failed to add attendee error code: ${response.statusCode}');
  }
}

}