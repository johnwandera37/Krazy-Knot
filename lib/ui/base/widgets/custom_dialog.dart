import '../../../utils/export_files.dart';
void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: CustomText(
            headingStr: title,
            weight: TextWeight.bold,
          ),
          content: CustomText(headingStr: content),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          actions: actions,
        ),
      ),
    ),
  );
}
