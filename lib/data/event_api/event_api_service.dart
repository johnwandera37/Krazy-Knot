import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:photomanager/controllers/backup.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/export_files.dart';

class ApiService {
  final String eventsBaseUrl = Constants.eventsUrl;

  // Future<http.Response> fetchEventsData() async {
  //   try {
  //     final response = await http.get(Uri.parse('$eventsBaseUrl/getEvents'));

  //     if (response.statusCode == 200) {
  //       // HTTP 200 OK
  //        final data = jsonDecode(response.body);
  //        debugPrint(data);
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
    final ProfileRepo _profileRepo = ProfileRepo(apiClient: Get.find());
    final ProfileController _profileController =
        ProfileController(profileRepo: _profileRepo);
    // var event_owner = _profileController.userInfo!.id;
    var event_owner ='65081b6f44dbbead5990e40a';
    debugPrint('================> my id is: $event_owner');
    final uri = "$eventsBaseUrl/getEvents?eventOwner=$event_owner";
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
      body: jsonEncode(
          event.toJson()), //a 'toJson' method exists in the Event model
    );
    if (response.statusCode == 200) {
      debugPrint('=====================>Event created successfully');
      debugPrint("=================================>created event");
      // debugPrint('=====================>Event created successfully');

      // debugPrint("=================================>created event");
    } else {
      debugPrint('Failded to add an event');
      throw Exception('Create event error code: ${response.statusCode}');
    }
  }

//String eventId
//update events
// $eventId
  Future<void> updateEvent(Map<String, dynamic> updatedEventData) async {
    final response = await http.put(
      Uri.parse('$eventsBaseUrl/updateEvent'), // Include the eventId in the URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          updatedEventData), // Pass the updated data as the request body
    );
    if (response.statusCode == 200) {
      debugPrint(
          '[[[[[[[[[[[[[[[[[[[[[[[[[[[=======================Event updated successfully');
    } else {
      debugPrint(
          'Failed to update an event from api itself[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[===============');
      throw Exception(
          '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[==================Update event error code: ${response.statusCode}');
    }
  }
}
