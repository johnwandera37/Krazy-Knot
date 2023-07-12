import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    const HomeTab(),
    const AddPhotoTab(),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void _onDrawerItemTap(int index) {
      setState(() {
        _currentIndex = index;
        Navigator.pop(context);
      });
    }

    return Center(
      child: SizedBox(
        width: Get.width,
        child: Scaffold(
          body: bottomBarPages[_currentIndex],
          key: _scaffoldKey,
          extendBody: true,
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Navigation Drawer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  onTap: () => _onDrawerItemTap(0),
                ),
                ListTile(
                  title: Text('Notifications'),
                  onTap: () => _onDrawerItemTap(1),
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () => _onDrawerItemTap(2),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            title: Text(
              Constants.appName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sacramento(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                height: 1.3,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black,),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
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
    );
  }
}
