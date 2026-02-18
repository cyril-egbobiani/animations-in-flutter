import 'package:flutter/material.dart';

import '../core/animation_tokens.dart';

class BouncyButton extends StatefulWidget {
  const BouncyButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1,
      lowerBound: 0.9,
      upperBound: 1,
    );
    _scale = CurvedAnimation(parent: _controller, curve: MotionCurves.playful);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.animateTo(
      0.95,
      duration: MotionDurations.fast,
      curve: Curves.easeOut,
    );
  }

  void _onTapCancel() {
    _controller.animateTo(
      1,
      duration: MotionDurations.normal,
      curve: MotionCurves.playful,
    );
  }

  void _onTapUp(TapUpDetails _) {
    _controller.animateTo(
      1,
      duration: const Duration(milliseconds: 400),
      curve: MotionCurves.playful,
    );
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}
