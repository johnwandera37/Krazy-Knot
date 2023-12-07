import '../../../utils/export_files.dart';
import '../../controllers/profile_controller.dart';
import 'package:intl/intl.dart';

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
    eventController.selectType.text = widget.type;
  //date pre-fill
    final DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    selectedStartDate = dateFormat.parse(widget.startDate);
    selectedEndDate = dateFormat.parse(widget.endDate);
    dateTimeController.updateSelectedDateTimeStart(selectedStartDate);
    dateTimeController.updateSelectedDateTimeEnd(selectedEndDate);
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
  late DateTime selectedDateTime;
  

  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
      eventController.selectType.text = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
       initUserId() async {
                var controller = Get.find<ProfileController>();
                var profileData = await controller.profileData();
                debugPrint(
                    'NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
                var user_id = controller.userInfo!.id;
                return user_id;
              }
             var  user = initUserId();
    return 
    WillPopScope(
          onWillPop: () async {
        // Clear text editing controllers, map value and date value when back button is pressed
      Get.delete<MapPickerController>();
      Get.delete<DateTimeController>();
        Get.delete<EventController>();
        return true; // Allow back navigation
      },
      child: Obx(
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
                                    ? mapPickerController.address.value = widget.venue //location pre-fill
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
                          eventController.editEvent(user);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
