import '../../../utils/export_files.dart';

  void openAnimatedDialog({
  required BuildContext context,
  required String eventId,
  required String status,
  required String title,
  required String owner,
  required String type,
  required String venue,
  required String description,
  required String startDate,
  required String endDate,
}) {
String dialogContent = status == 'Ready'
    ? "You are about to update event to pending!"
    : (status == 'Pending'
        ? "Is the event venue booked?"
        : "You are about to revert this event");

  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, child) =>
        ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child:
          FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
            title: CustomText(headingStr: "CONFIRM EVENT STATUS", weight: TextWeight.bold,),
            content: CustomText(headingStr: dialogContent),
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              actions: [
                TextButton(    
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomText(headingStr: "Ensure your venue is ready before updating."),
                    ),
                  );
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    final EventController eventController = Get.put(EventController());
                    final String new_status;
                    if(status == 'Pending' || status == 'Cancelled'){
                      new_status = 'Ready';
                        eventController.updateStatus(
                        eventId: eventId,
                        eventTitle: title, 
                        eventType: type, 
                        eventVenue: venue, 
                        eventDescription: description, 
                        eventStatus: new_status, 
                        eventStartDate: startDate, 
                        eventEndDate: endDate);
                        debugPrint('######################################################################### nice this data for status was executed ${new_status}');
                    }else if(status == 'Ready'){
                      new_status = 'Pending';
                        eventController.updateStatus(
                        eventId: eventId,
                        eventTitle: title, 
                        eventType: type, 
                        eventVenue: venue, 
                        eventDescription: description, 
                        eventStatus: new_status, 
                        eventStartDate: startDate, 
                        eventEndDate: endDate);
                        print('######################################################################### nice this data for status was executed ${new_status}');
                    }
                    Navigator.of(context).pop();
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Event status updated successfully.'),
                    ),
                  );

                  },
                ),
              ],
            ),
          ),
        ),
  );
}

//Cancel event
void cancelEvent({
  required BuildContext context,
  required String eventId,
  required String status,
  required String title,
  required String owner,
  required String type,
  required String venue,
  required String description,
  required String startDate,
  required String endDate,
}) {
   String dialogContent = 'You are about to cancel this event';

  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, child) =>
        ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child:
          FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
            title: CustomText(headingStr: "CANCEL EVENT", weight: TextWeight.bold,),
            content: CustomText(headingStr: dialogContent),
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              actions: [
                TextButton(    
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomText(headingStr: "No action taken."),
                    ),
                  );
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    final EventController eventController = Get.put(EventController());
                    final String new_status;
                    if(status == 'Pending' || status == 'Ready'){
                        new_status = 'Cancelled';
                        eventController.updateStatus(
                        eventId: eventId,
                        eventTitle: title, 
                        eventType: type, 
                        eventVenue: venue, 
                        eventDescription: description, 
                        eventStatus: new_status, 
                        eventStartDate: startDate, 
                        eventEndDate: endDate);
                    }
                    Navigator.of(context).pop();
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Event has been cancelled.'),
                    ),
                  );
                  
                  },
                ),
              ],
            ),
          ),
        ),
  );
}

