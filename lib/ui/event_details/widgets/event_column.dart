// event_widgets.dart

import 'package:photomanager/utils/export_files.dart';

class EventColumn {
    final eventcontroller = Get.find<EventsController>();
      final EventIdController eventIdController =
      Get.put(EventIdController());
     var attendeesRepo = AttendeesRepo(apiClient: Get.find());
  // hanlde status update;
   void handleSwitchChanged(String currentStatus) async {
    var statuscheck =currentStatus.toLowerCase();
    String newStatus = statuscheck == 'ready' ? 'Pending' : 'Ready';

    debugPrint('Switch toggled✂️✂️: $newStatus');
    try{
      await eventcontroller.editEventStatus(eventStatus: newStatus);
    }catch(e){
      debugPrint('😟😟😟 handleSwitchChange on status error: $e');
    }
  }

  Widget eventColumn({
    required id,
    required String status,
    required String title,
    required String type,
    required DateTime start,
    required DateTime end,
    required String location,
    required String description,
    required BuildContext? context
  }) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            UsersCircle(numberOfUsers: eventIdController.numberOfAttendees.value, type: type,), // attendeescontroller.attendeesModel?.attendee.length ?? 0
            sizedWidth(8),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HexColor('EEF5FF'),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
              ),
              child: CustomText(headingStr: 'View Guets', fontSize: 17, onTap: ()async{
                 var attendeescontroller = Get.put(AttendeesController(attendeesRepo: attendeesRepo));
                await attendeescontroller.attendeesData(id);
                Get.to(GuestTab(eventId: id));
              },)
              )
          ],),
        sizedHeight(10),
        eventContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          rows:[
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(headingStr: Constants.eventStatus, fontSize: 16,)),
          Row(children: [
          Row(children: [
           Icon(Icons.fiber_manual_record, size: 16, color: MyUtils().getStatusColor(status.toLowerCase())),
           sizedWidth(6),
           CustomText(headingStr: ' $status'),
          ],),

          const Spacer(),

          if(status.toLowerCase() == 'ready' || status.toLowerCase() == 'pending')
            CustomSwitch(onChanged: (value) {
            handleSwitchChanged(status);
          }
          )
          else
            CustomButton(buttonStr: 'Revive', btncolor: HexColor('FFAD84'),
            onTap: (){
              reviveEvent(status, context!);
            })

            ],)
          ]
        ),
          sizedHeight(10),
          eventContainer(rows:[
            eventRow(text: title, iconData: Icons.assignment_turned_in_outlined),
            sizedHeight(10),
            eventRow(text: '${Constants.eventType} $type', iconData: Icons.event_note_outlined),
            sizedHeight(10),
            eventRow(
                text: '${MyUtils().formatDateTime(start)} - ${MyUtils().formatDateTime(end)}',
                iconData: Icons.access_time_rounded),
          ]),
          sizedHeight(10),
          eventContainer(rows: [
            eventRow(text: location, iconData: Icons.location_on)
          ]),
          sizedHeight(10),
          eventContainer(rows: [eventRow(text: description, iconData: Icons.description_outlined)],),
        ],
      );

  Widget eventContainer(
    {
    required List<Widget> rows, 
  EdgeInsetsGeometry? padding,}
  ) => Container(
        decoration: BoxDecoration(
          color: HexColor('ECF2FF'),
          borderRadius: BorderRadius.circular(10),
        ),
         padding: padding ?? EdgeInsets.all(20),
        child: Column(
          children: [
            ...rows// for (var row in rows) ...[row],
          ],
        ),
      );

  Widget eventRow({
    required String text,
    required IconData iconData,
  }) =>
      Row(
        children: [
          Icon(
            iconData,
            color: HexColor('45474B'),
            size: 30,
          ),
          sizedWidth(10),
          Expanded(
            child: CustomText(
              headingStr: text,
              fontSize: 16,
              maxLines: 10,
            ),
          )
        ],
      );
}

