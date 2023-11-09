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
  double angle = 1.0;

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

    // painting farthest circle
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Color(0xFFBBDEFB).withOpacity(0.4),
    );

    // painting the gradient circle
    final gradient = ui.Gradient.sweep(
      center,
      [Colors.blue, Colors.blue.withOpacity(0.3)],
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
      4.0,
      true,
    );

    // painting inner holder
    canvas.drawCircle(
        center, size.width * 0.05, Paint()..color = Colors.blue.shade100);

    double angleInRadians = angle * math.pi / 180;

    // painting the hour hand
    // TODO fix the rotation when cursor is panning
    double hourHandLength = size.width * 0.4;
    double hourHandX = center.dx + hourHandLength * math.cos(angleInRadians);
    double hourHandY = center.dy + hourHandLength * math.sin(angleInRadians);

    canvas.drawLine(
      center,
      Offset(hourHandX, hourHandY),
      Paint()
        ..color = Colors.blue.shade800
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );

    // painting outer holder shadow
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: center,
            radius: size.width * 0.03,
          ),
        ),
      Colors.black,
      3.0, // Shadow elevation
      true, // Whether to include the shape in the shadow calculation
    );

    // painting outer holder
    canvas.drawCircle(center, size.width * 0.03, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
