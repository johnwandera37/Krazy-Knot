import '../../utils/export_files.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              headingStr: 'Welome,',
              weight: TextWeight.bold,
              fontSize: 20,
            ),
            
          ],
        ),
      ),
    );
  }
}
