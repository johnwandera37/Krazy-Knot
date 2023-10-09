import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../utils/export_files.dart';

class ApiClient extends GetxService {
  late String appBaseUrl = Constants.baseUrl;
  // late String? eventsBaseUrl = Constants.eventsUrl;//events base url
  late SharedPreferences sharedPreferences;
  final int timeoutInSeconds = 30;

  String token = '';
  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
    // this.eventsBaseUrl,
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
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
      }
      //get owner id
      String? userId = queryParams["user_id"];
      print("User ID john: $userId");
        //get owner id
      http.Response response = await http
          .get(
            Uri.parse(uri).replace(queryParameters: queryParams),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      if (kDebugMode) {
        print(
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
          print('====> GetX Base URL: $appBaseUrl');
          print('====> GetX Call: $uri');
          print(
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
          print(
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
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
        print('====> GetX Body: $body');
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
        print(
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
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
        print('====> GetX Body: $body');
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
        print(
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
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
        print('====> GetX Body: $body');
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
        print(
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
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
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
        print(
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

  postFormData(String s, {required FormData formData}) {
    //Logic goes here
  }
}
