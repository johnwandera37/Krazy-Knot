import '../../../utils/export_files.dart';

//  void openAnimatedDialog(BuildContext context){
//     showGeneralDialog(
//     context: context,
//     pageBuilder: (context, animation1, animation2){
//       return Container();
//     },
//     transitionDuration: const Duration(milliseconds: 400),
//     transitionBuilder: (context, a1, a2, child) => 
//     ScaleTransition(
//       scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
//       child: 
//       FadeTransition(
//         opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
//         child: AlertDialog(
//           title: Text('Confirm status update'),
//           content: Text('Is the event venue booked?'),
//           shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
//           actions: [
//                 TextButton(
//                 child: Text('No'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Ensure your venue is ready before updating.'),
//                     ),
//                   );
//                 },
//               ),
//               TextButton(
//                 child: Text('Yes'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Event status updated successfully.'),
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }


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
  // required String content,
  // required VoidCallback onNoPressed,
  // required VoidCallback onYesPressed,
}) {
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
            title: Text('Confirm status update'),
            content: Text('Is the event venue booked?'),
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ensure your venue is ready before updating.'),
                    ),
                  );
                    // onNoPressed(); // Call the provided callback
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    final EventController eventController = Get.put(EventController());
                    final String new_status;
                    if(status == 'pending'){
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
                        print('######################################################################### nice this data for status was executed ${new_status}');
                    }else if(status == 'Ready'){
                      new_status = 'pending';
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
                    // onYesPressed(); // Call the provided callback
                  },
                ),
              ],
            ),
          ),
        ),
  );
}
