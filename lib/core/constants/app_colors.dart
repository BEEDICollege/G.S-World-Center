// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color primaryGreen = Color(0xFF10B981);
  static const Color primaryPink = Color(0xFFEC4899);
  
  static const Color darkBackground = Color(0xFF0A1628);
  static const Color darkSurface = Color(0xFF0D2B3E);
  static const Color darkCard = Color(0xFF0F3D3D);
  
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryCyan, primaryGreen, primaryBlue],
  );
  
  static const Gradient blueGreenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF06B6D4),
      Color(0xFF10B981),
      Color(0xFF0D2B3E),
    ],
  );
  
  static const Gradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryCyan, primaryBlue, primaryPurple],
  );
  
  static const Gradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1AFFFFFF),
      Color(0x0AFFFFFF),
    ],
  );
}