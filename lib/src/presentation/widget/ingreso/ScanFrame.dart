import 'package:flutter/material.dart';

class ScanFrame extends StatefulWidget {
  @override
  State<ScanFrame> createState() => ScanFrameState();
}

class ScanFrameState extends State<ScanFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _anim = Tween(begin: 0.1, end: 0.9).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final width = c.maxWidth * 0.78;
      final height = width * 0.62;

      return Center(
        child: Stack(
          children: [
            // Marco
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
                boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black54)],
              ),
            ),
            // Esquinas
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: CustomPaint(
                  painter: _CornersPainter(color: Colors.white),
                ),
              ),
            ),
            // “Láser” animado
            AnimatedBuilder(
              animation: _anim,
              builder: (_, __) {
                return Positioned(
                  left: 10,
                  right: 10,
                  top: height * _anim.value,
                  child: Opacity(
                    opacity: 0.75,
                    child: Container(height: 2, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

class _CornersPainter extends CustomPainter {
  final Color color;
  _CornersPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 22.0;
    // Esquinas
    // TL
    canvas.drawLine(const Offset(0, 0), const Offset(len, 0), p);
    canvas.drawLine(const Offset(0, 0), const Offset(0, len), p);
    // TR
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - len, 0), p);
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), Paint()..color = Colors.transparent);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), p);
    // BL
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), p);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - len), p);
    // BR
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - len, size.height), p);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - len), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
