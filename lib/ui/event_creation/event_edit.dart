import '../../../utils/export_files.dart';
import '../../controllers/profile_controller.dart';
import 'package:intl/intl.dart';

import '../../data/repo/events_repo.dart';

class EditEvent extends StatefulWidget {
  // const EditEvent({super.key});
  final String eventId;
  final String title;
  final String type;
  final String venue;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
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
  // late final ApiService apiService;
  // final EventController eventController =
  //     Get.put(EventController()); //for the events api
  var eventsRepo = EventsRepo(apiClient: Get.find());
 
  final DateTimeController dateTimeController =
      Get.put(DateTimeController()); //for the selected date variable
  final EventIdController eventIdController =
      Get.put(EventIdController()); //for PUT reqquest data
  // final RefreshLogic refreshLogic = RefreshLogic();
   FormValidator formValidator = FormValidator();//validations

  //pre-filling
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDescriptionController = TextEditingController();
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  String? selectedDropdownValue;//drop down selection

  @override
  void initState() {
    super.initState();
    var eventcontroller = Get.put(EventsController(eventsRepo: eventsRepo));

    eventIdController.setEventId(widget.eventId);//setting event id
  //title pre-fill 
  eventTitleController.text = widget.title;
  eventcontroller.title = eventTitleController;
  //description pre-fill 
    eventDescriptionController.text = widget.description;
    eventcontroller.description = eventDescriptionController;
    //drop down pre-fill
    selectedDropdownValue = widget.type;
    eventcontroller.selectType.text = widget.type;
  //date pre-fill
    // final DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    selectedStartDate = widget.startDate; //dateFormat.parse(widget.startDate);
    selectedEndDate = widget.endDate;//dateFormat.parse(widget.endDate);
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
    "Wedding",
    "Entertainment"
  ];

  //dte and time
  late DateTime selectedDateTime;
  

  void handleDropdownChange(String? value) {
    setState(() {
      var eventcontroller = Get.put(EventsController(eventsRepo: eventsRepo));
      selectedDropdownValue = value;
      eventcontroller.selectType.text = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
     var eventcontroller = Get.put(EventsController(eventsRepo: eventsRepo));
      //  initUserId() async {
      //           var controller = Get.find<ProfileController>();
      //           var profileData = await controller.profileData();
      //           debugPrint(
      //               'NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
      //           var user_id = controller.userInfo!.id;
      //           return user_id;
      //         }
      //        var  user = initUserId();
    return 
    Obx(() => 
    Scaffold(
        backgroundColor: HexColor('FBF9F1'),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconWidget(icon:Icons.arrow_back, bacIconColor: HexColor('F8DFD4'), onTap: (){
              Get.back();
        }),
          centerTitle: true,
          title: const Text(
            "Edit Event",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: 
           eventcontroller.loadingEditedEvent.value?
            Center(
                    child: CircularProgressIndicator(
                      color: HexColor('87C4FF')
                    ),
                  ):
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter new event title",
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: eventcontroller.title,
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                           border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
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
                InkWell(
                  onTap: () => Get.to(const MapPicker()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                       borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
               sizedHeight(30),
                  const CustomText(headingStr: 'From', align: TextAlignOption.center,fontSize: 16, weight: TextWeight.bold,), 
                const SizedBox(height: 20),
                DateTimePicker(
                  color: HexColor('FBF9F1'),
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
            const CustomText(headingStr: 'To', align: TextAlignOption.center,fontSize: 16, weight: TextWeight.bold,), 
                const SizedBox(height: 20),
                DateTimePicker(
                   color: HexColor('FBF9F1'),
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
                InputField(
                  hintText: "Enter new event description",
                  maxLines: 5,
                  controller: eventcontroller.description,
                  color:  HexColor('FBF9F1'),
                ),
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 0.6, // Set to 60% of the screen width
                  child: Center(
                    child: CustomButton(
                      btncolor: HexColor('FFAD84'),
                      buttonStr: "Edit Event",
                      onTap: () async {
                        if (formValidator.validateFields(context: context, selectedDropdownValue: selectedDropdownValue)) {
                        await eventcontroller.editEventData(context);
                        await eventcontroller.eventData();
                        }
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
