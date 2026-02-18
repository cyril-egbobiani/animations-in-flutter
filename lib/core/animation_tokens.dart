import 'package:flutter/animation.dart';

class MotionDurations {
  static const fast = Duration(milliseconds: 100);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 700);
}

class MotionCurves {
  static const emphasized = Curves.easeOutCubic;
  static const settle = Curves.easeInOutCubic;
  static const playful = Curves.elasticOut;
}
