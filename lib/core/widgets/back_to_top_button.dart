// lib/core/widgets/back_to_top_button.dart
import 'package:flutter/material.dart';

class BackToTopButton extends StatelessWidget {
  final VoidCallback onTap;

  const BackToTopButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 230,
      right: 24,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}