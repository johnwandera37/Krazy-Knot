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

  Future<void> requestOTP(String email) async {
    if (email.isEmpty) {
      return;
    }

    final String apiUrl = '${baseUrl}user/requestOTP';

    Map<String, String> data = {
      'email': email,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'OTP sent to your email',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        setState(() {
          otpReceived = true; // Set OTP received to true on success
        });
      } else {
        Get.snackbar(
        'Error',
        'Failed to generate OTP',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
        setState(() {
          otpReceived = false; // Set OTP received to false on failure
        });
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  Future<void> verifyOTP(String email, String OTP) async {
    if (email.isEmpty || OTP.isEmpty) {
      return;
    }

    final String apiUrl = '${baseUrl}user/requestOTP';

    Map<String, String> data = {
      'email': email,
      'OTP': OTP,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'OTP Verified',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(const ForgotPasswordScreen());
      } else {
        Get.snackbar(
          'Error',
          'Failed to Verify OTP',
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
        title: Text('Request OTP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter Email',
              ),
            ),
            SizedBox(height: 20.0),
            if (otpReceived) // Show OTP field only if OTP received
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _OTPController,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (otpReceived) {
                  verifyOTP(_emailController.text, _OTPController.text);
                } else {
                  requestOTP(_emailController.text);
                }
              },
              child: Text(otpReceived ? 'Verify OTP' : 'Request OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
