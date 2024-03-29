import 'package:photomanager/ui/authentication/forgot_pass_screen.dart';
import 'package:photomanager/ui/authentication/requestOTP.dart';

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
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // sizedHeight(Get.height * .15),
                Image.asset(
                    'assets/images/login.png',
                    // width: 100,
                    // height: 100,
                    fit: BoxFit.fill,
                  ),
              const Center(
                child: CustomText(
                  headingStr: Constants.welcomeStr,
                  weight: TextWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Center(
                child: CustomText(
                  headingStr: Constants.gladToSeeYou,
                  weight: TextWeight.normal,
                  textHeight: 1.4,
                  fontSize: 21,
                ),
              ),
              sizedHeight(20),
              CustomInput(
                hintText: Constants.enterEmailStr,
                textEditingController: authController.loginEmailController,
              ),
              sizedHeight(20),
              CustomInput(
                hintText: Constants.yourPassStr,
                textEditingController: authController.loginPasswordController,
                obscureText: true,
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
                      Get.to(RequestOTP());
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
                            btncolor: Colors.blue,
                          ),
                        );
                },
              ),
              sizedHeight(20),
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
              sizedHeight(30),
            ],
          ),
        ),
      ),
    );
  }
}
