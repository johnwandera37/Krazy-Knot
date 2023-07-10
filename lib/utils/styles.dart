

import 'export_files.dart';

class MyStyles {
  showSnackBar({
    String? titleStr,
    required String messageText,
  }) {
    Get.snackbar(
      margin: const EdgeInsets.all(16),
      titleStr ?? Constants.alertStr,
      "",
      colorText: Colors.white,
      backgroundColor: Colors.black,
      icon: const Icon(
        Icons.add_alert,
        color: Colors.white,
      ),
      titleText: Text(
        titleStr ?? Constants.alertStr,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        messageText,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  showSnackBarGreen({
    String? titleStr,
    required String messageText,
  }) {
    Get.snackbar(
      margin: const EdgeInsets.all(16),
      titleStr ?? Constants.alertStr,
      "",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      titleText: Text(
        titleStr ?? Constants.alertStr,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        messageText,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

}
