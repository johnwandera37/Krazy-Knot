

import '../../../utils/export_files.dart';

class CustomButton extends StatelessWidget {
  final String buttonStr;
  final double? vertMargin;
  final Function onTap;
  const CustomButton({
    super.key,
    required this.buttonStr,
    this.vertMargin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    return GestureDetector(
          onTap: () {
            onTap();
          },
          child: NeumorphicButton(
            margin: EdgeInsets.symmetric(
              vertical: vertMargin ?? 0.0,
            ),
            onPressed: () {
              onTap();     
            },
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              color: themeController.backgroundColor,
              shadowLightColor: themeController.shadowLightColor, //Color(0xFF333333),
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(30),           
              ),
              //border: NeumorphicBorder()
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 18,
            ),
            child: GestureDetector( 
              onTap: () {
                onTap();    
              },
              child: Text(
                buttonStr,
                style: GoogleFonts.montserrat(
                  color: themeController.fontColor,   
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
            ),
          ),
        );
      
    
  }
}
