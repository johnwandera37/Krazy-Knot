import 'package:photomanager/utils/export_files.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String email;
  const ForgotPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Center(
          child: Container(
            width: phoneMaxWidth,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // sizedHeight(60),
                             Image.asset(
                    'assets/images/newpassword.png',
                   fit: BoxFit.fill,
                  ),

                      // ENTER PHONE
                      CustomText(
                        headingStr: 'New password',
                        weight: TextWeight.bold,
                        fontSize: 21,
                      ),

                      sizedHeight(15),

                      // DESC
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: CustomText(
                          headingStr: 'Use something memorable for you but difficult for others to guess',
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
                              // CustomInput(
                              //   hintText: Constants.enterEmailStr,
                              //   enabled: false,
                              //   initialValue: email,
                              //   vertPadding: 10,
                              //   textEditingController:
                              //       authController.loginEmailController,
                              // ),
                              sizedHeight(10),
                              CustomInput(
                                hintText: Constants.yourNewPassStr,
                                textEditingController:
                                    authController.newPasswordController,
                                    obscureText: true,
                              ),
                            ],
                          ),
                        ),
                      ),

                      sizedHeight(Get.height * .1),

                      CustomButton(
                        buttonStr: Constants.submitStr,
                        onTap: () {
                          authController.initChangePassword(email);
                        },
                      ),

                      // SUBMIT BUTTON
                      // Obx(
                      //   () {
                      //     return authController.loading.value
                      //         ? CircularProgressIndicator(
                      //             color: themeController.fontColor,
                      //           )
                      //         : CustomButton(
                      //             buttonStr: Constants.submitStr,
                      //             onTap: () {
                      //               authController.initChangePassword();
                      //             },
                      //           );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
