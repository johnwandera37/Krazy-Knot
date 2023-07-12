

import '../../../utils/export_files.dart';

class AddPhotoTab extends StatelessWidget {
  const AddPhotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomText(headingStr: 'Add Photo'),
      ),
    );
  }
}