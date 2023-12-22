import 'package:intl/intl.dart';
import 'package:photomanager/utils/export_files.dart';


class MyUtils {
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  
    String formatTimestamp(DateTime timestamp) {
    final DateFormat formatter = DateFormat('dd MMM y, HH:mm a');
    return formatter.format(timestamp.toLocal());
  }

//   String formatTimeUntilEvent(DateTime startDate, DateTime endDate) {
//   DateTime now = DateTime.now();

//   if (endDate.isBefore(now)) {
//     // Event has already passed
//     return 'This event has passed';
//   } else if (startDate.isBefore(now) && endDate.isAfter(now)) {
//     // Event is happening right now
//     return 'Your event is happening right now';
//   }

//   Duration difference = startDate.difference(now);

//   if (difference.inDays > 0) {
//     // Future date more than a day away
//     int days = difference.inDays;
//     return '$days ${days == 1 ? 'day' : 'days'} until your event';
//   } else if (difference.inHours > 0) {
//     // Future date within the next 24 hours
//     int hours = difference.inHours;
//     return '$hours ${hours == 1 ? 'hour' : 'hours'} until your event';
//   } else if (difference.inMinutes > 0) {
//     // Future date within the next 60 minutes
//     int minutes = difference.inMinutes;
//     return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} until your event';
//   } else {
//     // Event is happening right now
//     return 'Your event is happening right now';
//   }
// }



List<dynamic> getTimeUntilEvent(DateTime startDate, DateTime endDate) {
  DateTime now = DateTime.now();

  if (endDate.isBefore(now)) {
    // Event has already passed
    return [0, 'This event has passed'];
  } else if (startDate.isBefore(now) && endDate.isAfter(now)) {
    // Event is happening right now
    return [0, 'Your event is happening right now'];
  }

  Duration difference = startDate.difference(now);

  if (difference.inDays > 0) {
    // Future date more than a day away
    int days = difference.inDays;
    return [days, 'days'];
  } else if (difference.inHours > 0) {
    // Future date within the next 24 hours
    int hours = difference.inHours;
    return [hours, 'hours'];
  } else if (difference.inMinutes > 0) {
    // Future date within the next 60 minutes
    int minutes = difference.inMinutes;
    return [minutes, 'minutes'];
  } else {
    // Event is happening right now
    return [0, 'Your event is happening right now'];
  }
}


RichText formatTextWithWeight(String text, double fontSize, TextWeight weight) {
  // Split the string into two parts
  List<String> parts = text.split(' ');
  // Assuming that the time difference part is always at the beginning
  String timeDifference = parts.takeWhile((part) => int.tryParse(part) != null).join(' ');
  String untilYourEvent = parts.skipWhile((part) => int.tryParse(part) != null).join(' ');
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight == TextWeight.bold ? FontWeight.bold : FontWeight.normal,
      ),
      children: [
        TextSpan(
          text: timeDifference,
        ),
        TextSpan(
          text: untilYourEvent,
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}




Widget formatTimeUntilEvent(DateTime startDate, DateTime endDate) {
  DateTime now = DateTime.now();

  if (endDate.isBefore(now)) {
    // Event has already passed
    return buildFormattedText(time: 'Alas!',message: 'This event has expired');
  } else if (startDate.isBefore(now) && endDate.isAfter(now)) {
    // Event is happening right now
    return buildFormattedText(message: 'Your event is happening right now');
  }

  Duration difference = startDate.difference(now);

  if (difference.inDays > 0) {
    // Future date more than a day away
    int days = difference.inDays;
    return buildFormattedText(time: '$days ${days == 1 ? 'day' : 'days'}', message: 'until your event');
  } else if (difference.inHours > 0) {
    // Future date within the next 24 hours
    int hours = difference.inHours;
    return buildFormattedText(time: '$hours ${hours == 1 ? 'hour' : 'hours'}', message: 'until your event');
  } else if (difference.inMinutes > 0) {
    // Future date within the next 60 minutes
    int minutes = difference.inMinutes;
    return buildFormattedText(time: '$minutes ${minutes == 1 ? 'minute' : 'minutes'}', message: 'until your event');
  } else {
    // Event is happening right now
    return buildFormattedText(message: 'Your event is happening right now');
  }
}

Widget buildFormattedText(
  {
    String? time, 
    String? message
  }
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(headingStr: time??'', weight: TextWeight.bold, fontSize: 30,),
      sizedHeight(5),
      CustomText(headingStr: message??'', fontSize: 15, weight: TextWeight.semiBold,)
    ],
  );
}




  String formatDateTime(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('MMM dd yyyy hh:mm a').format(parsedDate);
    return formattedDate;
  } catch (e) {
    // unexpected date format
    return 'Invalid Date $date';
  }
}

  static int sum(int a, int b) {
    return a + b;
  }

  String processPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("+2540") && phoneNumber.length > 13) {
      return phoneNumber.replaceFirst("+2540", "+254");
    } else if (phoneNumber.startsWith("0") && phoneNumber.length > 9) {
      return phoneNumber.substring(1);
    }
    return phoneNumber;
  }

  String isStrongPassword(String password) {
    // Check the length of the password
    if (password.length < 4) {
      return 'Password should be at least 4 characters long.';
    }

    // // Check for uppercase letters
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password should contain at least one uppercase letter.';
    // }

    // // Check for lowercase letters
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return 'Password should contain at least one lowercase letter.';
    // }

    // // Check for numbers
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return 'Password should contain at least one number.';
    // }

    // // Check for special characters
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password should contain at least one special character.';
    // }

    // The password is strong
    return '';
  }

}
