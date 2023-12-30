import 'package:photomanager/utils/export_files.dart';

class AttendeesTile extends StatelessWidget {
  // final AttendeesCard attendeesCard;
  final String name;
  final String phone;

  // AttendeesTile({super.key, required this.attendeesCard});
   AttendeesTile({
    super.key, 
    required this.name,
    required this.phone
    });

  final AttendeesController attendeeController = Get.find<AttendeesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor('C2DEDC')
      ),
      child:Column(
        children: [
        attendeeRow(text: name, iconData: Icons.person),
        sizedHeight(10),
        attendeeRow(text: phone, iconData: Icons.call),
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
