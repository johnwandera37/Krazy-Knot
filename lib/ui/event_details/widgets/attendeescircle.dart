import 'dart:math';
import 'package:photomanager/utils/export_files.dart';

class UsersCircle extends StatelessWidget {
  final int numberOfUsers;
  final String type;

  UsersCircle({
    required this.numberOfUsers,
    required this.type
    });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(numberOfUsers, type),
      child: Container(
        width: 60.0, // Adjust the size of the circle as needed
        height: 60.0,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final int numberOfUsers;
  final String type;

  CirclePainter(this.numberOfUsers, this.type);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color =  MyUtils().getColorForEventType(type)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    // Draw the circle
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw the text (number of users) in the center of the circle
    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      text: numberOfUsers.toString(),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, Offset(centerX - tp.width / 2, centerY - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
