import '../../../utils/export_files.dart';
import '../../controllers/profile_controller.dart';

class EditEvent extends StatefulWidget {
  // const EditEvent({super.key});
  final String eventId;
  final String title;
  final String type;
  final String venue;
  final String description;
  final String startDate;
  final String endDate;
  const EditEvent({
    required this.eventId,
    required this.title,
    required this.type,
    required this.venue,
    required this.description,
    required this.startDate,
    required this.endDate,

  
  Key? key}) : super(key: key);

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

  //pre-filling
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDescriptionController = TextEditingController();
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
   String? selectedDropdownValue;//drop down selection

  @override
  void initState() {
    super.initState();
    apiService = ApiService(); //for the http APIs
    eventIdController.setEventId(widget.eventId);
  //title pre-fill 
  eventTitleController.text = widget.title;
  eventController.eventTitle = eventTitleController;
  //description pre-fill 
    eventDescriptionController.text = widget.description;
    eventController.eventDescription = eventDescriptionController;
    //drop down pre-fill
    selectedDropdownValue = widget.type;

     // Extract date and time components for the initial values
    final List<String> startDateParts = widget.startDate.split('T');
    final List<String> endDateParts = widget.endDate.split('T');

    // Set initial values for date and time
    selectedStartDate = DateTime.parse(startDateParts[0]);
    selectedEndDate = DateTime.parse(endDateParts[0]);
  }

//the drop down list
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
    // final ProfileRepo _profileRepo = ProfileRepo(apiClient: Get.find());
    // final ProfileController _profileController =
    //     ProfileController(profileRepo: _profileRepo);

       initUserId() async {
                var controller = Get.find<ProfileController>();
                var profileData = await controller.profileData();
                debugPrint(
                    'NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
                var user_id = controller.userInfo!.id;
                return user_id;
              }
             var  user = initUserId();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
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
                          hint: const Text('Select an event type'),
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
                                  ? widget.venue
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
                  initialDateTime: selectedStartDate,
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
                  initialDateTime: selectedEndDate,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController
                          .updateSelectedDateTimeEnd(selectedDateTime);
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
                        // var event_owner = '65081b6f44dbbead5990e40a';
                        eventController.editEvent(user);
                        Get.delete<MapPickerController>();
                        Get.delete<DateTimeController>();
                        Get.delete<EventController>();
                        Get.back();
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
