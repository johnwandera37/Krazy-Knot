import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/export_files.dart';
import 'forgot_pass_screen.dart';

class RequestOTP extends StatefulWidget {
  RequestOTP({Key? key}) : super(key: key);

  @override
  _RequestOTPState createState() => _RequestOTPState();
}

class _RequestOTPState extends State<RequestOTP> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _OTPController = TextEditingController();
  final String baseUrl = Constants.baseUrl;
  bool otpReceived = false; // Track if OTP has been received
  bool isLoading = false; // Track loading state

  Future<void> requestOTP(String Email) async {
    if (Email.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true; // Set loading state to true
    });

    final String apiUrl = '${baseUrl}user/requestOTP';

    Map<String, String> data = {
      'email': Email,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        debugPrint('OTP response::::::::::::::${response.body}');
        String successMessage = json.decode(response.body)['message'];
        Get.snackbar(
          'Success',
          successMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        setState(() {
          otpReceived = true; // Set OTP received to true on success
          isLoading =
              false; // Set loading state to false after the request is completed
        });
      } else {
        debugPrint('OTP response::::::::::::::${response.body}');
        String errorMessage = json.decode(response.body)['error'];
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        setState(() {
          isLoading =
              false; // Set loading state to false after the request is completed
        });
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  Future<void> verifyOTP(String Email, String OTP) async {
    if (Email.isEmpty || OTP.isEmpty) {
      return;
    }

    final String apiUrl = '${baseUrl}user/requestOTP';

    Map<String, String> data = {
      'email': Email,
      'OTP': OTP,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        debugPrint('OTP response::::::::::::::${response.body}');
        String successMessage = json.decode(response.body)['message'];
        Get.snackbar(
          'Success',
          successMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        setState(() {
          otpReceived = false; // Set OTP received to false on failure
          isLoading =
              false; // Set loading state to false after the request is completed
        });
        Get.to(ForgotPasswordScreen(email: Email));
      } else {
        debugPrint('OTP response::::::::::::::${response.body}');
        String errorMessage = json.decode(response.body)['error'];
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const BackButton(),
        title: const Text(
          "Request OTP",
          style: TextStyle(
            fontSize: 18.5,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // sizedHeight(Get.width*.19),
            Image.asset(
              'assets/images/otp.png',
              fit: BoxFit.fill,
            ),
            // sizedHeight(Get.width *.1),
            // TextFormField(
            //   keyboardType: TextInputType.emailAddress,
            //   controller: _emailController,
            //   decoration: InputDecoration(
            //     hintText: 'Enter Email',
            //   ),
            // ),
            CustomInput(
              hintText: "Enter Email",
              textEditingController: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            if (otpReceived) // Show OTP field only if OTP received
              // TextFormField(
              //   keyboardType: TextInputType.number,
              //   controller: _OTPController,
              //   decoration: InputDecoration(
              //     hintText: 'Enter OTP',
              //   ),
              // ),
              CustomInput(
                hintText: "Enter OTP",
                textEditingController: _OTPController,
                keyboardType: TextInputType.number,
              ),
            sizedHeight(Get.width * .1),
            Visibility(
                visible: !isLoading, // Hide the button when isLoading is true
                child: CustomButton(
                  buttonStr: otpReceived ? 'Verify OTP' : 'Request OTP',
                  onTap: () {
                    if (otpReceived) {
                      verifyOTP(_emailController.text, _OTPController.text);
                    } else {
                      requestOTP(_emailController.text);
                    }
                  },
                  btncolor: Colors.blue,
                )),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
