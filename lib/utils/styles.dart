

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

//shadow box decorations
     inputDecoration() =>
        BoxDecoration(
        color:  HexColor("FBFBFB"),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200, // Shadow color
            // spreadRadius: 2,
            blurRadius: 10, // Spread of the shadow
            offset: Offset(10, 10), // Offset of the shadow
          ),
        ],
      );