import 'package:photomanager/utils/export_files.dart';

class CustomInput extends StatefulWidget {
  final String hintText;
  final double? horizPadding;
  final double? vertPadding;
  final String? prefixIconPath;
  final TextEditingController textEditingController;
  final bool obscureText;

   CustomInput({
    super.key,
    required this.hintText,
    this.horizPadding,
    this.vertPadding,
    this.prefixIconPath,
    required this.textEditingController,
    this.obscureText = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isPasswordVisible = true; // Track password visibility state
  @override
  Widget build(BuildContext context) {
    double errorFontSize = 11;
    return Container(
      height: 58,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        horizontal: widget.horizPadding ?? 20,
        vertical: widget.vertPadding ?? 0.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: Center(
        child: widget.prefixIconPath != null
            ? Neumorphic(
                style: neumorphicStyle(),
                child: TextFormField(
                  controller: widget.textEditingController,
                  obscureText: widget.obscureText? _isPasswordVisible: false,
                  decoration:
                      inputDecorationWithPrefix(errorFontSize: errorFontSize),
                  style: inputTextStyle(),
                ),
              )
            // NO PREFIX ICON
            : Neumorphic(
                style: neumorphicStyle(),
                child: TextFormField(
                  controller: widget.textEditingController,
                  obscureText: widget.obscureText? _isPasswordVisible: false,
                  decoration: inputDecoration(
                    errorFontSize: errorFontSize,
                  ),
                  style: inputTextStyle(),
                ),
              ),
      ),
    );
  }
      passwordVisibility()=> widget.obscureText?
       IconButton(
            onPressed: () {
              setState(() {
               _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
              });
            },
            icon: Icon(
             _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            //  color: themeController.shadowDarkColor,
            ),
          )
        : null;

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
        hintText: widget.hintText,
        enabledBorder: _underlineInputBorder(),
        focusedBorder: _underlineInputBorder(),
        suffixIcon: passwordVisibility(),
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
            widget.prefixIconPath ?? '',
            width: 35,
            height: 35,
            fit: BoxFit.fill,
          ),
        ),
        suffixIcon: passwordVisibility(),
        border: InputBorder.none,
        hintText: widget.hintText,
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