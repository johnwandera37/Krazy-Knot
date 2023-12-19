import 'package:flutter_test/flutter_test.dart';
import '../../lib/utils/export_files.dart';
//test cases for the fromJson and toJson

void main() {
  //Event model
  group('Event Model Tests', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        '_id': '12345',
        'eventName': 'Test Event Example',
        'eventType': 'Wedding',
        'eventVenue': 'Malindi',
        'eventDescription': 'My description goes here',
        'eventStatus': 'Pending',
        'eventStartDate': '2023-10-29T06:15:42.484Z',
        'eventEndDate': '2023-10-30T06:15:42.484Z',
      };

      final event = Event.fromJson(json);

      // Assert that the properties of the Event object match the JSON data
      expect(event.id, '12345');
      expect(event.eventName, 'Test Event Example');
      expect(event.eventVenue, 'Malindi');
      expect(event.eventType, 'Wedding');
      expect(event.eventDescription, 'My description goes here');
      expect(event.eventStatus, 'Pending');
      expect(event.eventStartDate, '2023-10-29T06:15:42.484Z');
      expect(event.eventEndDate, '2023-10-30T06:15:42.484Z');
    });

    test('toJson should convert to JSON correctly', () {
      final event = Event(
        id: '12345',
        eventOwner: 'ttey622882822tss',
        eventName: 'Test Event',
        eventType: 'Test Type',
        eventVenue: 'Test Venue',
        eventDescription: 'Test Description',
        eventStatus: 'Pending',
        eventStartDate: ('2023-10-29T06:15:42.484Z'),//DateTime.parse was specified as a string
        eventEndDate: ('2023-10-29T06:15:42.484Z'),//DateTime.parse was specified as a string
      );

      final json = event.toJson();

      // Assert that the JSON map matches the Event object's properties
      expect(json['_id'], '12345');
      expect(json['eventName'], 'Test Event');
      expect(json['eventType'], 'Test Type');
      expect(json['eventOwner'], 'ttey622882822tss');
      expect(json['eventVenue'], 'Test Venue');
      expect(json['eventType'], 'Test Type');
      expect(json['eventStatus'], 'Pending');
      expect(json['eventStartDate'], '2023-10-29T06:15:42.484Z');
      expect(json['eventEndDate'], '2023-10-29T06:15:42.484Z');
      
    });
  });


  //Attendees model
  test('fromJson should create an Attendees instance from JSON', () {
      // Arrange
      Map<String, dynamic> json = {
        'eventId': '123',
        'attendeeName': 'John Doe',
        'attendeePhone': '0701643848',
      };

      // Act
      Attendees attendees = Attendees.fromJson(json);

      // Assert
      expect(attendees.eventId, equals('123'));
      expect(attendees.attendeeName, equals('John Doe'));
      expect(attendees.attendeePhone, equals('0701643848'));
    });

    test('toJson should convert Attendees instance to JSON', () {
      // Arrange
      Attendees attendees = const Attendees(
        eventId: '123',
        attendeeName: 'John Doe',
        attendeePhone: '0701643848',
      );

      // Act
      Map<String, dynamic> json = attendees.toJson();

      // Assert
      expect(json['eventId'], equals('123'));
      expect(json['attendeeName'], equals('John Doe'));
      expect(json['attendeePhone'], equals('0701643848'));
    });

    test('props should return a list of properties', () {
      // Arrange
      Attendees attendees = const Attendees(
        eventId: '123',
        attendeeName: 'John Doe',
        attendeePhone: '0701643848',
      );

      // Act
      List<Object?> props = attendees.props;

      // Assert
      expect(props.length, equals(3));
      expect(props[0], equals('123'));
      expect(props[1], equals('John Doe'));
      expect(props[2], equals('0701643848'));
    });


    //Put event model
     test('toMap should convert PutEvent instance to a map', () {
      // Arrange
      PutEvent putEvent = PutEvent(
        eventId: '123',
        eventName: 'Sample Event',
        eventOwner: 'John Doe',
        eventType: 'Conference',
        eventVenue: 'Conference Center',
        eventDescription: 'This is a sample event.',
        eventStatus: 'Active',
        eventStartDate: '2023-01-01',
        eventEndDate: '2023-01-03',
      );

      // Act
      Map<String, dynamic> map = putEvent.toMap();

      // Assert
      expect(map['eventId'], equals('123'));
      expect(map['eventName'], equals('Sample Event'));
      expect(map['eventOwner'], equals('John Doe'));
      expect(map['eventType'], equals('Conference'));
      expect(map['eventVenue'], equals('Conference Center'));
      expect(map['eventDescription'], equals('This is a sample event.'));
      expect(map['eventStatus'], equals('Active'));
      expect(map['eventStartDate'], equals('2023-01-01'));
      expect(map['eventEndDate'], equals('2023-01-03'));
    });

    test('toMap should convert PutEventStatus instance to a map', () {
      // Arrange
      PutEventStatus putEventStatus = PutEventStatus(
        eventId: '123',
        eventStatus: 'Inactive',
      );

      // Act
      Map<String, dynamic> map = putEventStatus.toMap();

      // Assert
      expect(map['eventId'], equals('123'));
      expect(map['eventStatus'], equals('Inactive'));
    });


}

