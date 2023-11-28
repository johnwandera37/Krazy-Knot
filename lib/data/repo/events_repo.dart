// import 'dart:convert';

// import '../../utils/export_files.dart';

// class Repository {
//   final ApiClient apiClient;

//   Repository(this.apiClient);
//   Future<Map<String, dynamic>> fetchData() async {
//     final response = await apiClient.fetchEventsData();
//     if (response.statusCode == 200) {
//       // Parse the response and return data
//       final Map<String, dynamic> data = parseData(response.body);
//       print('check here ***************************************************around here');
//       return data;
//     } else {
//       print("Something is wrong");
//       return {};
//     }
//   }

//   Map<String, dynamic> parseData(String responseBody) {
//       // Parse the JSON response body
//   final parsedData = json.decode(responseBody);
//     return  parsedData;
//   }
// }

import 'dart:convert';
import '../../utils/export_files.dart';
import 'package:http/http.dart' as http;

class Repository {
  final ApiService apiService;

  Repository(this.apiService);

  // Future<bool> submitFormData(Map<String, dynamic> data) async {
  //   final response = await apiService.postData(data);

  //   if (response.statusCode == 200) {
  //     // Handle successful submission
  //     return true;
  //   } else {
  //     // Handle errors and return false
  //     return false;
  //   }
  // }

  // Future<Map<String, dynamic>> fetchData(event_owner) async {
    // final response = await apiService.fetchEventsData(event_owner);

    // if (response.statusCode == 200) {
    //   // Parse the response and return data
    //   debugPrint('============THIS WAS EXECUTED');
    //   final Map<String, dynamic> data = parseData(response.body);
    //   return data;
    // } else {
    //   // Handle errors, return an empty map, or throw an exception
    //     debugPrint('============THIS WAS EXECUTED BUT THERE IS AN ISSUE');
    //   return {};
    // }
    // return response;
  // }
  

  Map<String, dynamic> parseData(String responseBody) {
    //data parsing logic here
    return {};
  }
}

