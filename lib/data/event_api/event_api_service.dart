import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../utils/export_files.dart';

class ApiService {
  final String eventsBaseUrl = Constants.eventsUrl;

  // Future<http.Response> fetchEventsData() async {
  //   try {
  //     final response = await http.get(Uri.parse('http://localhost:8080/api/getEvents'));

  //     if (response.statusCode == 200) {
  //       // HTTP 200 OK
  //        final data = jsonDecode(response.body);
  //        print(data);
  //       return response;
  //     } else {
  //       debugPrint('HTTP Error: ${response.statusCode}');
  //       return http.Response('Error', response.statusCode);
  //     }
  //   } catch (e) {
  //     debugPrint('Error Fetching Event Data: $e');
  //     throw e;
  //   }
  // }

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
    print("=================================>created event");
    // print('=====================>Event created successfully');
  
    // print("=================================>created event");
  } else {
    print('Failded to add an event');
    throw Exception('Create event error code: ${response.statusCode}');
  }
}

//String eventId
//update events
// $eventId
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


}