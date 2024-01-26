import '../../../utils/export_files.dart';

//handle cancel
void eventCancel({
  required BuildContext context,
  required String status,
}) {
  String dialogContent = status.toLowerCase() == "passed" ?
  "You can only cancel events whose status is Ready or Pending"
  :'You are about to cancel this event';
  showCustomDialog(
    context: context,
    title: status.toLowerCase() == "passed" ? "WARNING":"CANCEL EVENT",
    content: dialogContent,
    actions: 
    status.toLowerCase() == 'passed'
    ? [
        Center(
          child: TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]
    :
    [
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
                    status.toLowerCase() == 'ready'
                    ) {
                  newStatus = 'Cancelled';
                  eventcontroller.editEventStatus(eventStatus: newStatus);
                }
                Navigator.of(context).pop();
              },
            ),
    ],
  );
}

//handle reviving
  void reviveEvent(String revStatus, BuildContext context) async{
      try{
        String dialogContent = 'You are about to restore this event ensure you update the dates too and any other necessary changes';
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
              if(revStatus.toLowerCase() == 'cancelled'|| revStatus.toLowerCase() == 'passed'){
                String newRevivedStr = 'Pending';
                await eventcontroller.editEventStatus(eventStatus: newRevivedStr);
              }
              Navigator.of(context).pop();
              },
            ),
    ],
  );
    }catch(e){
      debugPrint('😟😟😟 Reving on status error: $e');
      MyStyles().showSnackBar(messageText: 'Erro occured: $e');
    }
  }