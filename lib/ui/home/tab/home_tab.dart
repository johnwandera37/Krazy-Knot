import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../utils/export_files.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: phoneMaxWidth,
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(       
              preferredSize:const Size.fromHeight(40.0),
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
            
            body: TabBarView(
              children: [
                Center(
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
                Center(child: Text('Tab 2')),
                Center(child: Text('Tab 3')),
                Center(child: Text('Tab 4')),
                Center(child: Text('Tab 5')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
