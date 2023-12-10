import 'package:geolocator/geolocator.dart';

import '../utils/export_files.dart';

//DEFAULT LOCATION CONTROLLER
class LocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
 var isLoading = false.obs;
    Rx<double?> latitude = Rx<double?>(null);  // Nullable double
  Rx<double?> longitude = Rx<double?>(null);
  void Function(double?, double?)? onLocationFetched;
  @override
  void onInit() {
    super.onInit();
    fetchLocation();
    listenToLocationServiceChanges();
  }

  void fetchLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    
    
   if(permission != LocationPermission.denied)
    {
       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(serviceEnabled){
        try {
        isLoading.value = true;
        Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        );
    currentPosition.value = position;
    if (position != null) {
      fetchDataByCoordinates(position.latitude, position.longitude);
    }

      } catch (e) {
        print('Error fetching location: $e');
        return null;
      }finally{
        isLoading.value = false;
      }

      }else{
        //handle if location services are not granted
        print('gps, network services are not granted');
         showPermissionDeniedDialog();
      } 
    }else if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      // openAppSettings();
    }
  }

//get cordinates
  void fetchDataByCoordinates (double latitude, double longitude) async {
    try {
    isLoading.value = true;
    print('The following is my default location cordinates ##########################################################');
    print(latitude);
    print(longitude);
    this.latitude.value = latitude;
      this.longitude.value = longitude;
        if (onLocationFetched != null) {
        onLocationFetched!(latitude, longitude);
      }

    } catch (e) {
      debugPrint('Error occured here => $e');
    }finally{
      isLoading.value = false;
    }
  }

  void showPermissionDeniedDialog() {
  showCustomDialog(
    context: Get.context!,
    title: "Location Permission Required",
    content: "Please enable location services to use this feature",
    actions: [
      TextButton(
        child: const Text('No'),
        onPressed: () {
          Navigator.of(Get.context!).pop();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              content: Text("You need to enable location services in order to select location"),
            ),
          );
        },
      ),
      TextButton(
        child: const Text('Yes'),
        onPressed: () {
          openAppSettings(); // redirect the user to app settings
          Get.back();
        },
      ),
    ],
  );
}

// open location settings
  void openAppSettings()  {
  Geolocator.openLocationSettings();
}

//fetch data immediately location service is enabled
 void listenToLocationServiceChanges() {
    Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.enabled) {
        fetchLocation();
      }
    });
  }


}