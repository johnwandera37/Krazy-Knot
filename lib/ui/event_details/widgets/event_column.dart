// event_widgets.dart

import 'package:photomanager/utils/export_files.dart'; 

class EventColumn {
    final eventcontroller = Get.find<EventsController>();
    var attendeesRepo = AttendeesRepo(apiClient: Get.find());
 

  Widget eventColumn({
    required id,
    required String status,
    required String title,
    required String type,
    required DateTime start,
    required DateTime end,
    required String location,
    required String description,
    required BuildContext? context,
  }) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            UsersCircle(numberOfUsers: attendeescontroller.attendeesModel!.attendee.length, type: type,),
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
          eventcontroller.loadingEditedStatus.value?
          CircularProgressIndicator(
            color: HexColor('87C4FF')
          )
          : CustomText(headingStr: ' $status'),
          ],),

          const Spacer(),

          if((status.toLowerCase() == 'ready' || status.toLowerCase() == 'pending') && start.isAfter(DateTime.now()))
            CustomSwitch(
              eventId: id,
          )
          // else if((start.isBefore(DateTime.now()) && end.isAfter(DateTime.now())))
          else if(status.toLowerCase() == 'cancelled' || status.toLowerCase() == 'passed')
            CustomButton(buttonStr: 'Revive', btncolor: HexColor('FFAD84'),
            onTap: (){
              reviveEvent(status, context!);
            })
          else
          IconWidget(icon: Icons.info, onTap: (){
            MyUtils().handleinfo(status, context!);
           })  

            ],)
          ]
        ),
          sizedHeight(10),
          eventContainer(rows:[
            eventRow(text: title, iconData: Icons.event),
            sizedHeight(10),
            eventRow(text: '${Constants.eventType} $type', iconData: Icons.type_specimen_rounded),
            sizedHeight(10),
            eventRow(
                text: '${MyUtils().formatDateTime(start)} - ${MyUtils().formatDateTime(end)}',
                iconData: Icons.access_time_filled),
          ]),
          sizedHeight(10),
          eventContainer(rows: [
            eventRow(text: location, iconData: Icons.location_on)
          ]),
          sizedHeight(10),
          eventContainer(rows: [eventRow(text: description, iconData: Icons.description)],),
        ],
      );

  Widget eventContainer(
    {
    required List<Widget> rows, 
  EdgeInsetsGeometry? padding,}
  ) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color:Colors.grey.withOpacity(0.15)
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
            CircleAvatar(
            backgroundColor: Colors.white,
            radius: 14,
            child: Icon(
              iconData,
              color: Colors.black,
              size: 24,
            ),
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

