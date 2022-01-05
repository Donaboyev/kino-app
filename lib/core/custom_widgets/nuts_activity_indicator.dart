import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class NutsActivityIndicator extends StatefulWidget {
  final Duration animationDuration;
  final double relativeWidth;
  final Color inactiveColor;
  final Color activeColor;
  final double startRatio;
  final double endRatio;
  final bool animating;
  final double radius;
  final int tickCount;

  @override
  _NutsActivityIndicatorState createState() => _NutsActivityIndicatorState();

  const NutsActivityIndicator({
    Key? key,
    this.animating = true,
    this.radius = 10,
    this.startRatio = 0.5,
    this.endRatio = 1.0,
    this.tickCount = 12,
    this.activeColor = const Color(0xFF9D9D9D),
    this.inactiveColor = const Color(0xFFE5E5EA),
    this.animationDuration = const Duration(seconds: 1),
    this.relativeWidth = 1,
  }) : super(key: key);
}

class _NutsActivityIndicatorState extends State<NutsActivityIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    if (widget.animating) {
      _animationController!.repeat();
    }
  }

  @override
  void didUpdateWidget(NutsActivityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _animationController!.repeat();
      } else {
        _animationController!.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _NutsActivityIndicatorPainter(
          animationController: _animationController,
          radius: widget.radius,
          tickCount: widget.tickCount,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          relativeWidth: widget.relativeWidth,
          startRatio: widget.startRatio,
          endRatio: widget.endRatio,
        ),
      ),
    );
  }
}

class _NutsActivityIndicatorPainter extends CustomPainter {
  final int tickCount;
  final double radius;
  final double endRatio;
  final RRect _tickRRect;
  final double startRatio;
  final int _halfTickCount;
  final Color? activeColor;
  final Color? inactiveColor;
  final double relativeWidth;
  final Animation<double>? animationController;

  _NutsActivityIndicatorPainter({
    required this.radius,
    required this.tickCount,
    this.animationController,
    this.activeColor,
    this.inactiveColor,
    required this.relativeWidth,
    required this.startRatio,
    required this.endRatio,
  })  : _halfTickCount = tickCount ~/ 2,
        _tickRRect = RRect.fromLTRBXY(
          -radius * endRatio,
          relativeWidth * radius / 10,
          -radius * startRatio,
          -relativeWidth * radius / 10,
          1,
          1,
        ),
        super(repaint: animationController);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2);
    final activeTick = (tickCount * animationController!.value).floor();
    for (int i = 0; i < tickCount; ++i) {
      paint.color = Color.lerp(
        activeColor,
        inactiveColor,
        ((i + activeTick) % tickCount) / _halfTickCount,
      )!;
      canvas
        ..drawRRect(_tickRRect, paint)
        ..rotate(-math.pi * 2 / tickCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_NutsActivityIndicatorPainter oldPainter) {
    return oldPainter.animationController != animationController;
  }
}
