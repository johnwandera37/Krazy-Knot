import 'package:photomanager/utils/export_files.dart';

class ForgotOtpScreen extends StatelessWidget {
  const ForgotOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    Get.find<AuthController>().startTimer();
    return GetBuilder<AuthController>(builder: (authController) {
      return Obx(
        () => SafeArea(
          child: Scaffold(
            backgroundColor: themeController.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  sizedHeight(60),

                  // ENTER OTP
                  const CustomText(
                    headingStr: Constants.enterOtpStr,
                    weight: TextWeight.bold,
                    fontSize: 21,
                  ),

                  sizedHeight(15),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomText(
                      headingStr: Constants.otpExpStr,
                      weight: TextWeight.normal,
                      align: TextAlignOption.center,
                      textHeight: 1.3,
                      fontSize: 14,
                    ),
                  ),

                  sizedHeight(15),

                  // FORM INPUT SECTION
                  Form(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          CustomInput(
                            hintText: Constants.hashStr,
                            vertPadding: 20,
                            textEditingController:
                                authController.changePassOtpController,
                          ),
                        ],
                      ),
                    ),
                  ),

                  sizedHeight(20),

                  Obx(
                    () => CustomText(
                      headingStr: authController.counter.value > 1
                          ? 'OTP expires in ${authController.counter.value} seconds'
                          : "Back",
                      fontSize: authController.counter.value > 1 ? 13 : 17,
                      weight: authController.counter.value > 1
                          ? TextWeight.normal
                          : TextWeight.bold,
                      onTap: () {
                        if (authController.counter.value > 1) {
                          return;
                        }
                        Get.back();
                      },
                    ),
                  ),

                  sizedHeight(Get.height * .15),

                  // SUBMIT BUTTON
                  Obx(() {
                    return authController.loading.value
                        ? CircularProgressIndicator(
                            color: themeController.fontColor,
                          )
                        : CustomButton(
                            buttonStr: Constants.submitStr,
                            onTap: () {
                             // authController.initChangePasswordOtp();
                            },
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
