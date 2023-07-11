import 'package:photomanager/utils/export_files.dart';

class EnterPhoneScreen extends StatelessWidget {
  const EnterPhoneScreen({super.key});

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
                headingStr: 'Your Phone',
                weight: TextWeight.bold,
                fontSize: 20,
              ),
              const CustomText(
                headingStr: Constants.gladToSeeYou,
                weight: TextWeight.normal,
                textHeight: 1.4,
                fontSize: 21,
              ),
              sizedHeight(20),
              CustomInput(
                hintText: Constants.enterPhoneStr,
                vertPadding: 20,
                // prefixIconPath: Images.countryIcon,
                textEditingController: authController.signUpPhoneController,
              ),
              sizedHeight(20),

              Obx(
                () {
                  return authController.loading.value
                      ? const CustomLoader()
                      : CustomButton(
                          buttonStr: Constants.submitStr,
                          onTap: () {
                            //Get.toNamed(RouteHelper.getEnterOtpRoute());
                            authController.initEnterPhone();
                          },
                        );
                },
              ),

              // Expanded(
              //   child: Container(),
              // ),

              // // SIGN UP LINK
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const CustomText(
              //         headingStr: 'Don\'t have an account? ',
              //         weight: TextWeight.normal,
              //         fontSize: 14,
              //         textHeight: 2.0,
              //       ),
              //       CustomText(
              //         onTap: () => Get.toNamed(RouteHelper.signup),
              //         headingStr: Constants.signNowStr,
              //         decoration: TextDecorationOption.underline,
              //         weight: TextWeight.semiBold,
              //         fontSize: 14,
              //         textHeight: 2.0,
              //       ),
              //     ],
              //   ),
              // ),
              sizedHeight(
                30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
