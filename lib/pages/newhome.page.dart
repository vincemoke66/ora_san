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
  double angle = 15 * 360 / 60;

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
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            double futureAngle = angle + details.delta.dy;
                            if (futureAngle < 360 && futureAngle > 0) {
                              setState(() {
                                angle += details.delta.dy;
                              });
                            }
                          },
                          child: CustomPaint(
                            painter: PomoClockCustomPainter(
                              angle: angle,
                            ),
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

class PomoClockCustomPainter extends CustomPainter {
  final double angle;

  PomoClockCustomPainter({
    required this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Center of the canvas
    final center = size.center(Offset.zero);

    // Radius of the circle
    final radius = size.width / 4;

    // Convert degrees to radians for the start angle
    const startAngle = 0.0;

    // Convert percentage to radians for the sweep angle
    final sweepAngle = angle * math.pi / 180;

    // painting outer strokes
    var outerRadius = size.width / 2.5;
    var innerRadius = size.width / 2.5 * 0.9;
    var outerRadiusSmall = size.width / 2.55;
    var innerRadiusSmall = size.width / 2.5 * 0.95;

    // small outer strokes
    for (var i = 0; i < 360; i += 6) {
      var x1 = center.dx + outerRadiusSmall * math.cos(i * math.pi / 180);
      var y1 = center.dy + outerRadiusSmall * math.sin(i * math.pi / 180);

      var x2 = center.dx + innerRadiusSmall * math.cos(i * math.pi / 180);
      var y2 = center.dy + innerRadiusSmall * math.sin(i * math.pi / 180);
      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.blueGrey.shade100
            ..strokeWidth = size.width / 150
            ..strokeCap = StrokeCap.round);
    }

    // large outer strokes
    for (var i = 0; i < 360; i += 30) {
      var x1 = center.dx + outerRadius * math.cos(i * math.pi / 180);
      var y1 = center.dy + outerRadius * math.sin(i * math.pi / 180);

      var x2 = center.dx + innerRadius * math.cos(i * math.pi / 180);
      var y2 = center.dy + innerRadius * math.sin(i * math.pi / 180);
      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.blueGrey
            ..strokeWidth = size.width / 150
            ..strokeCap = StrokeCap.round);
    }

    // painting farthest circle
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Color(0xFFBBDEFB).withOpacity(0.4),
    );

    // painting the gradient circle
    final gradient = ui.Gradient.sweep(
      center,
      [
        Colors.blue.shade700.withOpacity(mapValues(angle, 0.5, 1.0)),
        Colors.blue.withOpacity(mapValues(angle, 0.0, 0.4)),
      ],
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

    // painting inner holder shadow
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: center,
            radius: size.width * 0.05,
          ),
        ),
      Colors.black45,
      8.0,
      true,
    );

    // painting inner holder
    canvas.drawCircle(
        center, size.width * 0.05, Paint()..color = Colors.blue.shade100);

    double angleInRadians = angle * math.pi / 180;

    // painting the hour hand
    // TODO fix the rotation when cursor is panning
    double hourHandLength = size.width * 0.37;
    double hourHandX = center.dx + hourHandLength * math.cos(angleInRadians);
    double hourHandY = center.dy + hourHandLength * math.sin(angleInRadians);

    Path hourHandShadowPath = Path();
    hourHandShadowPath.moveTo(center.dx, center.dy);
    hourHandShadowPath.lineTo(hourHandX, hourHandY);

    // painting our hand shadow
    canvas.drawPath(
      hourHandShadowPath,
      Paint()
        ..color = Colors.blue.withOpacity(1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 40
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10),
    );

    // painting hour hand without shadow
    canvas.drawLine(
      center,
      Offset(hourHandX, hourHandY),
      Paint()
        ..color = Colors.blue.shade800
        ..strokeWidth = size.width / 50
        ..strokeCap = StrokeCap.round,
    );

    // painting outer holder shadow
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: center,
            radius: size.width * 0.035,
          ),
        ),
      Colors.black,
      3.0, // Shadow elevation
      true, // Whether to include the shape in the shadow calculation
    );

    // painting outer holder
    canvas.drawCircle(
        center, size.width * 0.035, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

double mapValues(double inputValue, double min, double max) {
  int minValue = 0;
  int maxValue = 360;
  List<double> outputRange = [min, max];

  // Ensure the input is within the specified range
  inputValue = inputValue.clamp(minValue, maxValue).toDouble();

  // Map the input value to the output range
  double mappedValue = (inputValue - minValue) /
          (maxValue - minValue) *
          (outputRange[1] - outputRange[0]) +
      outputRange[0];

  return mappedValue;
}
