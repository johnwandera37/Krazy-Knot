import 'package:flutter_test/flutter_test.dart';
import '../../lib/utils/export_files.dart';
//test cases for the fromJson and toJson

void main() {
  group('Event Model Tests', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        '_id': '12345',
        'eventName': 'Test Event',
        'eventType': 'Test Type',
        'eventVenue': 'Test Venue',
        'eventDescription': 'Test Description',
        'eventStatus': 'pending',
        'eventDate': '2023-10-29T06:15:42.484Z',
      };

      final event = Event.fromJson(json);

      // Assert that the properties of the Event object match the JSON data
      expect(event.id, '12345');
      expect(event.eventName, 'Test Event');
      expect(event.eventType, 'Test Type');
      // Add similar assertions for other properties
    });

    test('toJson should convert to JSON correctly', () {
      final event = Event(
        id: '12345',
        eventOwner: 'ttey622882822tss',
        eventName: 'Test Event',
        eventType: 'Test Type',
        eventVenue: 'Test Venue',
        eventDescription: 'Test Description',
        eventStatus: 'pending',
        eventStartDate: ('2023-10-29T06:15:42.484Z'),//DateTime.parse
        eventEndDate: ('2023-10-29T06:15:42.484Z'),//DateTime.parse
      );

      final json = event.toJson();

      // Assert that the JSON map matches the Event object's properties
      expect(json['_id'], '12345');
      expect(json['eventName'], 'Test Event');
      expect(json['eventType'], 'Test Type');
      // Add similar assertions for other properties
    });
  });
}

