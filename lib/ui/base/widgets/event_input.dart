import 'package:photomanager/utils/export_files.dart';

class Eventnput extends StatelessWidget {
  final String hintText;
  final double? horizPadding;
  final double? vertPadding;
  final String? suffixIconPath;
  final int? maxLines;
  final TextEditingController? textEditingController;
  final List<String>? dropdownItems;
  final String? selectedDropdownValue;
  final void Function(String?)? onDropdownChanged;
  final bool readOnly;
  final String? initialValue;
  

  const Eventnput({
    super.key,
    required this.hintText,
    this.horizPadding,
    this.vertPadding,
    this.suffixIconPath,
    this.textEditingController,
    this.dropdownItems,
    this.selectedDropdownValue,
    this.onDropdownChanged,
    this.maxLines,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    double errorFontSize = 11;
      final isDescriptionInput = maxLines != null && maxLines! > 1;

    return 
      Container(
        height:isDescriptionInput ? null : 50,
        width: Get.width,
        margin: EdgeInsets.symmetric(
          horizontal: horizPadding ?? 15,
          vertical: vertPadding ?? 0.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: Center(
          child:
          
          dropdownItems != null? // Check if dropdown items are provided
          DropdownButtonFormField<String>(
                        value: selectedDropdownValue,
                        onChanged: onDropdownChanged,
                        items: [
                           DropdownMenuItem<String>(
                            value: null,
                            child: CustomText(headingStr: 'Select type of event', fontColor: HexColor("9A9A9A"),), // Placeholder text
                          ),
                          ...dropdownItems!.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        })
                        ],
                        decoration:inputDecoration(errorFontSize: errorFontSize),
                        style: inputTextStyle(),
                        // icon: MyNeumorphicIcon(
                        // iconColor: themeController.fontColor,
                        // iconData: Icons.arrow_drop_down,
                        // size: 25,
                        // ),
                        // dropdownColor: themeController.backgroundColor, 
                      // ),
                    ):
          //with suffix
          suffixIconPath != null
              ? TextFormField(
                    controller: textEditingController,
                    decoration:
                        inputDecorationWithSuffix(errorFontSize: errorFontSize),
                    style: inputTextStyle(),
                    maxLines: maxLines?? 1,
                    readOnly: readOnly,
                    initialValue: initialValue,
                  )
                
              // NO PREFIX ICON
              : TextFormField(
                    controller: textEditingController,
                    decoration: inputDecoration(errorFontSize: errorFontSize),
                    style: inputTextStyle(),
                    maxLines: maxLines?? 1,
                    readOnly: readOnly,
                    initialValue: initialValue,
                  ),
                
        ),
      );
  }

  inputTextStyle({Color? color, double? size}) => GoogleFonts.karla(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? Colors.black,
      );
  hintTextStyle({Color? color, double? size}) => GoogleFonts.karla(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? HexColor("9A9A9A"),
      );
borderSide()=>  OutlineInputBorder(
        borderSide: BorderSide(
          color: HexColor("9A9A9A"),
        ),
        borderRadius: BorderRadius.circular(10),
      );

enableBorder()=>OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      );
focusedBorder()=>OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      );    

  inputDecoration({
  required double errorFontSize,
}) =>
    InputDecoration(
      border: borderSide(),
      filled: true,
      fillColor: Colors.white,//will change for dark theme
      hintText: hintText,
      enabledBorder:enableBorder(), 
      focusedBorder: focusedBorder(),
      hintStyle: hintTextStyle(),
      errorStyle: inputTextStyle(
        color: Colors.red,
        size: errorFontSize,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 20.0,
      ),
    );


  inputDecorationWithSuffix({
    required double errorFontSize,
  }) =>
      InputDecoration(
        suffixIcon: Container(
          padding:const EdgeInsets.only(left: 10),
          child: 
          Image.asset(
            suffixIconPath ?? '',
            width: 30,
            height: 18,
            fit: BoxFit.fill,
          ),
        ),
        border: borderSide(),
        filled: true,
      fillColor: Colors.white,//will change for dark theme
        hintText: hintText,
        enabledBorder: enableBorder(),
        focusedBorder: focusedBorder(),
        hintStyle: hintTextStyle(),
        errorStyle: inputTextStyle(
          color: Colors.red,
          size: errorFontSize,
        ),         
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
      );
}
