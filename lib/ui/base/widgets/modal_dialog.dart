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
  String dialogContent = status.toLowerCase() == 'ready'
      ? "You are about to update event to pending!"
      : (status.toLowerCase() == 'pending'
          ? "Is the event venue booked?"
          : "You are about to restore this event");

  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: CustomText(
            headingStr: "CONFIRM EVENT STATUS",
            weight: TextWeight.bold,
          ),
          content: CustomText(headingStr: dialogContent),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomText(
                        headingStr:
                            "Ensure your venue is ready before updating."),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                final EventController eventController =
                    Get.put(EventController());
                final String new_status;
                if (status.toLowerCase() == 'pending') {
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
                  debugPrint(
                      '######################################################################### nice this data for status was executed ${new_status}');
                } else if (status.toLowerCase() == 'ready') {
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
                  debugPrint(
                      '######################################################################### nice this data for status was executed ${new_status}');
                } else if (status.toLowerCase() == 'cancelled') {
                  new_status = 'Pending';
                  DateTime currentDate = DateTime.now();
                  DateTime tomorrow = currentDate.add(Duration(days: 1));

                  eventController.updateStatus(
                      eventId: eventId,
                      eventTitle: title,
                      eventType: type,
                      eventVenue: venue,
                      eventDescription: description,
                      eventStatus: new_status,
                      eventStartDate: tomorrow.toIso8601String(),
                      eventEndDate: tomorrow.toIso8601String());
                  debugPrint(
                      '######################################################################### nice this data for status was executed ${new_status}');
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Event status restored and set for tomorrow.'),
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
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: CustomText(
            headingStr: "CANCEL EVENT",
            weight: TextWeight.bold,
          ),
          content: CustomText(headingStr: dialogContent),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
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
                final EventController eventController =
                    Get.put(EventController());
                final String new_status;
                if (status.toLowerCase() == 'pending' ||
                    status.toLowerCase() == 'ready') {
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
