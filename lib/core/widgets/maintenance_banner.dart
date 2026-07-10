// lib/core/widgets/maintenance_banner.dart
import 'package:flutter/material.dart';

class MaintenanceBanner extends StatelessWidget {
  final bool showBanner;
  
  const MaintenanceBanner({
    super.key,
    this.showBanner = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    if (!showBanner) return const SizedBox.shrink();
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B00), Color(0xFFFFD700)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.engineering,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            '🔧 We are currently improving our services. Some features may be temporarily unavailable.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}