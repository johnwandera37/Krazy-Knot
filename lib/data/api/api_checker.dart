

import '../../utils/export_files.dart';

class ApiChecker {
  static void checkApi(Response response) {
    switch (response.statusCode) {
      case 500:
        {
          MyStyles().showSnackBar(messageText: response.body[Constants.errorStr]);
        }
        break;
      case 401:
        {
          MyStyles().showSnackBar(messageText: response.body[Constants.errorStr]);
          // statements;
        }
        break;

      case 400:
        {
          MyStyles().showSnackBar(messageText: response.body[Constants.errorStr]);
          //statements;
        }
        break;

      default:
        {
          MyStyles().showSnackBar(messageText: response.body[Constants.errorStr]);
        }
        break;
    }
  }
}
