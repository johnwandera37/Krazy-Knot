


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
          // Center(
          //   child: Container(
          //     margin: const EdgeInsets.only(bottom: 30),
          //     child: CustomImage(
          //       image: themeController.logoIcon(),
          //       imageHeight: Get.height * .4,
          //       imageWidth: Get.width * .65,
          //     ),
          //   ),
          // ),

          // LOADER
          Container(
            margin: EdgeInsets.only(top: Get.width),
            child: CustomLoader(
              size: 30,
            ),
          ),

          // FOOTER MESSAGE
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const CustomText(
                headingStr: Constants.poweredByStr,
                fontSize: 11,
                weight: TextWeight.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
