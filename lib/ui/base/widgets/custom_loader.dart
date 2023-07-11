import '../../../utils/export_files.dart';

class CustomLoader extends StatelessWidget {
  final Color? myColor;
  final double? size;
  // ignore: use_key_in_widget_constructors
  const CustomLoader({
    this.myColor,
    this.size,
  });
        
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(     
      color: myColor ?? Colors.black,      
      strokeWidth: size ?? 1.5,   
    );
  }
}
