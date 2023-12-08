import 'package:photomanager/utils/export_files.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final double? horizPadding;
  final double? vertPadding;
  final String? prefixIconPath;
  final TextEditingController textEditingController;
  final bool obscureText;
  final bool enabled;
  final String? initialValue;
  const CustomInput({
    super.key,
    required this.hintText,
    this.horizPadding,
    this.vertPadding,
    this.prefixIconPath,
    required this.textEditingController,
    this.obscureText = false,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    double errorFontSize = 11;
    return Container(
      height: 58,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        horizontal: horizPadding ?? 40,
        vertical: vertPadding ?? 0.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: Center(
        child: prefixIconPath != null
            ? Neumorphic(
                style: neumorphicStyle(),
                child: TextFormField(
                  enabled: true,
                  // initialValue: '',
                  controller: textEditingController,
                  obscureText: obscureText,
                  decoration:
                      inputDecorationWithPrefix(errorFontSize: errorFontSize),
                  style: inputTextStyle(),
                ),
              )
            // NO PREFIX ICON
            : Neumorphic(
                style: neumorphicStyle(),
                child: TextFormField(
                  enabled: true,
                  // initialValue: '',
                  controller: textEditingController,
                  obscureText: obscureText,
                  decoration: inputDecoration(
                    errorFontSize: errorFontSize,
                  ),
                  style: inputTextStyle(),
                ),
              ),
      ),
    );
  }

  _underlineInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      );

  inputTextStyle({Color? color, double? size}) => GoogleFonts.montserrat(
        fontSize: size ?? 16,
        fontWeight: FontWeight.w500,
        color: color ?? Colors.black,
      );

  inputDecoration({
    required double errorFontSize,
  }) =>
      InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        enabledBorder: _underlineInputBorder(),
        focusedBorder: _underlineInputBorder(),
        hintStyle: inputTextStyle(),
        errorStyle: inputTextStyle(
          color: Colors.red,
          size: errorFontSize,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
      );

  neumorphicStyle() => NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: -12,
        intensity: 0.6,
        color: Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(30.0),
        ),
      );

  inputDecorationWithPrefix({
    required double errorFontSize,
  }) =>
      InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            prefixIconPath ?? '',
            width: 35,
            height: 35,
            fit: BoxFit.fill,
          ),
        ),
        border: InputBorder.none,
        hintText: hintText,
        enabledBorder: _underlineInputBorder(),
        focusedBorder: _underlineInputBorder(),
        hintStyle: inputTextStyle(),
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
