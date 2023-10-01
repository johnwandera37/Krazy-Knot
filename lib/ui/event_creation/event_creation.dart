import '../../../utils/export_files.dart';
import '../../utils/images.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
 final MapPickerController mapPickerController = Get.put(MapPickerController());

TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    addressController.text =mapPickerController.address.value; // Set the initial value
  }

//the drop down
  String? selectedDropdownValue;
  List<String> dropdownItems = ['Food', 'Education', 'Technology', "Sports", "Business", "Wedding"];
  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
    });
  }
//dte and time
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return 
    Obx(() => 
    Scaffold(
      backgroundColor: HexColor("F7F7F7"),
      appBar: AppBar(
      elevation: 0,
      backgroundColor: HexColor("F7F7F7"),
      title: const Center(child: CustomText(headingStr: "Create Event", fontSize: 18, weight: TextWeight.semiBold,)),
      ),
      body:SingleChildScrollView(
        child: 
        Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              //Fill description
              const CustomText(headingStr: "Fill the following details to create an event", fontSize: 16, weight: TextWeight.semiBold,),
              sizedHeight(20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                  //title
                  const Eventnput(hintText: "Enter event title", vertPadding: 8,),
                  //select type
                  Eventnput(hintText: "Select type of event", 
                  dropdownItems: dropdownItems, 
                  selectedDropdownValue: selectedDropdownValue, 
                  onDropdownChanged: handleDropdownChange,
                  ),
                  //location
                 
                  Eventnput(hintText: "Location", vertPadding: 8, suffixIconPath: Images.location, initialValue: mapPickerController.address.value,),
                  CustomButton(buttonStr: "Select location", onTap: (){Get.to(MapPicker());}),
                  CustomText(headingStr: mapPickerController.address.value)
                ]),
              ),
              sizedHeight(20),
              //date and time
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                CustomText(headingStr: "From"),
                sizedHeight(20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                    });
                  },
                ),
                 sizedHeight(20),
                 CustomText(headingStr: "From"),
                 sizedHeight(20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                    });
                  },
                ),
        
                ]),
              ),
        
                sizedHeight(20),
                //description
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                
               Eventnput(hintText: "Enter even description", maxLines: 5,)
                ]),
              ),

              sizedHeight(30),
              //create button
              CustomButton(buttonStr: "Create event", onTap: (){})

            ],
          ),
        ),
      )
    )
    );
  }
}