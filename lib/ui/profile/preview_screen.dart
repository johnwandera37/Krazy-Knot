import 'dart:io';
import 'package:photomanager/controllers/profile_controller.dart';
import '../../utils/export_files.dart';

class PreviewScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
  onWillPop: () async {
    await Get.offNamed(RouteHelper.getLandingRoute());
    Get.find<ProfileController>().profileData();
    return false;
  },
  child: Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          child: const CustomText(
            headingStr: 'ADD PHOTOS',
            weight: TextWeight.bold,
            fontSize: 19,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 20,
                ),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.pickImages();
            },
            icon: const Icon(
              Icons.add_a_photo,
              color: Colors.black,
            ),
          )
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: phoneMaxWidth,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Obx(() {
                  final selectedImages = controller.selectedImages.value;
                  return selectedImages.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedImages.length,
                                padding: const EdgeInsets.only(left: 20),
                                itemBuilder: (context, index) {
                                  final imageFile = selectedImages[index];
                                  return Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(imageFile.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomInput(
                              hintText: 'Enter your comment',
                              textEditingController:
                                  controller.commentController,
                            ),
                            const SizedBox(height: 40),
                            Obx(
                              () {
                                return controller.imageuploading.value
                                    ? Center(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 35),
                                          child: const CustomLoader(),
                                        ),
                                      )
                                    : Center(
                                        child: CustomButton(
                                          buttonStr: 'UPLOAD',
                                          vertMargin: 35,
                                          onTap: () {
                                            controller.postImagesAndComment();
                                          },
                                        ),
                                      );
                              },
                            ),
                          ],
                        )
                      : const Center(
                          child: CustomText(
                              headingStr: 'No images selected.'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
);

  }
}