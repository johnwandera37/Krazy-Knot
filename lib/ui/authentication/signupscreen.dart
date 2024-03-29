import '../../utils/export_files.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: phoneMaxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Image.asset(
                    'assets/images/create.jpg',
                    fit: BoxFit.fill,
                  ),
                  sizedHeight(20),
                const CustomText(
                  headingStr: Constants.createAccountStr,
                  weight: TextWeight.bold,
                  fontSize: 20,
                ),
                const CustomText(
                  headingStr: Constants.toGetStartedStr,
                  weight: TextWeight.normal,
                  textHeight: 1.4,
                  fontSize: 21,
                ),
                sizedHeight(20),
                CustomInput(
                  hintText: Constants.yourNameHereStr,
                  textEditingController:
                      authController.signUpFullNameController,
                ),
                sizedHeight(20),
                CustomInput(
                  hintText: Constants.yourEmailHereStr,
                  textEditingController: authController.signUpEmailController,
                ),
                sizedHeight(20),
                CustomInput(
                  hintText: Constants.yourPassHereStr,
                  textEditingController:
                      authController.signUpPasswordController,
                  obscureText: true,
                ),
                // FORGOT PASS
                sizedHeight(15),
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
                              buttonStr: Constants.signUpStr.toUpperCase(),
                              vertMargin: 35,
                              onTap: () {
                                authController.initSignUpProcess();
                              },
                              btncolor: Colors.blue,
                            ),
                          );
                  },
                ),
                // SIGN UP LINK
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        headingStr: 'Already have an account? ',
                        weight: TextWeight.normal,
                        fontSize: 14,
                        textHeight: 2.0,
                      ),
                      CustomText(
                        onTap: () => Get.back(),
                        headingStr: Constants.loginNowStr,
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
      ),
    );
  }
}
