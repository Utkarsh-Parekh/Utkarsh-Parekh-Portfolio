
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors
  static const Color primaryPurple = Color(0xFF6C5CE7);
  static const Color primaryBlue = Color(0xFF00D2FF);
  static const Color primaryCyan = Color(0xFF0ABDE3);

  // Background Colors
  static const Color darkBackground = Color(0xFF0F0F1A);
  static const Color cardBackground = Color(0xFF1A1A2E);
  static const Color cardBackgroundLight = Color(0xFF16213E);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C3);
  static const Color textMuted = Color(0xFF6B6B80);

  // Accent Colors
  static const Color accentOrange = Color(0xFFFD7014);
  static const Color accentGreen = Color(0xFF00D26A);
  static const Color accentPink = Color(0xFFFF6B9D);

  // Language Colors (for tech stack)
  static const Color dartColor = Color(0xFF0175C2);
  static const Color kotlinColor = Color(0xFF7F52FF);
  static const Color javaColor = Color(0xFFED8B00);
  static const Color pythonColor = Color(0xFF3776AB);
  static const Color javascriptColor = Color(0xFFF7DF1E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentOrange, accentPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
