import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // pomos counter
                  PomoCounter(),

                  SizedBox(
                    height: 12,
                  ),

                  // focus widget
                  Text(
                    "What's your focus?",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        hintText: "Intention for this Session",
                        hintStyle: GoogleFonts.inter(
                          color: Color(0xFF8e8e8e),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),

                  // custom clock widget
                  Container(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Transform.rotate(
                        angle: 3 * math.pi / 2,
                        child: CustomPaint(
                          painter: YourCustomPainter(
                            startAngleInDegrees: -90,
                            sweepPercentage: 0.75,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Row PomoCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 140,
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
              PomoIndicator(),
            ],
          ),
        ),
        SizedBox(
          width: 140,
        ),
      ],
    );
  }
}

class PomoClock extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var gap = 0.2;
    var backContainerRadius = size.width * gap;
    var innerHolderRadius = backContainerRadius * gap;
    var outerHolderRadius = innerHolderRadius - (innerHolderRadius * 0.3);

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var backCircleFill = Paint()..color = Color(0xFFF0D7D8);
    var innerHolderFill = Paint()..color = Color(0xFFFFF3EB);
    var outerHolderFill = Paint()..color = Color(0xFFFFFFFF);

    // painting back container
    canvas.drawCircle(center, backContainerRadius, backCircleFill);

    // painting container filler
    // var containerFillerFill = Paint()
    //   ..shader = RadialGradient(colors: [Color(0xFFCB5955), Color(0xFFF0D7D8)])
    //       .createShader(
    //           Rect.fromCircle(center: center, radius: backContainerRadius));
    // final containerFillerFill = RadialGradient(
    //   colors: [Colors.blue, Colors.green], // Adjust these colors as needed
    //   stops: [0.0, 1.0],
    //   center: Alignment(
    //       -math.cos((-90 * (math.pi / 180))), -math.sin((2 * math.pi * 0.75))),
    //   radius: 1.0,
    // );
    // ..style = PaintingStyle.stroke
    // ..strokeCap = StrokeCap.round
    // ..strokeWidth = 8;

    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: backContainerRadius),
    //   (-90 * (math.pi / 180)),
    //   (2 * math.pi * 0.75),
    //   true,
    //   containerFillerFill,
    //   // Paint()..color = Colors.blue // TODO change color to gradient
    // );

    // Convert degrees to radians for the start angle
    final startAngle = -90 * (math.pi / 180);

    // Convert percentage to radians for the sweep angle
    final sweepAngle = 2 * math.pi * 0.75;

    var radius = size.width * 0.2;

    // Create a sweep gradient that follows the arc
    final gradient = ui.Gradient.sweep(
      center,
      [
        Colors.amber,
        Colors.amber.withOpacity(0.1)
      ], // Adjust these colors and opacities as needed
      [0.0, 1.0],
      TileMode.clamp,
      startAngle,
      startAngle + sweepAngle,
    );

    // Use ShaderMask to apply the gradient to the drawArc
    canvas.saveLayer(
      Rect.fromCircle(center: center, radius: radius),
      Paint(),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      Paint(),
    );

    final maskPaint = Paint()..shader = gradient;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      maskPaint,
    );
    canvas.restore();

    // inner holder shadow
    canvas.drawShadow(
      Path()
        ..addOval(Rect.fromCircle(center: center, radius: innerHolderRadius)),
      Colors.black,
      3.0, // Shadow elevation
      true, // Whether to include the shape in the shadow calculation
    );

    // painting hour hand
    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(
              Rect.fromCircle(center: center, radius: size.width * 0.1))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawLine(center, Offset(centerX, size.width * 0.2), hourHandBrush);

    // painting inner holder
    canvas.drawCircle(center, innerHolderRadius, innerHolderFill);

    // painting outer holder shadow
    canvas.drawShadow(
      Path()
        ..addOval(Rect.fromCircle(center: center, radius: outerHolderRadius)),
      Colors.black,
      3.0, // Shadow elevation
      true, // Whether to include the shape in the shadow calculation
    );

    // painting outer holder
    canvas.drawCircle(center, outerHolderRadius, outerHolderFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PomoIndicator extends StatelessWidget {
  const PomoIndicator({
    super.key,
    this.isDone = false,
  });

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDone ? Colors.red.shade300 : Colors.blueGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      width: 12,
      height: 12,
    );
  }
}

class YourCustomPainter extends CustomPainter {
  final double sweepPercentage; // Value between 0.0 and 1.0
  final double startAngleInDegrees; // Value in degrees

  YourCustomPainter(
      {required this.sweepPercentage, required this.startAngleInDegrees});

  @override
  void paint(Canvas canvas, Size size) {
    // Center of the canvas
    final center = size.center(Offset.zero);

    // Radius of the circle
    final radius = size.width / 4;

    // Convert degrees to radians for the start angle
    final startAngle = 0.0;

    // Convert percentage to radians for the sweep angle
    final sweepAngle = 3 * math.pi / 2;

    // Calculate normalized start and end angles for the gradient
    final normalizedStartAngle = startAngle / (2 * math.pi);
    final normalizedEndAngle = (startAngle + sweepAngle) / (2 * math.pi);

    // Create a sweep gradient that follows the arc
    final gradient = ui.Gradient.sweep(
      center,
      [Colors.blue, Colors.blue.withOpacity(0.2)],
      [0, 1],
      TileMode.clamp,
      startAngle,
      startAngle + sweepAngle,
    );
    canvas.saveLayer(Rect.fromCircle(center: center, radius: radius), Paint());
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      Paint()..color = Colors.transparent,
    );
    final maskPaint = Paint()..shader = gradient;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      maskPaint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
