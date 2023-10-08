import '../../../utils/export_files.dart';

class EditEvent extends StatefulWidget {
  // const EditEvent({super.key});
  final String eventId;
  const EditEvent({required this.eventId, Key? key}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final MapPickerController mapPickerController =
      Get.put(MapPickerController());
  late final ApiService apiService;
  final EventController eventController =
      Get.put(EventController()); //for the events api
  final DateTimeController dateTimeController =
      Get.put(DateTimeController()); //for the selected date variable
  final EventIdController eventIdController =
      Get.put(EventIdController()); //for PUT reqquest data

  @override
  void initState() {
    super.initState();
    apiService = ApiService(); //for the http APIs
    eventIdController.setEventId(widget.eventId);
  }

//the drop down
  String? selectedDropdownValue;
  List<String> dropdownItems = [
    'Food',
    'Education',
    'Technology',
    "Sports",
    "Business",
    "Wedding"
  ];

  //dte and time
  DateTime selectedDateTime = DateTime.now();

  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
      eventController.selectType.text = value ?? "";
      dateTimeController.updateSelectedDateTimeStart(selectedDateTime);
      dateTimeController.updateSelectedDateTimeEnd(selectedDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Center(
            child: Text(
              "Edit Event",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Event Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter new event title",
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Specify the color here
                    ),
                  ),
                  controller: eventController.eventTitle,
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Event Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select new event type'),
                          value: selectedDropdownValue,
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: handleDropdownChange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Event Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => Get.to(const MapPicker()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              mapPickerController.address.value.isEmpty
                                  ? 'Select new Location'
                                  : mapPickerController.address.value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.location_on,
                            color: Colors
                                .black), // Changed the icon to location icon
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'From',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController
                          .updateSelectedDateTimeStart(selectedDateTime);
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'To',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController
                          .updateSelectedDateTimeEnd(selectedDateTime);
                    });
                  },
                ),
                const SizedBox(height: 40),
                const Text(
                  'Event Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: "Enter new event description",
                  maxLines: 5,
                  controller: eventController.eventDescription,
                ),
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 0.6, // Set to 60% of the screen width
                  child: Center(
                    child: CustomButton(
                      buttonStr: "Edit Event",
                      btncolor: Colors.blue,
                      onTap: () async {
                        eventController.editEvent();
                        Get.delete<MapPickerController>();
                        Get.delete<DateTimeController>();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
