import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/ui/profile/addCommentScreen.dart';
import 'package:photomanager/ui/profile/image_view_screen.dart';
import 'package:photomanager/ui/profile/preview_screen.dart';

import '../../../utils/export_files.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    Get.find<ProfileController>().profileData();

    void _showModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: themeController.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: themeController.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sizedHeight(20),
                  GestureDetector(
                    onTap: () => Get.to(const AddCommentScreen()),
                    child: CustomText(
                      headingStr: 'ADD COMMENT',
                      fontColor: themeController.fontColor,
                      weight: TextWeight.normal,
                      fontSize: 14,
                      onTap: () => Get.to(const AddCommentScreen()),
                    ),
                  ),
                  sizedHeight(45),
                ],
              ),
            ),
          );
        },
      );
    }

    return GetBuilder<ProfileController>(builder: (profileController) {
      return profileController.userInfo == null
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.black,
              ),
            )
          : Center(
              child: SizedBox(
                width: phoneMaxWidth,
                child: Scaffold(
                    body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedHeight(Get.height * .06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(PreviewScreen()),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: const NeumorphicBoxShape.circle(),
                              depth: 8,
                              intensity: 0.6,
                              color: themeController.backgroundColor,
                              shadowDarkColor: themeController.shadowDarkColor,
                              shadowLightColor:
                                  themeController.shadowLightColor,
                            ),
                            child: CircleAvatar(
                              backgroundColor: themeController.backgroundColor,
                              radius: 40.0,
                              child: Center(
                                child: CustomText(
                                  headingStr:
                                      '${profileController.userInfo!.firstName![0]}${profileController.userInfo!.lastName![0]}',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedHeight(Get.height * .05),
                    CustomText(
                      headingStr:
                          '${profileController.userInfo!.firstName} ${profileController.userInfo!.lastName}',
                      weight: TextWeight.semiBold,
                      fontSize: 19,
                    ),
                    sizedHeight(Get.height * .03),
                    GestureDetector(
                      onTap: () => Get.to(PreviewScreen()),
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            6,
                          ),
                        ),
                        child: Center(
                          child: CustomText(
                            headingStr: '+  ADD PHOTO',
                            fontSize: 13,
                            onTap: () => Get.to(PreviewScreen()),
                          ),
                        ),
                      ),
                    ),
                    sizedHeight(Get.height * .03),
                    profileController.userInfo == null
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.black,
                            ),
                          )
                        : profileController.userInfo!.images.isEmpty
                            ? const Center(
                                child: CustomText(
                                    headingStr:
                                        "Your photos will be\ncollected here"),
                              )
                            : Expanded(
                                child: GridView.custom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  gridDelegate: SliverWovenGridDelegate.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    pattern: [
                                      WovenGridTile(1),
                                      WovenGridTile(
                                        5 / 7,
                                        crossAxisRatio: 0.9,
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                      ),
                                    ],
                                  ),
                                  childrenDelegate: SliverChildBuilderDelegate(
                                    (context, index) => GestureDetector(
                                      // onTap: () => _showModal(context),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: Colors.grey.withOpacity(.1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageViewScreen(
                                                        image: profileController
                                                            .userInfo!
                                                            .images[index]
                                                            .id,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: AspectRatio(
                                                  aspectRatio: 3,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    child: Image.network(
                                                      'https://smb.inet.africa:8080/api/user/image/${profileController.userInfo!.images[index].id}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            profileController
                                                    .userInfo!
                                                    .images[index]
                                                    .comment
                                                    .isEmpty
                                                ? Container()
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 10,
                                                    ),
                                                    child: CustomText(
                                                      maxLines: 2,
                                                      headingStr:
                                                          profileController
                                                              .userInfo!
                                                              .images[index]
                                                              .comment,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   children: [
                                            //     IconButton(
                                            //       onPressed: () => profileController.postLikeImage(
                                            //         profileController.dayImageModel!.images[index].id,
                                            //       ),
                                            //       icon: const Icon(
                                            //         Icons.favorite,
                                            //         size: 19,
                                            //       ),
                                            //     ),
                                            //     CustomText(
                                            //       headingStr: profileController
                                            //           .dayImageModel!.images[index].likes
                                            //           .toString(),
                                            //       fontSize: 14,
                                            //     )
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    childCount: profileController
                                        .userInfo!.images.length,
                                  ),
                                ),
                              ),
                  ],
                )),
              ),
            );
    });
  }
}
