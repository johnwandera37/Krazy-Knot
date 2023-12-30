import 'package:photomanager/utils/export_files.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor,
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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
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
