import 'dart:convert';

import '../../utils/export_files.dart';

class Repository {
  final ApiClient apiClient;

  Repository(this.apiClient);
  Future<Map<String, dynamic>> fetchData() async {
    final response = await apiClient.fetchEventsData();
    if (response.statusCode == 200) {
      // Parse the response and return data
      final Map<String, dynamic> data = parseData(response.body);
      print('check here ***************************************************around here');
      return data;
    } else {
      print("Something is wrong");
      return {};
    }
  }

  Map<String, dynamic> parseData(String responseBody) {
      // Parse the JSON response body
  final parsedData = json.decode(responseBody);
    return  parsedData;
  }
}
