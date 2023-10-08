import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/export_files.dart';

class ApiService {
  final String eventsBaseUrl = Constants.eventsUrl;
//Fetch events
  Future<Map<String, dynamic>> fetchEventsData() async {
  const uri = "http://localhost:8080/api/getEvents/?eventOwner=65080d2a44dbbead5990e351";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("======================================> this is my data");
    print(data);
      print("====================================> this is my data");
    return data;
  } else {
    print('Event API Error: ${response.statusCode}');
    return {'error': 'API Error: ${response.statusCode}'};
  }
}

//Add events
Future<void> addEvent(Event event) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/addEvent'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(event.toJson()), //a 'toJson' method exists in the Event model
  );
  if (response.statusCode == 200) {
    print('=====================>Event created successfully');
  } else {
    print('Failded to add an event');
    throw Exception('Create event error code: ${response.statusCode}');
  }
}


//update events
Future<void> updateEvent(Map<String, dynamic> updatedEventData) async {
  final response = await http.put(
    Uri.parse('http://localhost:8080/api/updateEvent'), // Include the eventId in the URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedEventData), // Pass the updated data as the request body
  );
  if (response.statusCode == 200) {
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[=======================Event updated successfully');
  } else {
    print('Failed to update an event from api itself[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[===============');
    throw Exception('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[==================Update event error code: ${response.statusCode}');
  }
}

//fetch attendee data
  Future<Map<String, dynamic>> fetchAttendeesData() async {
  const uri = "http://localhost:8080/api/getPeople?eventId=0701643848";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("======================================> this is my attendees' data");
    print(data);
      print("====================================> this is my attendees' data");
    return data;
  } else {
    print('Attendees fetch API Error: ${response.statusCode}');
    return {'error': 'API Error: ${response.statusCode}'};
  }
}


//Adding people
Future<void> addPeople(Attendees attendee) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/addPeople'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(attendee.toJson()), //a 'toJson' method exists in the Event model
  );
  if (response.statusCode == 200) {
    print('======================================================>Atteendee created successfully');
  } else {
    print('Failded to add an attendee');
    throw Exception('Failed to add attendee error code: ${response.statusCode}');
  }
}

}