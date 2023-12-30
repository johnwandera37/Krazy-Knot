import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../utils/export_files.dart';
// import 'package:dio/dio.dart' hide Response, FormData;

class ApiClient extends GetxService {
  late String appBaseUrl = Constants.baseUrl;
  late SharedPreferences sharedPreferences;
  final int timeoutInSeconds = 30;
  // Dio dio = Dio();

  String token = '';
  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    debugPrint(
        " token.............................................${getUserToken()}");

    _mainHeaders = {
      Constants.contentType: Constants.applicationChar,
      Constants.authorization: '${Constants.bearer} ${getUserToken()}',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      Constants.contentType: Constants.applicationChar,
      Constants.authorization: '${Constants.bearer} $token'
    };
  }

  Future<Response> getData(
    String? uri, {
    required Map<String, dynamic>? query,
    required Map<String, String>? headers,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl + uri!),
            headers: _mainHeaders,
          )
          .timeout(
            Duration(
              seconds: timeoutInSeconds,
            ),
          );
      return HandleResponse().handleResponse(
        response,
        uri,
      );
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  Future<Response> getWithParamData(
    String uri, {
    required Map<String, String> queryParams,
  }) async {
    try {
      debugPrint(
          '====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
      if (kDebugMode) {
        debugPrint('====> GetX Base URL: $appBaseUrl');
        debugPrint('====> GetX Call: $uri');
      }
      http.Response response = await http
          .get(
            Uri.parse(uri).replace(queryParameters: queryParams),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      if (kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return HandleResponse().handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  Future<Response> postWithParamsData(
    String uri, {
    required Map<String, String> queryParams,
  }) async {
    try {
      try {
        debugPrint(
            '====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
        if (kDebugMode) {
          debugPrint('====> GetX Base URL: $appBaseUrl');
          debugPrint('====> GetX Call: $uri');
          debugPrint(
              "====> GetX Full Url: ${Uri.parse(uri).replace(queryParameters: queryParams)}");
        }

        http.Response response0 = await http
            .post(
              Uri.parse(uri).replace(queryParameters: queryParams),
              headers: _mainHeaders,
            )
            .timeout(Duration(seconds: timeoutInSeconds));

        debugPrint("++++++++++++>>>=====");
        Response response = HandleResponse().handleResponse(
          response0,
          uri,
        );

        if (kDebugMode) {
          debugPrint(
              '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        }
        return response;
      } on TimeoutException {
        throw TimeoutException('The operation timed out');
      }
    } catch (e) {
      debugPrint("++++++++++++>>>===== ERROR ${e.toString()}");

      MyStyles().showSnackBar(messageText: e.toString());
      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        debugPrint('====> GetX Base URL: $appBaseUrl');
        debugPrint('====> GetX Call: $uri');
        debugPrint('====> GetX Body: $body');
      }
      http.Response response0 = await http
          .post(
            Uri.parse(uri),
            body: jsonEncode(body),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      debugPrint("++++++++++++>>>=====");
      Response response = HandleResponse().handleResponse(
        response0,
        uri,
      );

      if (kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      MyStyles().showSnackBar(messageText: e.toString());

      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  Future<Response> postWithParamsAndBody(
    String uri,
    dynamic body,
    Map<String, String> queryParams,
  ) async {
    try {
      if (kDebugMode) {
        debugPrint('====> GetX Base URL: $appBaseUrl');
        debugPrint('====> GetX Call: $uri');
        debugPrint('====> GetX Body: $body');
      }
      http.Response response0 = await http
          .post(
            Uri.parse(uri).replace(queryParameters: queryParams),
            body: jsonEncode(body),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      debugPrint("++++++++++++>>>=====");
      Response response = HandleResponse().handleResponse(
        response0,
        uri,
      );

      if (kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      MyStyles().showSnackBar(messageText: e.toString());

      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        debugPrint('====> GetX Base URL: $appBaseUrl');
        debugPrint('====> GetX Call: $uri');
        debugPrint('====> GetX Body: $body');
      }
      http.Response response0 = await http
          .put(
            Uri.parse(uri),
            body: jsonEncode(body),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      debugPrint("++++++++++++>>>=====");
      Response response = HandleResponse().handleResponse(
        response0,
        uri,
      );
      if (kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      MyStyles().showSnackBar(messageText: e.toString());

      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(Constants.token) ?? '';
  }

  Future<Response> postDarajaData(String uri,
      {Map<String, String>? headers}) async {
    String authHeader = base64.encode(
        utf8.encode('bgsJVZYnKkLEBAd8YoJYOFEX1cikTAex:LK9Avmlm7vSH33Y9'));
    try {
      if (kDebugMode) {
        debugPrint('====> GetX Base URL: $appBaseUrl');
        debugPrint('====> GetX Call: $uri');
      }
      http.Response response0 = await http.post(Uri.parse(uri), headers: {
        'Authorization': 'Basic $authHeader',
      }).timeout(Duration(seconds: timeoutInSeconds));
      debugPrint("++++++++++++>>>=====");
      Response response = HandleResponse().handleResponse(
        response0,
        uri,
      );

      if (kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      MyStyles().showSnackBar(messageText: e.toString());

      return const Response(
        statusCode: 1,
        statusText: Constants.noInternetMessage,
      );
    }
  }


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

    Future<Map<String, dynamic>> geteventLink(eventId) async {
    final uri = '${Constants.baseUrl}event/getLink?eventID=$eventId';
    final response = await http.get(Uri.parse(uri));
    debugPrint("======================================> 🔗🔗🔗 GET EVENT URL ${uri}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('${data}');
      return data;
    } else {
      debugPrint('Event API Error: ${response.statusCode}');
      // Extract error message from response body
      String errorMessage = _extractErrorMessage(response.body);
      throw CustomException('Failed to fetch events due to: $errorMessage');
      // return {'error': 'API Error: ${response.statusCode}'};
    }
  }


  // Future<Response> postFormData(String apiUrl,
  //     {required FormData formData}) async {
  //   try {
  //     debugPrint('========================> Post started');
  //     // Send POST request using Dio
  //     var response = (await dio.post(apiUrl, data: formData));

  //     debugPrint('========================> $response');

  //     // Return the response from the server
  //     return response as Response;
  //   } catch (error) {
  //     debugPrint('Error during POST request: $error');
  //     throw Exception('Failed to send POST request');
  //   }
  // }
}
