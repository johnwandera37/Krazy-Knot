import '../../../../utils/export_files.dart';

// class DateTimePicker extends StatefulWidget {
//   final ValueChanged<DateTime>? onChanged;
//   final DateTime initialDateTime;

//   DateTimePicker({
//     required this.initialDateTime,
//     this.onChanged,
//   });

//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {
//   late DateTime _selectedDateTime;

//   @override
//   void initState() {
//     super.initState();
//     _selectedDateTime = widget.initialDateTime;
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate:DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != _selectedDateTime) {
//       setState(() {
//         _selectedDateTime = DateTime(
//           picked.year,
//           picked.month,
//           picked.day,
//           _selectedDateTime.hour,
//           _selectedDateTime.minute,
//         );
//         widget.onChanged?.call(_selectedDateTime);
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay minimumTime = TimeOfDay.fromDateTime(
//     DateTime.now().add(const Duration(minutes: 20)),
//   );
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: minimumTime,
//     );

//     if (picked != null) {
//       setState(() {
//         _selectedDateTime = DateTime(
//           _selectedDateTime.year,
//           _selectedDateTime.month,
//           _selectedDateTime.day,
//           picked.hour,
//           picked.minute,
//         );
//         widget.onChanged?.call(_selectedDateTime);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: inputDec(dateTimevalue: "${_selectedDateTime.toLocal()}".split(' ')[0], labelText: 'Date', onTap: () { _selectDate(context); }, onTextTap: () {  _selectDate(context); }),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: 
//           inputDec(dateTimevalue: "${_selectedDateTime.toLocal().toLocal()}".split(' ')[1], labelText: 'Time', onTap: () {_selectTime(context);}, onTextTap: () { _selectTime(context); }),
//         ),
//       ],
//     );
//   }
// }

//   inputDec({
//     required dateTimevalue,
//     required String labelText,
//     required VoidCallback onTap,
//     required VoidCallback onTextTap
//   }) =>    InkWell(
//     onTap: onTap,
//     child: InputDecorator(
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         filled: true,
//         labelText: labelText,
//         border: OutlineInputBorder(),
//       ),
//       child: CustomText(
//         headingStr: dateTimevalue, fontSize: 16,
//         onTap: onTextTap,
//       ),
//     ),
//   );


import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final ValueChanged<DateTime>? onChanged;
  final DateTime initialDateTime;

  DateTimePicker({
    required this.initialDateTime,
    this.onChanged,
  });

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDateTime) {
      setState(() {
        _selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
        widget.onChanged?.call(_selectedDateTime);
      });
    }
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay minimumTime = TimeOfDay.fromDateTime(
  //     DateTime.now().add(const Duration(minutes: 20)),
  //   );
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: minimumTime,
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       _selectedDateTime = DateTime(
  //         _selectedDateTime.year,
  //         _selectedDateTime.month,
  //         _selectedDateTime.day,
  //         picked.hour,
  //         picked.minute,
  //       );
  //       widget.onChanged?.call(_selectedDateTime);
  //     });
  //   }
  // }


  Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay currentTime = TimeOfDay.now();
  final TimeOfDay minimumTime = TimeOfDay(hour: currentTime.hour, minute: currentTime.minute);
  
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: minimumTime,
  );

  if (picked != null) {
    setState(() {
      _selectedDateTime = DateTime(
        _selectedDateTime.year,
        _selectedDateTime.month,
        _selectedDateTime.day,
        picked.hour,
        picked.minute,
      );
      widget.onChanged?.call(_selectedDateTime);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Row(
      children: [
        Expanded(
          child: inputDec(
            dateTimevalue: dateFormat.format(_selectedDateTime),
            labelText: 'Date',
            onTap: () {
              _selectDate(context);
            },
            onTextTap: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: inputDec(
            dateTimevalue: timeFormat.format(_selectedDateTime),
            labelText: 'Time',
            onTap: () {
              _selectTime(context);
            },
            onTextTap: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

Widget inputDec({
  required dateTimevalue,
  required String labelText,
  required VoidCallback onTap,
  required VoidCallback onTextTap,
}) =>
    InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        child: CustomText(
          headingStr: dateTimevalue,
          fontSize: 16,
          onTap: onTextTap,
        ),
      ),
    );
