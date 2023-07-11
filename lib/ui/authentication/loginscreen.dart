import '../../utils/export_files.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                headingStr: Constants.welcomeStr,
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
                textEditingController: authController.loginPhoneController,
              ),
              sizedHeight(10),
              CustomInput(
                hintText: Constants.yourPassStr,
                textEditingController: authController.loginPasswordController,
              ),

              // FORGOT PASS
              sizedHeight(15),

              Row(
                children: [
                  Expanded(child: Container()),
                  CustomText(
                    headingStr: Constants.forgotPassStr,
                    fontSize: 13.5,
                    weight: TextWeight.semiBold,
                    decoration: TextDecorationOption.underline,
                    onTap: () {
                      Get.toNamed(RouteHelper.forgotPassword);
                    },
                  ),
                  sizedWidth(40),
                ],
              ),

              // SIGN IN BUTTON
              Obx(
                () {
                  return authController.loading.value
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 35),
                            child: const CustomLoader(),
                          ),
                        )
                      : Center(
                          child: CustomButton(
                            buttonStr: Constants.signInStr.toUpperCase(),
                            vertMargin: 35,
                            onTap: () {
                              authController.initLoginProcess();
                            },
                          ),
                        );
                },
              ),

              Expanded(
                child: Container(),
              ),

              // SIGN UP LINK
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      headingStr: 'Don\'t have an account? ',
                      weight: TextWeight.normal,
                      fontSize: 14,
                      textHeight: 2.0,
                    ),
                    CustomText(
                      onTap: () => Get.toNamed(RouteHelper.signup),
                      headingStr: Constants.signNowStr,
                      decoration: TextDecorationOption.underline,
                      weight: TextWeight.semiBold,
                      fontSize: 14,
                      textHeight: 2.0,
                    ),
                  ],
                ),
              ),
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
