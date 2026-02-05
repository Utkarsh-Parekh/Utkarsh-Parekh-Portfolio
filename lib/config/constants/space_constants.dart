import 'package:flutter/material.dart';

class AppSpacing {
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;


  // Section padding
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 48.0,
  );

  static const EdgeInsets sectionPaddingMobile = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 32.0,
  );
}


// For Responsiveness
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}
