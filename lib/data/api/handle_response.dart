import 'dart:convert';

import '../../utils/export_files.dart';
import 'package:http/http.dart' as http;

class HandleResponse {
  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      // Handle decoding error if needed
      debugPrint('Error decoding response body: $e');
    }

    Response response0 = Response(
      // Update the code based on the appropriate Response class
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200) {
      if (response0.bodyString!.startsWith('{"error": ')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.error,
        );
        // Show User Error Msg
        MyStyles().showSnackBar(messageText: errorResponse.error);
      } else if (response0.bodyString!.startsWith('{message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body['message'],
        );
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(
        statusCode: 0,
        statusText: Constants.noInternetMessage,
      );
    }

    debugPrint(
      '====> API Response: [${response0.statusCode}] $uri\n${response0.body}',
    );

    return response0;
  }
}