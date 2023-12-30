import '../../../utils/export_files.dart';

//handle cancel
void eventCancel({
  required BuildContext context,
  required String status,
}) {
  String dialogContent = 'You are about to cancel this event';
  showCustomDialog(
    context: context,
    title: "CANCEL EVENT",
    content: dialogContent,
    actions: [
     TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
               MyStyles().showSnackBar(messageText: 'No action taken!');
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                 final eventcontroller = Get.find<EventsController>();
                final String newStatus;
                if (status.toLowerCase() == 'pending' ||
                    status.toLowerCase() == 'ready') {
                  newStatus = 'Cancelled';
                  eventcontroller.editEventStatus(eventStatus: newStatus);
                }
                Navigator.of(context).pop();
              MyStyles().showSnackBar(messageText: 'Event has been cancelled!');
              },
            ),
    ],
  );
}

//handle reviving
  void reviveEvent(String revStatus, BuildContext context) async{
      try{
        String dialogContent = 'You are about to restore this event';
  showCustomDialog(
    context: context,
    title: "RESTORE EVENT",
    content: dialogContent,
    actions: [
     TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
               MyStyles().showSnackBar(messageText: 'No action taken!');
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async{
              final eventcontroller = Get.find<EventsController>();
              if(revStatus.toLowerCase() == 'cancelled'){
                String newRevivedStr = 'Pending';
                await eventcontroller.editEventStatus(eventStatus: newRevivedStr);
              }

              Navigator.of(context).pop();
              MyStyles().showSnackBar(messageText: 'Event has been revived!');
              },
            ),
    ],
  );
    }catch(e){
      debugPrint('😟😟😟 Reving on status error: $e');
    }
  }