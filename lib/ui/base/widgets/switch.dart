import '../../../utils/export_files.dart';

class CustomSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  const CustomSwitch({
    super.key, 
    this.onChanged,
    this.activeColor
    });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: widget.activeColor ?? HexColor('F66B0E'),
      onChanged: 
      (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
         // Call the callback function if provided
        if (widget.onChanged != null) {
          widget.onChanged!(value);
            light = value;
        }
      },
    );
  }
}