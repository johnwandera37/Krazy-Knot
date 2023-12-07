import '../../../controllers/profile_controller.dart';
import '../../../utils/export_files.dart';

final ProfileRepo _profileRepo = ProfileRepo(apiClient: Get.find());
final ProfileController _profileController =
    ProfileController(profileRepo: _profileRepo);
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
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: const CustomText(
            headingStr: "CHANGE EVENT STATUS",
            weight: TextWeight.bold,
          ),
          content: CustomText(headingStr: dialogContent),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: CustomText(
                        headingStr:
                            "Ensure your venue is ready before updating."),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                final EventController eventController =
                    Get.put(EventController());
                final String new_status;
                var message;
                if (status.toLowerCase() == 'pending') {
                  new_status = 'Ready';
                  eventController.updateStatus(
                      eventId: eventId, eventStatus: new_status);
                  message = 'Status updated to ready';
                  debugPrint(
                      '######################################################################### nice this data for status was executed $new_status');
                } else if (status.toLowerCase() == 'ready') {
                  new_status = 'Pending';
                  eventController.updateStatus(
                      eventId: eventId, eventStatus: new_status);
                  message = 'Status updated to pending';
                  debugPrint(
                      '######################################################################### nice this data for status was executed $new_status');
                } else if (status.toLowerCase() == 'cancelled') {
                  new_status = 'Pending';
                  eventController.updateStatus(
                      eventId: eventId, eventStatus: new_status);

                  message = 'Event restored';
                  debugPrint(
                      '######################################################################### nice this data for status was executed $new_status');
  
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    behavior: SnackBarBehavior.floating,
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
          title: const CustomText(
            headingStr: "CANCEL EVENT",
            weight: TextWeight.bold,
          ),
          content: CustomText(headingStr: dialogContent),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: CustomText(headingStr: "No action taken."),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                final EventController eventController =
                    Get.put(EventController());
                final String new_status;
                if (status.toLowerCase() == 'pending' ||
                    status.toLowerCase() == 'ready') {
                  new_status = 'Cancelled';
                  eventController.updateStatus(
                      eventId: eventId,
                      eventStatus: new_status);
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
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
