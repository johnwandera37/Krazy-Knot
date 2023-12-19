import '../../lib/utils/export_files.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart'; // Import Mockito for mocking HTTP requests

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiService = ApiService();
      // apiService.httpClient = mockHttpClient;
       apiService = ApiService(httpClient: mockHttpClient);
      
    });


//     test('fetchEventsData should return data on success', () async {
//   // Arrange
//   final mockEventData = {'eventId': '123', 'eventName': 'Sample Event'};
//   when(mockHttpClient.get(any))
//       .thenAnswer((_) async => http.Response(jsonEncode(mockEventData), 200));

//   // Act
//   final result = await apiService.fetchEventsData('event_owner');

//   // Assert
//   expect(result, equals(mockEventData));
// });


//     test('fetchEventsData should return data on success', () async {
//   // Arrange
//   final mockEventData = {'eventId': '123', 'eventName': 'Sample Event'};
//   when(mockHttpClient.get(any))
//       .thenAnswer((Invocation realInvocation) async {
//         Uri uri = realInvocation.positionalArguments[0];
//         // You can add more conditions based on your needs, or ignore it
//         // For example, you might want to check if the path contains 'getEvents'
//         if (uri.path.contains('getEvents')) {
//           return http.Response(jsonEncode(mockEventData), 200);
//         } else {
//           return http.Response('Not Found', 404);
//         }
//       });

//   // Act
//   final result = await apiService.fetchEventsData('event_owner');

//   // Assert
//   expect(result, equals(mockEventData));
// });



    // test('fetchEventsData should return data on success', () async {
    //   // Arrange
    //   final mockEventData = {'eventId': '123', 'eventName': 'Sample Event'};
    //   when(mockHttpClient.get(Uri.parse(any)))
    //       .thenAnswer((_) async => http.Response(jsonEncode(mockEventData), 200));

    //   // Act
    //   final result = await apiService.fetchEventsData('event_owner');

    //   // Assert
    //   expect(result, equals(mockEventData));
    // });

    // test('fetchEventsData should throw CustomException on failure', () async {
    //   // Arrange
    //   when(mockHttpClient.get(Uri.parse(any)))
    //       .thenAnswer((_) async => http.Response('{"error": "Sample error"}', 400));

    //   // Act
    //   Future<void> fetchEventsData() async {
    //     await apiService.fetchEventsData('event_owner');
    //   }

    //   // Assert
    //   expect(fetchEventsData, throwsA(TypeMatcher<CustomException>()));
    // });

    // Add more tests for other methods in ApiService as needed
  });
}