import 'package:photomanager/utils/export_files.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color?iconColor;
  final Color? bacIconColor;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.bacIconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bacIconColor ??Colors.white,
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
