import 'package:intl/intl.dart';
import 'package:photomanager/utils/export_files.dart';
import 'package:photomanager/utils/images.dart';


class MyUtils {
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

    Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "Pending": 
        return Colors.grey;
      case "cancelled":
        return Colors.red;
      case "ready":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('dd MMM y, HH:mm a', 'en_US');
  return formatter.format(dateTime);
}
  
    String formatTimestamp(DateTime timestamp) {
    final DateFormat formatter = DateFormat('dd MMM y, HH:mm a');
    return formatter.format(timestamp.toLocal());
  }

Widget formatTimeUntilEvent(DateTime startDate, DateTime endDate, Function? onTapCallback,) {
  DateTime now = DateTime.now();

  if (endDate.isBefore(now)) {
    // Event has already passed
    return buildFormattedText(time: 'Alas!',message: 'This event has expired', onTap: onTapCallback);
  } else if (startDate.isBefore(now) && endDate.isAfter(now)) {
    // Event is happening right now
    return buildFormattedText(time: 'Fantastic!', message: 'The event is in full swing!', onTap: onTapCallback);
  }

  Duration difference = startDate.difference(now);

  if (difference.inDays > 0) {
    // Future date more than a day away
    int days = difference.inDays;
    return buildFormattedText(time: '$days ${days == 1 ? 'day' : 'days'}', message: 'until your event', onTap: onTapCallback);
  } else if (difference.inHours > 0) {
    // Future date within the next 24 hours
    int hours = difference.inHours;
    return buildFormattedText(time: '$hours ${hours == 1 ? 'hour' : 'hours'}', message: 'until your event', onTap: onTapCallback);
  } else if (difference.inMinutes > 0) {
    // Future date within the next 60 minutes
    int minutes = difference.inMinutes;
    return buildFormattedText(time: '$minutes ${minutes == 1 ? 'minute' : 'minutes'}', message: 'until your event', onTap: onTapCallback);
  } else {
    // Event is happening right now
    return buildFormattedText(time: 'Fantastic!',message: 'The event is in full swing!', onTap: onTapCallback);
  }
}

Widget buildFormattedText(
  {
    String? time, 
    String? message,
    Function? onTap
  }
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(headingStr: time??'', weight: TextWeight.bold, fontSize: 30, onTap: onTap,),
      sizedHeight(5),
      CustomText(headingStr: message??'', fontSize: 15, weight: TextWeight.semiBold, onTap: onTap,)
    ],
  );
}

Color getColorForEventType(String eventType) {
  switch (eventType.toLowerCase()) {
    case 'technology':
      return HexColor('A6F6FF');
    case 'education':
      return HexColor('85E6C5');
    case 'wedding':
      return HexColor('F6D6D6');
    case 'business':
      return HexColor('FF8989');
    case 'food':
      return HexColor('FBF0B2');
    case 'entertainment':
      return HexColor('FE7BE5');
    case 'sports':
      return HexColor('DDF2FD');
    default:
      return HexColor('E1AEFF');
  }
}


//Update text whn the event detail screen is opened
Widget helperTextFunction(
  {
  required String status,
  required DateTime startDate,
  required DateTime endDate,
  }
){
  if(startDate.isBefore(DateTime.now()) && endDate.isAfter(DateTime.now())){
    return helperText(text: 'This event is happening right now!', status: status);
  }
  else if(endDate.isBefore(DateTime.now()) && status.toLowerCase() != 'cancelled'){
    return helperText(text: 'This event has passed, you can recreate this event by editing the event values!', status: status);
  }
  else if(status.toLowerCase() == 'cancelled'){
    return  helperText(text: 'This event has been cancelled, you can revive it and change the event values', status: status);
  }
  else{
    return helperText(text: 'Ensure your event status is set to ready and scheduled to a future date', status: status);
  }
}
Widget helperText({
required String text,
required String status
})=>  
Padding(
padding: EdgeInsets.symmetric(horizontal: 20),
child: CustomText(headingStr: text, align: TextAlignOption.center, fontSize: 16, fontColor: MyUtils().getStatusColor(status),),
);



  Map<String, String> eventTypeImages = {
      'Food': Images.party,
      'Education': Images.educ,
      'Technology': Images.tech,
      'Sports': Images.spot,
      'Business': Images.busin,
      'Wedding': Images.wed,
      'Entertainment': Images.entertainment,
    };
  

  //show info if neither switch nor revive button
  void handleinfo(String eventStatus, BuildContext context){
      showCustomDialog(
    context: context,
    title: "Event in progress",
    content: "This event has already started, if you wish to change the status of this event you have to cancel the event",
    actions: [
     Center(
       child: TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
     ),
    ],
  );
  }


   // hanlde status update;
  //  void handleSwitchChanged(String currentStatus, String eventid) async {
  //   var statuscheck =currentStatus.toLowerCase();
  //   String newStatus = statuscheck == 'ready' ? 'Pending' : 'Ready';

  //   debugPrint('Switch toggled✂️✂️: $newStatus');
  //   try{
  //     await eventcontroller.editEventStatus(eventStatus: newStatus, eventid: eventid);
  //   }catch(e){
  //     debugPrint('😟😟😟 handleSwitchChange on status error: $e');
  //   }
  // }


//   String formatDateTime(String date) {
//   try {
//     final parsedDate = DateTime.parse(date);
//     final formattedDate = DateFormat('MMM dd yyyy hh:mm a').format(parsedDate);
//     return formattedDate;
//   } catch (e) {
//     // unexpected date format
//     return 'Invalid Date $date';
//   }
// }

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
