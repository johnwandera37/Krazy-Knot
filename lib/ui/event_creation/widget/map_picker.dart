import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../../../utils/export_files.dart';
class MapPicker extends StatefulWidget{
  const MapPicker({super.key});

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  final MapPickerController mapPickerController = Get.put(MapPickerController());
  // TextEditingController locationAddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: OpenStreetMapSearchAndPick(
        center: const LatLong(23, 89),
        buttonColor: Colors.blue,
        buttonText: 'Confirm location',
        hintText: 'Search location',
        onPicked: (pickedData) {
          setState(() {
            String formattedAddress = formatAddress(pickedData.address);
           mapPickerController.setAddress(formattedAddress); // Update address using GetX
          });
          debugPrint('latitude ********************* ${pickedData.latLong.latitude}');
          debugPrint('logitude *********************${pickedData.latLong.longitude}');
          debugPrint('address *********************${pickedData.address}');
           Navigator.of(context).pop();//navigate back
        }),
        );
}
//  @override
//   void dispose() {
  
//     super.dispose();
//   }
}

String formatAddress(Map<String, dynamic> addressData) {
  // Define the fields to exclude
  List<String> excludedFields = ['ISO3166-2-lvl4', 'country_code'];

  // Extract and format the address components, excluding the specified fields
  List<String> formattedComponents = addressData.keys
      .where((componentKey) =>
          !excludedFields.contains(componentKey) &&
          addressData[componentKey] != null &&
          addressData[componentKey].isNotEmpty)
      .map((componentKey) => addressData[componentKey].toString())
      .toList();

  // Join the formatted components with ', '
  String formattedAddress = formattedComponents.join(', ');

  return formattedAddress;
}
