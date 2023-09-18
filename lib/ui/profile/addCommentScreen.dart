import 'package:photomanager/controllers/profile_controller.dart';

import '../../utils/export_files.dart';

class AddCommentScreen extends StatelessWidget {
  const AddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: phoneMaxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedHeight(Get.height * .15),
              const CustomText(
                headingStr: 'Add Comment',
                weight: TextWeight.bold,
                fontSize: 20,
              ),
              const CustomText(
                headingStr: 'Please add the comment below.',
                weight: TextWeight.normal,
                textHeight: 1.4,
                fontSize: 18,
              ),
              sizedHeight(20),
              CustomInput(
                hintText: 'Type your comment',
                textEditingController: profileController.commentController,
              ),
              sizedHeight(10),



              // SIGN IN BUTTON
              Obx(
                () {
                  return profileController.loading.value
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 35),
                            child: const CustomLoader(),
                          ),
                        )
                      : Center(
                          child: CustomButton(
                            buttonStr: 'ADD COMMENT',
                            vertMargin: 35,
                            onTap: () {
                              //authController.initLoginProcess();
                            },
                          ),
                        );
                },
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
