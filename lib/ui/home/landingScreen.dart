import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/ui/profile/preview_screen.dart';
import 'package:photomanager/ui/profile/view_qr_screen.dart';
//import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

export 'package:photomanager/controllers/profile_controller.dart';
import '../../utils/export_files.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    EventTab(),
    const HomeTab(),
    const ProfileTab(),
    CancelledEvents(),
    ViewQrScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var themeController = Get.put(ThemeController());
    Get.find<ProfileController>().profileData();

    void _onDrawerItemTap(int index) {
      setState(() {
        _currentIndex = index;
        Navigator.pop(context);
      });
    }

    return GetBuilder<ProfileController>(builder: (profileController) {
      return Center(
        child: SizedBox(
          width: Get.width,
          child: SafeArea(
            child: Scaffold(
              body: bottomBarPages[_currentIndex],
              key: _scaffoldKey,
              extendBody: true,
              endDrawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    sizedHeight(Get.height * .06),
                    profileController.userInfo == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: const NeumorphicBoxShape.circle(),
                                  depth: 8,
                                  intensity: 0.6,
                                  color: themeController.backgroundColor,
                                  shadowDarkColor:
                                      themeController.shadowDarkColor,
                                  shadowLightColor:
                                      themeController.shadowLightColor,
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      themeController.backgroundColor,
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
                            ],
                          ),
                    profileController.userInfo == null
                        ? Container()
                        : sizedHeight(Get.height * .05),
                    profileController.userInfo == null
                        ? Container()
                        : Center(
                            child: CustomText(
                              headingStr:
                                  '${profileController.userInfo!.firstName} ${profileController.userInfo!.lastName}',
                              weight: TextWeight.semiBold,
                              fontSize: 19,
                            ),
                          ),
                    profileController.userInfo == null
                        ? Container()
                        : sizedHeight(Get.height * .03),
                    profileController.userInfo == null
                        ? Container()
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Get.width * .05),
                            child: GestureDetector(
                              onTap: () => Get.to(PreviewScreen()),
                              child: Container(
                                //width: 120,
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
                          ),
                    profileController.userInfo == null
                        ? Container()
                        : sizedHeight(Get.height * .03),
                        //menu items
                    ListTile(
                      leading: Icon(Icons.home),
                      title: CustomText(
                          headingStr: 'Home',
                          onTap: () => _onDrawerItemTap(
                                0,
                              )),
                      onTap: () => _onDrawerItemTap(0),
                    ),
                    ListTile(
                      leading: Icon(Icons.picture_in_picture_alt),
                      title: CustomText(
                          headingStr: 'Event Gallery',
                          onTap: () => _onDrawerItemTap(
                                1,
                              )),
                      onTap: () => _onDrawerItemTap(1),
                    ),
                    ListTile(
                      leading: Icon(Icons.picture_in_picture_alt),
                      title: CustomText(
                          headingStr: 'Social Gallery',
                          onTap: () => _onDrawerItemTap(
                                2,
                              )),
                      onTap: () => _onDrawerItemTap(2),
                    ),
                    ListTile(
                      leading: Icon(Icons.cancel),
                      title: CustomText(
                          headingStr: 'Cancelled Events',
                          onTap: () => _onDrawerItemTap(
                                3,
                              )),
                      onTap: () => _onDrawerItemTap(3),
                    ),
                    ListTile(
                      leading: Icon(Icons.qr_code),
                      title: CustomText(
                          headingStr: 'Scan QR',
                          onTap: () => _onDrawerItemTap(
                                4,
                              )),
                      onTap: () => _onDrawerItemTap(4),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_outlined,
                       // color: Colors.red,
                      ),
                      title: CustomText(
                          headingStr: 'Log OUt',
                          fontColor: Colors.red,
                          onTap: () => Get.find<AuthController>().logOut()),
                      onTap: () => Get.find<AuthController>().logOut(),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  Constants.appName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.karla(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    height: 1.3,
                  ),
                ),
                backgroundColor: HexColor("F7F7F7"),
                actions: [
                   IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                       Get.to(InvitationForm());
                    },
                  ),
                  SizedBox(
                    width: 6,
                  ),


                  // IconButton(
                  //   icon: Icon(
                  //     Icons.qr_code,
                  //     color: Colors.black,
                  //   ),
                  //   onPressed: () {
                  //     Get.to(ViewQrScreen());
                  //   },
                  // ),
                  // SizedBox(
                  //   width: 6,
                  // ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              // bottomNavigationBar: SalomonBottomBar(
              //   currentIndex: _currentIndex,
              //   onTap: (i) => setState(() => _currentIndex = i),
              //   items: [
              //     /// Home
              //     SalomonBottomBarItem(
              //       icon: Icon(Icons.home),
              //       title: CustomText(headingStr: 'Home'),
              //       selectedColor: Colors.purple,
              //     ),

              //     /// Likes
              //     SalomonBottomBarItem(
              //       icon: Icon(Icons.favorite_border),
              //       title: CustomText(headingStr: 'Add Photo'),
              //       selectedColor: Colors.pink,
              //     ),

              //     /// Profile
              //     SalomonBottomBarItem(
              //       icon: Icon(Icons.person),
              //       title: CustomText(headingStr: 'Profile'),
              //       selectedColor: Colors.teal,
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      );
    });
    ;
  }
}
