import 'package:photomanager/utils/export_files.dart';

class AttendeesTile extends StatelessWidget {
  final AttendeesCard attendeesCard;
  // final String name;
  // final String phone;

  // AttendeesTile({super.key, required this.attendeesCard});
   AttendeesTile({
    super.key, 
    required this.attendeesCard
    // required this.name,
    // required this.phone
    });

  final AttendeesController attendeeController = Get.find<AttendeesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      // margin: const EdgeInsets.all(15),
      margin:  const EdgeInsets.fromLTRB(15, 20, 15, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.2)
      ),
      child:Column(
        children: [
        attendeeRow(text: attendeesCard.attendeeName, iconData: Icons.person),//name
        sizedHeight(10),
        attendeeRow(text: attendeesCard.attendeePhone, iconData: Icons.call),//phone
        ],
      ));
  }

  Widget attendeeRow({
    required String text,
    required IconData iconData,
  }) {
    return 
    Row(
      children: [
        Icon(
          iconData,
          color: HexColor('445069'),
          size:26,
        ),
        sizedWidth(10),
        Expanded(
          child: CustomText(
            headingStr: text,
            fontSize: 16,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}
