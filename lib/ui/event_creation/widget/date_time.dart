import '../../../../utils/export_files.dart';

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
      firstDate: DateTime(2000),
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
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
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                filled: true,
                  fillColor: Colors.white,
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              child: CustomText(headingStr:
                "${_selectedDateTime.toLocal()}".split(' ')[0], fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () => _selectTime(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Time',
                border: OutlineInputBorder(),
              ),
              child: CustomText(
                headingStr: "${_selectedDateTime.toLocal().toLocal()}".split(' ')[1], fontSize: 16, 
              ),
            ),
          ),
        ),
      ],
    );
  }
}