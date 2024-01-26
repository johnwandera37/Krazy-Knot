import '../../../utils/export_files.dart';
import 'package:get_storage/get_storage.dart';

// class CustomSwitch extends StatefulWidget {
//   final ValueChanged<bool>? onChanged;
//   final Color? activeColor;
//   const CustomSwitch({ 
//     super.key, 
//     this.onChanged,
//     this.activeColor
//     });

//   @override
//   State<CustomSwitch> createState() => _CustomSwitchState();
// }

// class _CustomSwitchState extends State<CustomSwitch> {
//   // bool light = false;
//   bool light = GetStorage().read('switchState') ?? false;

//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       // This bool value toggles the switch.
//       value: light,
//       activeColor: widget.activeColor ?? HexColor('F66B0E'),
//       onChanged: 
//       (bool value) {
//         // This is called when the user toggles the switch.
//         setState(() {
//           light = value;
//         });
//          // Call the callback function if provided
//         if (widget.onChanged != null) {
//           widget.onChanged!(value);
//             light = value;
//         }
//       },
//     );
//   }
// }

// class CustomSwitch extends StatelessWidget {
//   final ValueChanged<bool>? onChanged;
//   final Color? activeColor;

//   const CustomSwitch({Key? key, this.onChanged, this.activeColor}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool light = GetStorage().read('switchState') ?? false;

//     return Switch(
//       value: light,
//       activeColor: activeColor ?? HexColor('F66B0E'),
//       onChanged: (bool value) {
//         // Update switch state
//         GetStorage().write('switchState', value);

//         // Call the callback function if provided
//         if (onChanged != null) {
//           onChanged!(value);
//         }
//       },
//     );
//   }
// }
class CustomSwitch extends StatelessWidget {
  final String eventId;
  final Color? activeColor;

  const CustomSwitch({
  Key? key,
  required this.eventId,
  this.activeColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsController>(
      builder: (eventscontroller) {
            String? currentStatus = eventscontroller.eventModel?.events
                .firstWhere((event) => event.id == eventId)?.eventStatus;

       bool isReady = currentStatus!.toLowerCase() == 'ready';

    return Switch(
      value: isReady,
      activeColor: activeColor ?? HexColor('F66B0E'),
      onChanged: (bool value) {
        // Update switch state
        GetStorage().write(eventId, value);

      // Update event status
      String newStatus = value ? 'Ready' : 'Pending';
      eventcontroller.editEventStatus(eventStatus: newStatus, eventid: eventId);
      },
    );

       },
    );
  }
}
