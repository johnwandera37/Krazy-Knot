import 'package:photomanager/utils/export_files.dart';

class EnterOtpScreen extends StatelessWidget {
  const EnterOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: phoneMaxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedHeight(Get.height * .15),
              const CustomText(
                headingStr: 'Enter OTP',
                weight: TextWeight.bold,
                fontSize: 20,
              ),
               Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                 child:const CustomText(
                  headingStr: Constants.otpExpStr,
                  weight: TextWeight.normal,
                  textHeight: 1.4,         
                  fontSize: 17,
                             ),
               ),
              sizedHeight(20),
              CustomInput(
                hintText: Constants.hashStr,
                vertPadding: 20,
                textEditingController: authController.signUpOtpController,
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

              sizedHeight(Get.height * .1),

              // SUBMIT BUTTON
              Obx(
                () {
                  return authController.loading.value
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : CustomButton(
                          buttonStr: Constants.submitStr,
                          onTap: () {
                            authController.initEnterOtp();
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
