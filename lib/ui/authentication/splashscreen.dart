import '../../../utils/export_files.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Stack(
        children: [
          //LOGO
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Text(
                Constants.appName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.sacramento(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  height: 1.3,
                ),
              ),
            ),
          ),

          // LOADER
          Center(
            child: Container(
              margin: EdgeInsets.only(top: Get.width),
              child:const CustomLoader(
                size: 3,
              ),
            ),
          ),

          // FOOTER MESSAGE
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const CustomText(
                headingStr: Constants.poweredByStr,
                fontSize: 10,
                weight: TextWeight.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
