import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/ui/profile/image_view_screen.dart';

import '../../../utils/export_files.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().getDayImages('1');
    Get.find<ProfileController>().getDayImages2('2');
    Get.find<ProfileController>().getDayImages3('3');
    Get.find<ProfileController>().getDayImages4('4');
    Get.find<ProfileController>().getDayImages5('5');
    var profileController = Get.find<ProfileController>();
    return Center(
      child: SizedBox(
        width: phoneMaxWidth,
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  tabs: [
                    Center(
                        child: Text(
                      'DAY 1',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    )),
                    Center(
                        child: Text(
                      'DAY 2',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    )),
                    Center(
                        child: Text(
                      'DAY 3',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    )),
                    Center(
                        child: Text(
                      'DAY 4',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    )),
                    Center(
                        child: Text(
                      'DAY 5',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            body: GetBuilder<ProfileController>(builder: (profileController) {
              return TabBarView(
                children: [
                  //FIRST TAB
                  profileController.dayImageModel == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : profileController.dayImageModel!.images.isEmpty
                          ? const Center(
                            child:  CustomText(
                                headingStr:
                                    "Photos will be available after event"),
                          )
                          : dayTabImageList(profileController),
                  //SECOND TAB
                  profileController.dayTwoImageModel == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : profileController.dayTwoImageModel!.images.isEmpty
                          ? const Center(
                              child: CustomText(
                                  headingStr:
                                      "Photos will be available after event"),
                            )
                          : dayTabImageList2(profileController),
                  //THIRD TAB
                  profileController.dayThreeImageModel == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : profileController.dayThreeImageModel!.images.isEmpty
                          ? const Center(
                              child: CustomText(
                                  headingStr:
                                      "Photos will be available after event"),
                            )
                          : dayTabImageList3(profileController),
                  //FOURTH TAB
                  profileController.dayFourImageModel == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : profileController.dayFourImageModel!.images.isEmpty
                          ? const Center(
                              child: CustomText(
                                  headingStr:
                                      "Photos will be available after event"),
                            )
                          : dayTabImageList4(profileController),
                  //FIFTH TAB
                  profileController.dayFiveImageModel == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : profileController.dayFiveImageModel!.images.isEmpty
                          ? const Center(
                              child: CustomText(
                                  headingStr:
                                      "Photos will be available after event"),
                            )
                          : dayTabImageList5(profileController),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  dayTabImageList(
    ProfileController profileController,
  ) =>
      Center(
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: profileController
                                  .dayImageModel!.images[index].id,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            'https://smb.inet.africa:8080/api/user/image/${profileController.dayImageModel!.images[index].id}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  profileController.dayImageModel!.images[index].comment.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: CustomText(
                            maxLines: 2,
                            headingStr: profileController
                                .dayImageModel!.images[index].comment,
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
            childCount: profileController.dayImageModel!.images.length,
          ),
        ),
      );

  dayTabImageList2(
    ProfileController profileController,
  ) =>
      Center(
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: profileController
                                  .dayTwoImageModel!.images[index].id,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            'https://smb.inet.africa:8080/api/user/image/${profileController.dayTwoImageModel!.images[index].id}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  profileController
                          .dayTwoImageModel!.images[index].comment.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: CustomText(
                            maxLines: 2,
                            headingStr: profileController
                                .dayTwoImageModel!.images[index].comment,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            childCount: profileController.dayTwoImageModel!.images.length,
          ),
        ),
      );

  dayTabImageList3(
    ProfileController profileController,
  ) =>
      Center(
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: profileController
                                  .dayThreeImageModel!.images[index].id,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            'https://smb.inet.africa:8080/api/user/image/${profileController.dayThreeImageModel!.images[index].id}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  profileController
                          .dayThreeImageModel!.images[index].comment.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: CustomText(
                            maxLines: 2,
                            headingStr: profileController
                                .dayThreeImageModel!.images[index].comment,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            childCount: profileController.dayThreeImageModel!.images.length,
          ),
        ),
      );

  dayTabImageList4(
    ProfileController profileController,
  ) =>
      Center(
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: profileController
                                  .dayFourImageModel!.images[index].id,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            'https://smb.inet.africa:8080/api/user/image/${profileController.dayFourImageModel!.images[index].id}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  profileController
                          .dayFourImageModel!.images[index].comment.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: CustomText(
                            maxLines: 2,
                            headingStr: profileController
                                .dayFourImageModel!.images[index].comment,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            childCount: profileController.dayFourImageModel!.images.length,
          ),
        ),
      );

  dayTabImageList5(
    ProfileController profileController,
  ) =>
      Center(
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: profileController
                                  .dayFiveImageModel!.images[index].id,
                            ),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.network(
                            'https://smb.inet.africa:8080/api/user/image/${profileController.dayFiveImageModel!.images[index].id}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  profileController
                          .dayFiveImageModel!.images[index].comment.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: CustomText(
                            maxLines: 2,
                            headingStr: profileController
                                .dayFiveImageModel!.images[index].comment,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            childCount: profileController.dayFiveImageModel!.images.length,
          ),
        ),
      );
}
