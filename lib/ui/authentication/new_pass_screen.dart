import '../../utils/export_files.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Obx(
          () => SafeArea(
            child: Scaffold(
              backgroundColor: themeController.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedHeight(60),

                    // NEW PASSWORD
                    CustomText(
                      headingStr: Constants.newPassword_Str,
                      weight: TextWeight.bold,
                      fontSize: 21,
                    ),

                    sizedHeight(15),

                    // DESC
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomText(
                        headingStr: Constants.newPassExpStr,
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
                              hintText: Constants.yourPassHereStr,
                              vertPadding: 20,
                              textEditingController:
                                  authController.newPasswordController,
                            ),
                          ],
                        ),
                      ),
                    ),

                    sizedHeight(Get.height * .15),

                    // SUBMIT BUTTON
                    Obx(
                      () {
                        return authController.loading.value
                            ? CircularProgressIndicator(
                                color: themeController.fontColor,
                              )
                            : CustomButton(
                                buttonStr: Constants.submitStr,
                                onTap: () {
                                  authController.initChangeUserPassword();
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
