
import '../../../utils/export_files.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double imageWidth;
  final double imageHeight;
  final bool? isAnimation;
  final Function? onTap;
  const CustomImage({
    super.key,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    this.onTap,
    this.isAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Center(
        child: isAnimation ?? false
            ? Lottie.asset(
                image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.fill,
              )
            : Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    
                    image: AssetImage(image),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
      ),
    );
  }
}
