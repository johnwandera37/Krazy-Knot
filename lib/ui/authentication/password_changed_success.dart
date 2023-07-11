import 'package:photomanager/utils/export_files.dart';

class PasswordChangeSuccess extends StatelessWidget {
  const PasswordChangeSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const LoginScreen());
        return false;
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: themeController.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                sizedHeight(Get.height * .2),

                // SUCCESS MSG
                CustomText(
                  headingStr: Constants.successStr,
                  weight: TextWeight.bold,
                  fontSize: 21,
                ),

                sizedHeight(15),

                // DESC
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: CustomText(
                    headingStr: Constants.successfullyChangePassStr,
                    weight: TextWeight.normal,
                    align: TextAlignOption.center,
                    textHeight: 1.3,
                    fontSize: 14,
                  ),
                ),

                sizedHeight(60),

                // BACK BUTTON
                CustomButton(
                  buttonStr: Constants.continueStr,
                  onTap: () {
                    Get.offAndToNamed(RouteHelper.getLoginRoute());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
