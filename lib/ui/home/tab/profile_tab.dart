import '../../../utils/export_files.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    var profileController = Get.find<ProfileController>();
    return Center(
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
                Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: const NeumorphicBoxShape.circle(),
                    depth: 8,
                    intensity: 0.6,
                    color: themeController.backgroundColor,
                    shadowDarkColor: themeController.shadowDarkColor,
                    shadowLightColor: themeController.shadowLightColor,
                  ),
                  child: CircleAvatar(
                    backgroundColor: themeController.backgroundColor,
                    radius: 40.0,
                    child: const Center(
                      child: CustomText(
                        headingStr: 'LW',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            sizedHeight(Get.height * .05),
            CustomText(
              headingStr: 'Levi Wasike',
              weight: TextWeight.semiBold,
              fontSize: 19,
            ),
            sizedHeight(Get.height * .03),
            GestureDetector(
              onTap: () => profileController.pickImages(),
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
                    onTap: ()=>profileController.pickImages(),
                  ),
                ),
              ),
            ),
            sizedHeight(Get.height * .03),
            Expanded(
              child: GridView.custom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        color: Colors.black54.withOpacity(.3)),
                    child: Center(
                      child: CustomText(
                        headingStr: index.toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
