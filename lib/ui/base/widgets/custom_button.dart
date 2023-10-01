

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
    var themeController = Get.put(ThemeController());
    return GestureDetector(
          onTap: () {
            onTap();
          },
          
          child:Container(
           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: inputDecoration(),
            child: GestureDetector( 
              onTap: () {
                onTap();    
              },
              child: Text(
                buttonStr,
                style: GoogleFonts.karla(
                  color: themeController.fontColor,   
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ),
          )
        );
      
    
  }
}


// child: NeumorphicButton(
          //   margin: EdgeInsets.symmetric(
          //     vertical: vertMargin ?? 0.0,
          //   ),
          //   onPressed: () {
          //     onTap();     
          //   },
          //   style: NeumorphicStyle(
          //     shape: NeumorphicShape.flat,
          //     color: themeController.backgroundColor,
          //     shadowLightColor: themeController.shadowLightColor, //Color(0xFF333333),
          //     boxShape: NeumorphicBoxShape.roundRect(
          //       BorderRadius.circular(30),           
          //     ),
          //     //border: NeumorphicBorder()
          //   ),
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 50,
          //     vertical: 18,
          //   ),


          // ),