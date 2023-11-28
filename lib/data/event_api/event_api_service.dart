import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:photomanager/controllers/backup.dart';
// import '../../controllers/profile_controller.dart';
import '../../utils/export_files.dart';

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() { 
    return message;
  }
}

class ApiService {
  final String eventsBaseUrl = Constants.eventsUrl;

//get error message from backend
  String _extractErrorMessage(String responseBody) {
    try {
      Map<String, dynamic> jsonBody = json.decode(responseBody);
      if (jsonBody.containsKey('error')) {
        return jsonBody['error'];
      }
      return 'Unknown error occurred';
    } catch (e) {
      return 'Failed to parse error message';
    }
  }

//Fetch events
  Future<Map<String, dynamic>> fetchEventsData(event_owner) async {
    final uri = "${eventsBaseUrl}getEvents?eventOwner=$event_owner";
    final response = await http.get(Uri.parse(uri));
    debugPrint("======================================> GET EVENT URL ${uri}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint("======================================> this is my data");
      debugPrint('$data');
      debugPrint("====================================> this is my data");
      return data;
    } else {
      debugPrint('Event API Error: ${response.statusCode}');
      // Extract error message from response body
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to fetch events due to: $errorMessage');
      // return {'error': 'API Error: ${response.statusCode}'};
    }
  }

  Future<void> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse('${eventsBaseUrl}addEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          event.toJson()), //a 'toJson' method exists in the Event model
    );
    if (response.statusCode == 200) {
      debugPrint('=====================>Event created successfully');
    } else {
      debugPrint('Failed to add an event');
      // Extract error message from response body
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to add event due to: $errorMessage');
    }
  }

//update events
  Future<void> updateEvent(Map<String, dynamic> updatedEventData) async {
    final response = await http.put(
      Uri.parse(
          '${eventsBaseUrl}updateEvent'), // Include the eventId in the URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          updatedEventData), // Pass the updated data as the request body
    );
    if (response.statusCode == 200) {
      debugPrint('=======================>Event updated successfully');
      debugPrint('$updatedEventData');
    } else {
      debugPrint('Failed to update an event from api itself===============');
      // Extract error message from response body
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to update event due to: $errorMessage');
      // throw Exception('==================>Update event error code: ${response.body}');
    }
  }

//update event status
  Future<void> updateEventStatus(
      Map<String, dynamic> updatedEventStatus) async {
    final response = await http.put(
      Uri.parse(
          '${eventsBaseUrl}updateEventStatus'), // Include the eventId in the URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          updatedEventStatus), // Pass the updated data as the request body
    );
    if (response.statusCode == 200) {
      debugPrint('=======================>Event updated successfully');
      debugPrint('$updatedEventStatus');
    } else {
      debugPrint('Failed to update an event from api itself===============');
      // Extract error message from response body
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to update event due to: $errorMessage');
      // throw Exception('==================>Update event error code: ${response.body}');
    }
  }

//fetch attendee data
  Future<Map<String, dynamic>> fetchAttendeesData(event_id) async {
    final uri = "${eventsBaseUrl}getPeople?eventId=$event_id";
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(
          "======================================> this is my attendees' data");
      debugPrint('$data');
      debugPrint(
          "====================================> this is my attendees' data");
      return data;
    } else {
      debugPrint('Attendees fetch API Error: ${response.statusCode}');
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to fetch guests due to: $errorMessage');
    }
  }

//Adding people
  Future<void> addPeople(Attendees attendee) async {
    final response = await http.post(
      Uri.parse('${eventsBaseUrl}addPeople'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          attendee.toJson()), //a 'toJson' method exists in the Event model
    );
    if (response.statusCode == 200) {
      debugPrint(
          '======================================================>Atteendee added successfully');
    } else {
      debugPrint('Failded to add the guest');
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to add guest due to: $errorMessage');
    }
  }
}
