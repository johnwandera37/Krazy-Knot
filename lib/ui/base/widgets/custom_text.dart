

import '../../../utils/export_files.dart';

enum TextWeight { normal, semiBold, bold }

enum TextAlignOption { center, left, right }

enum TextDecorationOption { underline, none }

class CustomText extends StatelessWidget {
  final String headingStr;
  final double? fontSize;
  final TextWeight? weight;
  final TextAlignOption? align;
  final double? textHeight;
  final int? maxLines;
  final TextDecorationOption? decoration;
  final Function? onTap;
  final double? marginTop;
  final double? marginBottom;
  final Color? fontColor;
  const CustomText({
    super.key,
    required this.headingStr,
    this.fontSize,
    this.weight,
    this.textHeight,
    this.onTap,
    this.maxLines,
    this.decoration = TextDecorationOption.none,
    this.align = TextAlignOption.left,
    this.marginTop,
    this.marginBottom,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = FontWeight.normal;
    TextDecoration? textDecoration;
    TextAlign? textAlign;

    // TEXT WEIGHT
    if (weight == TextWeight.bold) {
      fontWeight = FontWeight.w700;
    } else if (weight == TextWeight.semiBold) {
      fontWeight = FontWeight.w600;
    } else {
      fontWeight = FontWeight.w400;
    }

    // TEXT DECORATION
    if (decoration == TextDecorationOption.underline) {
      textDecoration = TextDecoration.underline;
    }

    // TEXT ALIGN
    if (align == TextAlignOption.center) {
      textAlign = TextAlign.center;
    } else if (align == TextAlignOption.right) {
      textAlign = TextAlign.right;
    } else {
      textAlign = TextAlign.left;
    }

    return Obx(
      () => GestureDetector(
        onTap: onTap == null
            ? () {}
            : () {
                onTap!();
              },
        child: Container(
          margin: EdgeInsets.only(
            bottom: marginBottom ?? 0.0,
            top: marginTop ?? 0.0,
          ),
          child: Text(
            headingStr,
            textAlign: textAlign,
            maxLines: maxLines ?? 3, 
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight,
              height: textHeight ?? 1.0,
              decoration: textDecoration,
            ),
          ),
        ),
      ),
    );
  }
}
