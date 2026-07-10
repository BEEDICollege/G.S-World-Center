// lib/core/widgets/app_bar/app_bar_logo.dart
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 400;
        
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo with Glow
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/logos/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'GS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Company Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'GS World Center',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                if (!isMobile)
                  const Text(
                    'Premium Software Solutions',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white60,
                      letterSpacing: 0.5,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}